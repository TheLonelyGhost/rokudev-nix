{ pkgs, nodejs ? pkgs.nodejs-14_x }:

let
  npm = import ../npm {
    inherit pkgs nodejs;
  };
in
npm.brighterscript
