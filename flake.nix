{
  description = "Roku development tools for nix-based workstations";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.npmlock2nix = {
    url = "github:nix-community/npmlock2nix";
    flake = false;
  };
  inputs.nix-npm-buildpackage.url = "github:serokell/nix-npm-buildpackage";

  outputs = { self, nixpkgs, flake-utils, flake-compat, npmlock2nix, nix-npm-buildpackage }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        # 14.x is the latest that node2nix (and others) can support due to some changes in how
        # the package-lock.json (and other resolved dependencies') versions are parsed. Update
        # this version once we can because this is super old by now.
        #
        # @see https://github.com/nix-community/npmlock2nix/issues/45
        nodejs = pkgs.nodejs-14_x;

      in
        {
          devShell = pkgs.mkShell {
            nativeBuildInputs = [
              pkgs.bashInteractive
              pkgs.nodePackages.node2nix
              pkgs.nodePackages.npm
              pkgs.nodejs
            ];
            buildInputs = [];
          };

          packages = {
            brighterscript = import ./packages/brighterscript.nix { inherit pkgs nodejs; };
            brighterscript-formatter = import ./packages/brighterscript-formatter.nix { inherit pkgs nodejs; };
            bslint = import ./packages/bslint.nix { inherit pkgs nodejs; };
            ropm = import ./packages/ropm.nix { inherit pkgs nodejs; };
          };
        }
    );
}
