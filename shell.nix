{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [ pkgs.git pkgs.bash pkgs.gcc pkgs.gnumake ];
}
