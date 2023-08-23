{ config, lib, pkgs, ... }:

{
  config = {
    environment.sessionVariables = rec {
      WORK_FOLDER = "$HOME/work";
    };
    environment.systemPackages = with pkgs; [
      acpi
    ];
  };
}
