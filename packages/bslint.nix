{ pkgs, nodejs ? pkgs.nodejs-14_x }:

let
  npm = import ../npm {
    inherit pkgs nodejs;
  };
in
npm."@rokucommunity/bslint".override {
  meta = {
    description = "A standalone CLI tool to lint BrightScript and BrighterScript code";
    homepage = "https://github.com/rokucommunity/bslint";
  };
}
