[group("nixos")]
[doc('Performs `nixos-rebuild switch`')]
os-switch:
  sudo nixos-rebuild switch --flake {{nix_dir}}

[group("nixos")]
[doc("Performs `nixos-rebuild test`")]
os-test:
  sudo nixos-rebuild test --flake {{nix_dir}}

[group("nixos")]
[doc('Updates the flakes of the NixOS packages')]
[confirm("Are you sure you want to update NixOS packages?")]
os-update:
  nix flake update {{project_dir}}
