{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  description = "";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      flake-compat,
      treefmt-nix,
    }:
    {
      # TODO:
      # - document if I need nixpkgs.lib.composeExtensions wwurst.overlays.default or not. TL;DR: make sure you aren't holding this wrong or cargo culting
      # - update other flakes based on this?
      overlays.default = (
        final: prev: {
          inherit
            (prev.callPackage ./nixpkgs {
              version = (self.shortRev or "dirty");
              rSrc = final.lib.cleanSource self;
            })
            idk
            cythonified
            ;
        }
      );
      nixpkgs_source = nixpkgs.outPath;
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.default
          ];
        };

        treefmtEval = (treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
      in
      {
        packages = {
          idk = pkgs.idk;
          cythonified = pkgs.cythonified;
        };
        checks = {
          formatting = treefmtEval.config.build.check self;
        };

        formatter = treefmtEval.config.build.wrapper;
        formatterx = (
          pkgs.treefmt.withConfig {
            runtimeInputs = [ pkgs.nixfmt-rfc-style ];
            settings.formatter.nixfmt = {
              command = "nixfmt";
              includes = [ "*.nix" ];
            };
          }
        );
      }
    );
}
