{ pkgs, nodejs ? pkgs.nodejs-14_x }:

let
  npm = import ../npm {
    inherit pkgs nodejs;
  };
in
npm.brighterscript.override {
  meta = {
    description = "A superset of Roku's BrightScript language. Compiles to standard BrightScript.";
    homepage = "https://github.com/rokucommunity/brighterscript";
  };
}
