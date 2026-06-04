{
  description = "Dove: a suite of configurations & advanced modifications for Mozilla Thunderbird, designed to put the user first - with a focus on privacy, security, freedom, functionality, & usability.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    phoenix = {
      url = "git+https://gitlab.com/celenityy/Phoenix?ref=pages";
      flake = false;
    };
    autoconfig = {
      url = "github:thunderbird/autoconfig?ref=prod";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      phoenix,
      autoconfig,
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
                lib.mkEnableOption "Enable privacy and security hardening of Thunderbird using the Dove configs"
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
                environment.etc."thunderbird/defaults/pref/dove.js".source = "${pkgs.dove}/pref/dove.js";
                environment.etc."thunderbird/dove.cfg".source = "${pkgs.dove}/dove.cfg";
                environment.etc."thunderbird/dove/assets".source = "${pkgs.dove}/assets";
                environment.variables = {
                  DOVE_HOST_NIX = 1;
                  MOZ_CRASHREPORTER = null;
                  MOZ_CRASHREPORTER_DISABLE = 1;
                  MOZ_CRASHREPORTER_NO_REPORT = 1;
                  MOZ_CRASHREPORTER_URL = "data;";
                  MOZ_DISABLE_ASAN_REPORTER = 1;
                  MOZ_ENABLE_WAYLAND = 1;
                  MOZ_GFX_CRASH_MOZ_CRASH = 1;
                  MOZ_GFX_CRASH_TELEMETRY = null;
                  PHOENIX_HOST_NIX = 1;
                  SSLKEYLOGFILE = null;
                };
                programs.thunderbird.policies =
                  (builtins.fromJSON (builtins.readFile "${pkgs.dove}/policies.json")).policies;
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
                (python3.withPackages (ps: [
                  ps.lxml
                ]))
                jq
                zip
              ];
              buildPhase = ''
                runHook preBuild

                export DOVE_PHOENIX="$PWD/phoenix"
                export DOVE_AUTOCONFIG=${autoconfig}
                cp --no-preserve=mode -r ${phoenix} "$DOVE_PHOENIX"

                export DOVE_NIX=1
                patchShebangs ./scripts/*.sh

                ./scripts/build.sh
                sed -i '/general.config.filename/d' dove-unified.cfg

                runHook postBuild
              '';
              installPhase = ''
                runHook preInstall

                mkdir $out
                ${
                  if stdenvNoCC.isDarwin then
                    ''
                      cp outputs/osx/* $out/
                      cp -r outputs/osx/assets $out/assets
                    ''
                  else
                    ''
                      cp -r outputs/linux/policies/policies.json outputs/linux/dove.cfg outputs/linux/defaults/pref $out/
                      cp -r outputs/linux/assets $out/assets
                    ''
                }
                install -Dm644 README.md $out/share/doc/dove/README.md
                install -Dm644 COPYING.txt $out/share/doc/dove/COPYING.txt

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
