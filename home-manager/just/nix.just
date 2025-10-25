import './base.just'

[group("home-manager")]
[doc('Performs `home-manager switch`')]
switch:
  home-manager switch --flake {{nix_dir}}

[group("home-manager")]
[doc('Shows information about how to rollback to a previous generation')]
rollback:
  home-manager generations
  @echo ""
  @echo "Copy the path of the generation you want to rollback to and directly run it."

[group("home-manager")]
[doc('Updates the flakes of the home manager packages')]
[confirm("Are you sure you want to update home manager packages?")]
update:
  nix flake update {{project_dir}}

[group("home-manager")]
[doc('Clears generations from the last 30 days')]
clean:
  home-manager expire-generations "-30 days"