[group("home-manager")]
[doc('Performs `home-manager switch`')]
hm-switch:
  home-manager switch --flake {{nix_dir}}

[group("home-manager")]
[doc('Shows information about how to rollback to a previous generation')]
hm-rollback:
  home-manager generations
  @echo ""
  @echo "Copy the path of the generation you want to rollback to and directly run it."

[group("home-manager")]
[doc('Updates the flakes of the home manager packages')]
[confirm("Are you sure you want to update home manager packages?")]
hm-update:
  nix flake update {{project_dir}}

[group("home-manager")]
[doc('Clears generations from the last 30 days')]
hm-clean:
  home-manager expire-generations "-30 days"
