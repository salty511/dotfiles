# System configuration for Isaac's NixOS machine.
# Edit this repo copy, install to /etc/nixos/configuration.nix, then rebuild.
{ lib, pkgs, ... }:

{
  # Keep the generated, machine-specific hardware configuration separate.
  imports = [ /etc/nixos/hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Desktop sessions and login manager.
  programs.niri = { enable = true; useNautilus = false; };
  programs.dconf.enable = true;
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
  services.displayManager.sddm = { enable = true; wayland.enable = true; };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  security.polkit.enable = true;
  security.pam.services.dankshell = {};
  services.gnome.gnome-keyring.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.flatpak.enable = true;
  services.printing.enable = true;

  # Audio.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.isaac = {
    isNormalUser = true;
    description = "Isaac";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    htop hyfetch chromium tmux
    git python3 kitty neovim dms-shell quickshell dgop cava playerctl
    ripgrep fd wl-clipboard brightnessctl xwayland-satellite
    bibata-cursors papirus-icon-theme
    # Neovim plugins use lazy.nvim; executable tools are managed by Nix.
    fzf gcc tree-sitter
    lua-language-server stylua efm-langserver
    pyright ruff
    nodejs typescript typescript-language-server prettierd eslint
    luarocks
  ];
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono noto-fonts ];
  environment.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  systemd.user.services.dms = {
    description = "DankMaterialShell";
    wantedBy = [ "niri.service" ];
    after = [ "niri.service" ];
    partOf = [ "niri.service" ];
    # Inherit Niri's full session PATH so the launcher can find installed apps.
    enableDefaultPath = false;
    serviceConfig = {
      ExecStart = "${pkgs.dms-shell}/bin/dms run --session";
      Restart = "on-failure";
    };
  };

  # Initial installation version; do not change this when upgrading NixOS.
  system.stateVersion = "26.05";
}
