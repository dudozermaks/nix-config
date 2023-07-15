{ config, lib, pkgs, ... }:

{
  environment.sessionVariables = rec {
    WORK_FOLDER = "$HOME/work";
  };
}
