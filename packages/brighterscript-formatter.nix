{ pkgs, nodejs ? pkgs.nodejs-14_x }:

let
  npm = import ../npm {
    inherit pkgs nodejs;
  };
in
npm.brighterscript-formatter.override {
  meta = {
    description = "A code formatter for BrightScript and BrighterScript";
    homepage = "https://github.com/rokucommunity/brighterscript-formatter";
  };
}
