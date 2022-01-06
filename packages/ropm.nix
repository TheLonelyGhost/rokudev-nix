{ pkgs, nodejs ? pkgs.nodejs-14_x }:

let
  npm = import ../npm {
    inherit pkgs nodejs;
  };
in
npm.ropm.override {
  meta = {
    description = "A package manager for the Roku platform";
    homepage = "https://github.com/rokucommunity/ropm";
  };
}
