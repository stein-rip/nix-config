  { config, pkgs, lib, apple-silicon, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/asahi.nix

      # apple-silicon hardware support
      apple-silicon.nixosModules.apple-silicon-support
      
      # include my base config
      ../default.nix
    ];
  
  # asahi linux overlay
  nixpkgs.overlays = [ apple-silicon.overlays.apple-silicon-overlay ];

  # enable GPU support
  hardware.asahi.useExperimentalGPUDriver = true;

  # backlight control
  programs.light.enable = true;  
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "asahi"; # Define your hostname.
  networking.networkmanager.enable = true;

  system.stateVersion = lib.mkForce "23.05";
}