{
  lib,
  stdenv,
  idk,
  rSrc,
  python3,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "cythonified";
  version = "0.0.1";

  pyproject = true;
  src = rSrc;

  build-system = builtins.attrValues {
    inherit (python3.pkgs) cython setuptools distutils;
  };

  preBuild = ''
    export CPLUS_INCLUDE_PATH=${idk}
  '';
  postBuild = ''
    find .
  '';

  buildInputs = [ idk ];
}
