{
  description = "Dove: a suite of configurations & advanced modifications for Mozilla Thunderbird, designed to put the user first - with a focus on privacy, security, freedom, functionality, & usability.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    phoenix = {
      url = "git+https://codeberg.org/celenity/Phoenix";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      phoenix,
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      nixosModules = {
        default =
          {
            pkgs,
            config,
            lib,
            ...
          }:
          {
            options.programs.thunderbird.dove = {
              enable =
                lib.mkEnableOption "Enable privacy & security hardening of Thunderbird using the Dove configs"
                // {
                  default = true;
                };
              package = lib.mkOption {
                type = lib.types.package;
                default = self.packages.${pkgs.system}.dove;
                description = "The Dove package to use.";
                defaultText = lib.literalExpression "dove";
              };
              thunderbirdPackages = lib.mkOption {
                type = lib.types.listOf lib.types.string;
                default = [ "thunderbird" ];
                description = "The name of Thunderbird packages of current pkgs to patch with dove config and policy.";
              };
            };
            config =
              let
                cfg = config.programs.thunderbird.dove;
              in
              lib.mkIf cfg.enable {
                assertions = [
                  {
                    assertion = !pkgs.stdenv.isDarwin;
                    message = "Dove module has not been ported to nix-darwin yet. Contributions welcomed.";
                  }
                ];
                environment.etc."thunderbird/defaults/pref/dove.js".source = "${cfg.package}/prefs/dove.js";
                nixpkgs.overlays = [
                  (
                    self: super:
                    builtins.listToAttrs (
                      map (
                        p:
                        lib.nameValuePair p (
                          super.${p}.override {
                            extraPoliciesFiles = [ "${cfg.package}/policies.json" ];
                            extraPrefsFiles = [ "${cfg.package}/dove.cfg" ];
                          }
                        )
                      ) cfg.thunderbirdPackages
                    )
                  )
                ];
              };
          };
      };

      packages = forAllSystems (system: rec {
        default = dove;
        dove = nixpkgs.legacyPackages.${system}.callPackage (
          {
            stdenvNoCC,
            python3,
            jq,
            zip,
            ...
          }:
          stdenvNoCC.mkDerivation {
            name = "dove";
            src = ./.;
            nativeBuildInputs = [
              python3
              jq
              zip
            ];
            buildPhase = ''
              runHook preBuild

              export phoenix_dir=${phoenix}
              patchShebangs ./build/*.sh
              ./build/build.sh

              runHook postBuild
            '';
            installPhase = ''
              runHook preInstall

              mkdir $out
              ${
                if stdenvNoCC.isDarwin then
                  ''
                    cp $src/macos/* $out/
                  ''
                else
                  ''
                    cp -r $src/policies.json $src/dove.cfg $src/prefs $out/
                  ''
              }
              install -Dm644 $src/README.md $out/share/doc/dove/README.md
              install -Dm644 $src/COPYING $out/share/doc/dove/COPYING

              runHook postInstall
            '';
          }
        ) { };
      });

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
