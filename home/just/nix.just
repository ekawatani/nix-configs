[group("nix")]
[doc('Initializes a nix flake')]
[no-cd]
flake template:
  nix flake init -t git+ssh://git@github.com/ekawatani/flakes#{{ template }} --tarball-ttl 0
