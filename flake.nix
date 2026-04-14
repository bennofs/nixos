{
  description = "Base NixOS config";

  inputs.nixos = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "nixos-25.11";
  };

  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixos";

  outputs = { self, nixos, disko }: {
    nixosConfigurations.base-qemu = nixos.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        ./hardware-qemu.nix
        ./disk-config.nix
        ./base.nix
        ./custom.nix
      ];
    };

    nixosConfigurations.base-qemu-aarch64 = nixos.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        disko.nixosModules.disko
        ./hardware-qemu.nix
        ./disk-config.nix
        ./base.nix
        ./custom.nix
      ];
    };

    nixosConfigurations.base = nixos.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-qemu.nix
        ./base.nix
        ./custom.nix
      ];
    };

  };
}
