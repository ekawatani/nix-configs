{ lib, ... }:
let
  defaultFeatures = import ../features.default.nix;
in
lib.recursiveUpdate defaultFeatures { }
