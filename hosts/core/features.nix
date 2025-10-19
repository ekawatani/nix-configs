{ lib, ... }:
let
  defaultFeatures = import ../features.default.nix;
in
lib.recursiveUpdate defaultFeatures {
  nixos = {
    docker = true;
    networking = false;
  };

  home-manager = {
    development = false;
  };
}
