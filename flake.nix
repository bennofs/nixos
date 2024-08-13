{
  description = "Base NixOS config";

  inputs.nixos = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "nixos-24.05";
  };

  outputs = { self, nixos }: {
    nixosConfigurations.base-qemu = nixos.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-qemu.nix
        ./base.nix
      ];
    };

  };
}
