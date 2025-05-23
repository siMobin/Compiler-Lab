{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.flex
    pkgs.bison
    pkgs.gcc
  ];
}
