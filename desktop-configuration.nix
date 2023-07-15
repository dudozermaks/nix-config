# Configuration for my desktop
{ config, lib, pkgs, ... }:

{
  fileSystems."/home/mask/shit" =
    { device = "/dev/disk/by-label/doc";
      fsType = "ext4";
    };

  # Nvidia videocard
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
  };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
    ];

  services.xserver.videoDrivers = [ "nvidia" "intel" ];

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;
    powerManagement.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    # open = true;

    # Enable the nvidia settings menu
    # nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.config = lib.mkForce ''
  Section "Device"
    Identifier  "GeForce GTX 750 Ti"
    Driver      "nvidia"

    # If you have multiple video cards, the BusID controls which one this definition refers
    # to.  You can omit it if you only have one card.
    # BusID       "PCI:1:0:0"

    # Need to flag this as only referring to one output on the card
    Screen      0

    # For nVidia devices, this controls which connector the monitor is connected to.
    Option      "UseDisplayDevice"   "VGA-2"

    # We want control!
    Option      "DynamicTwinView"    "FALSE"

    # Various performance and configuration options
    Option      "AddARGBGLXVisuals"  "true"
    Option      "UseEDIDDpi"         "false"
    Option      "DPI"                "96 x 96"
    Option      "Coolbits"           "1"
  EndSection
  Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "TearFree" "true"
  EndSection
  '';

  # monitors setup
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DVI-D-1 --off --output VGA-0 --primary --mode 1920x1080 --pos 1680x0 --rotate normal --output HDMI-2 --off --output VGA1 --mode 1680x1050 --pos 0x240 --rotate normal --output HDMI-1-1 --off
  '';
  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.sessionVariables = rec {
    WORK_FOLDER = "$HOME/shit/work";
  };
}
