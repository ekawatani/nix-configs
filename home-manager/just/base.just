hostname := env_var('NIX_HOSTNAME')
project_dir := "~/projects/ekawatani/nix-configs"
nix_dir := project_dir + "#" + hostname

[group("nix")]
[doc('Initializes a nix flake')]
[no-cd]
flake template:
  nix flake init -t git+ssh://git@github.com/ekawatani/flakes#{{ template }} --tarball-ttl 0
