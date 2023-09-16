{
  description = "AI Game Jam";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    sops.url = "github:Mic92/sops-nix";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    sops,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
      ];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        # makes pkgs available to all perSystem functions
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # see: https://nixos.wiki/wiki/Go
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            delve
            go
            gopls
          ];
        };

        formatter = pkgs.alejandra;
      };

      imports = [
        # ./packages
      ];
    };
}
