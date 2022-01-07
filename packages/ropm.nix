{ pkgs, nodejs ? pkgs.nodejs-14_x }:

let
  npm = import ../npm {
    inherit pkgs nodejs;
  };
  deps = [
    pkgs.nodePackages.npm
  ];
in
npm.ropm.override {
  buildInputs = [
    pkgs.makeWrapper
  ] ++ deps;

  postInstall = ''
    wrapProgram $out/bin/ropm --argv0 ropm \
      --suffix PATH : ${pkgs.lib.makeBinPath deps}
  '';

  meta = {
    description = "A package manager for the Roku platform";
    homepage = "https://github.com/rokucommunity/ropm";
  };
}
