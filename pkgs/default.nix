{ pkgs ? import <nixpkgs> {}, ...}: rec {
  open3e = pkgs.callPackage ./open3e.nix { };
}