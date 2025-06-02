{
  description = "Dove: a suite of configurations & advanced modifications for Mozilla Thunderbird, designed to put the user first - with a focus on privacy, security, freedom, functionality, & usability.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    phoenix = {
      url = "git+https://gitlab.com/celenityy/Phoenix";
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
              thunderbirdPackages = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [
                  "thunderbird"
                  "thunderbird-latest"
                ];
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
                environment.etc."thunderbird/defaults/pref/dove.js".source = "${pkgs.dove}/linux/defaults/pref/dove.js";
                programs.thunderbird.policies =
                  (builtins.fromJSON (builtins.readFile "${pkgs.dove}/linux/policies/policies.json")).policies;
                nixpkgs.overlays = [
                  self.overlays.default
                  (
                    final: prev:
                    builtins.listToAttrs (
                      map (p: lib.nameValuePair p (final.withDove prev.${p})) cfg.thunderbirdPackages
                    )
                  )
                ];
              };
          };
      };

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
        in
        rec {
          default = dove;
          inherit (pkgs) dove;
          thunderbird = pkgs.withDove pkgs.thunderbird;
          thunderbird-latest = pkgs.withDove pkgs.thunderbird-latest;
        }
      );

      overlays = {
        default = final: prev: {
          dove = final.callPackage (
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
                sed -i '/general.config.filename/d' build/dove-unified.js

                runHook postBuild
              '';
              installPhase = ''
                runHook preInstall

                mkdir $out
                ${
                  if stdenvNoCC.isDarwin then
                    ''
                      cp macos/* $out/
                    ''
                  else
                    ''
                      cp -r policies.json dove.cfg prefs $out/
                    ''
                }
                install -Dm644 README.md $out/share/doc/dove/README.md
                install -Dm644 COPYING $out/share/doc/dove/COPYING

                runHook postInstall
              '';
            }
          ) { };

          withDove =
            thunderbirdPackage:
            thunderbirdPackage.override {
              extraPoliciesFiles = [ "${final.dove}/policies.json" ];
              extraPrefsFiles = [ "${final.dove}/dove.cfg" ];
            };
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
