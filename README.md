# Nix Flake: Roku development tools

Packages included:

- [`brighterscript`](https://github.com/rokucommunity/brighterscript)
- [`brighterscript-formatter`](https://github.com/rokucommunity/brighterscript-formatter)
- [`bslint`](https://github.com/rokucommunity/bslint)
- [`ropm`](https://github.com/rokucommunity/ropm)

## Usage

### With Flakes

Add this repo to your `flake.nix` inputs like:

```nix
{
  # ...
  inputs.roku-devtools.url = "github:thelonelyghost/roku-devtools-nix";
  # ...

  outputs = { self, nixpkgs, flake-utils, roku-devtools, ...}@attrs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      roku = roku-devtools.packages."${system}";
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.bashInteractive
          roku.brighterscript
        ];
      };
    });
}
```

**Updating:** Anytime you want to update what roku-devtools offers, run `nix flake lock --update-input roku-devtools` and rebuild your nix expression acccordingly.

### Without Flakes

If you're not yet using [Nix Flakes][flakes], such as with [`home-manager`][home-manager], here's how you can include it:

1. Install [`niv`][niv] and run `niv init`
2. Run `niv add thelonelyghost/roku-devtools-nix --name roku-devtools`
3. Include the following in your code:

```nix
{ lib, config, ... }:

let
  sources = import ./nix/sources.nix {};
  pkgs = import sources.nixpkgs {};

  roku = (import (pkgs.fetchFromGitHub { inherit (sources.roku-devtools) owner repo rev sha256; })).outputs.packages."${builtins.currentSystem}";
in
{
  home.packages = [
    roku.brighterscript
  ];
}
```

**Updating:** Anytime you want to update what roku-devtools offers, run `niv update roku-devtools-nix` and rebuild your nix expression acccordingly.

[flakes]: https://github.com/NixOS/nix/blob/master/src/nix/flake.md
[home-manager]: https://github.com/nix-community/home-manager
[niv]: https://github.com/nmattia/niv
