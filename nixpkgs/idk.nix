{
  lib,
  stdenv,
  oils-for-unix,
  readline,
}:

stdenv.mkDerivation (finalAttrs: {
  src = oils-for-unix.src;
  pname = "oils-cython-thing";
  version = "undefined";

  postPatch = ''
    patchShebangs _build
  '';

  preInstall = ''
    mkdir -p $out
  '';

  buildPhase = ''
    runHook preBuild

    _build/oils.sh

    runHook postBuild

    find .
  '';

  installPhase = ''
    runHook preInstall

    cp -r . $out

    runHook postInstall
  '';

  strictDeps = true;
  buildInputs = [ readline ];

})
