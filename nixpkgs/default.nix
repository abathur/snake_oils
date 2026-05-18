{
  lib,
  pkgsBuildHost,
  version,
  rSrc,
}:

let
  idk = pkgsBuildHost.callPackage ./idk.nix { };
in
rec {
  inherit idk;
  cythonified = pkgsBuildHost.callPackage ./cythonified.nix {
    inherit rSrc idk;
  };
}
