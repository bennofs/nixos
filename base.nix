{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "prohibit-password";
  };
  programs.mosh.enable = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
     '';
  };

  users = {
    mutableUsers = false;
    users.root = {
      createHome = true;
      hashedPassword = "!";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmb1kv+7HU1QKE53+gNxUhrggbwomC40Xjxd9hACkoo bennofs@d-cube"
      ];
    };
  };

  # admin tools
  programs.vim.defaultEditor = true;
  programs.mtr.enable = true;
  programs.iftop.enable = true;
  programs.iotop.enable = true;
  environment.systemPackages = with pkgs; [
    htop atop dstat tmux nmap ripgrep nix-index git
    fd aria2 p7zip radare2 binutils usbutils iperf ethtool
    smartmontools file dfc fish
  ];

  # we don't need polkit
  security.polkit.enable = lib.mkForce config.security.rtkit.enable;
}
