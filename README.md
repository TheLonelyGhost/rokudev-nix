# Nix Flake: Roku development tools

Packages included:

- [`brighterscript`](https://www.npmjs.com/package/brighterscript)

## Usage

Add this repo to your `flake.nix` inputs like:

```nix
{
	# ...
	inputs.roku-dev.url = "github:thelonelyghost/rokudev-nix";
	# ...

	outputs = { self, nixpkgs, flake-utils, roku-dev, ...}@attrs:
		flake-utils.lib.eachDefaultSystem (system: let
			pkgs = import nixpkgs {
				inherit system;
			};
			roku = roku-dev.packages."${system}";
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
