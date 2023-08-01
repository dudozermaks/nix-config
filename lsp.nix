{ config, lib, pkgs, ... }:

{
  config = {
    environment.systemPackages = 
    let
      customNodePackages = pkgs.callPackage ./customNodePackages {  };
    in
    with pkgs; [
      nil # Nix
      lua-language-server
      gopls
      customNodePackages.emmet-ls
      python311Packages.python-lsp-server
      ltex-ls
    ];
  };
}
