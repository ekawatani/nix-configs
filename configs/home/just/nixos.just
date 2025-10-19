project_dir := "~/projects/ekawatani/nix-configs"
nix_dir := project_dir + "#" + hostname

[group("nixos")]
[doc('Performs `nixos-rebuild switch`')]
switch:
  sudo nixos-rebuild switch --flake {{nix_dir}}

[group("nixos")]
[doc("Performs `nixos-rebuild test`")]
test:
  sudo nixos-rebuild test --flake {{nix_dir}}

[group("nixos")]
[doc('Updates the flakes of the NixOS packages')]
[confirm("Are you sure you want to update NixOS packages?")]
update:
  nix flake update {{project_dir}}
