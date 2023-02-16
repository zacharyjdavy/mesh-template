{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [ pkgs.git pkgs.bash pkgs.gcc pkgs.gnumake pkgs.lima pkgs.docker pkgs.minikube pkgs.istioctl pkgs.kubectl pkgs.tilt ];
}
