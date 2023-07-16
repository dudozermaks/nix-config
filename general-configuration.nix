{ config, lib, pkgs, ... }:

{
  # if its desktop
  imports = if (builtins.readFile /sys/class/dmi/id/chassis_type) == "3\n" then 
    [ ./desktop-configuration.nix /etc/nixos/hardware-configuration.nix <home-manager/nixos> ] 
  else 
    [ ./laptop-configuration.nix /etc/nixos/hardware-configuration.nix <home-manager/nixos> ] 
  ;

  networking.hostName = "DM"; # Define your hostname.

  # Configure keymap and i3 in X11
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbVariant = "";
    xkbOptions = "grp:win_space_toggle";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3={
      enable = true;
      extraPackages = with pkgs; [
        albert
        i3blocks
        picom-next
      ];
      package = pkgs.i3-rounded;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    neofetch 

    kitty

    spotify

    firefox

    zoxide
    colorpanes
    cfonts

    exa # modern ls

    git
    gh

    stow # for dotfiles

    arandr # for monitor configuration

    ranger

    pavucontrol
    
    wireguard-tools
    shadowsocks-rust

    deluge # torrent

    killall

    playerctl # for music-control buttons on keyboard


    bottles
    dconf # fixed issue

    unrar
    unzip

    cmatrix

    xclip

    ffmpeg

    scrot


    gnat # gcc
    clang-tools

    rustc
    cargo

    godot_4

    btop

    ripgrep

    # python packages
    (python3.withPackages(ps: with ps; [
      dbus-python
    ]))
    # LSP's
    nil # Nix
    lua-language-server
  ];
  fonts = {
    fonts = with pkgs; [
      powerline-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

  services.picom = {
    enable = true;
    backend = "glx";
		settings = {
      blur = { 
        method = "dual_kawase";
        size = 20;
        deviation = 5.0;
      };
      fading = true;
      fade-delta = 5;
      fade-in-step = 0.03;
      fade-out-step = 0.03;
		};
    opacityRules = [
      # "90:class_g = 'kitty' && focused"
      # "85:class_g = 'kitty' && !focused"
    ];
  };
# programs.zsh = {
#     enable = true;
#     syntaxHighlighting.enable = true;
#     autosuggestions.enable = true;
#
#     shellAliases = {
#      update = "sudo nixos-rebuild switch";
#      nvimconfig="nvim ~/.config/nvim/init.lua";
#      nvimplugins="nvim ~/.config/nvim/lua/plugins.lua";
#      nvimsettings="nvim ~/.config/nvim/lua/settings.lua";
#      ls="exa";
#     };
#     interactiveShellInit = ''
#      # cfonts "ABOBA|PC" --align center --colors green,red --letter-spacing 2 --spaceless
#      colorpanes 
#      eval "$(zoxide init zsh)"
#      autoload -U promptinit; promptinit
#     '';
#     ohMyZsh = {
#      enable = true;
#      customPkgs = with pkgs; [
#        zsh-z # z command instead of cd
#      ];
#      plugins = [ "git" ];
#      # theme = "sporty_256";
#      theme = "agnoster";
#     };
#   };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
	customRc = ''
		luafile ${/home/mask/.config/nvim/init.lua}
	'';
    	packages.nix = with pkgs.vimPlugins; {
		start = [
		  telescope-nvim
		  nvim-treesitter.withAllGrammars
		  nvim-ts-rainbow2
		  comment-nvim
		  gruvbox-nvim
		  lualine-nvim
		  bufferline-nvim
		  nvim-autopairs
		  alpha-nvim
		  impatient-nvim
		  indent-blankline-nvim
		  zen-mode-nvim
		  todo-comments-nvim
		  trouble-nvim
		  rnvimr
		  lsp-zero-nvim
		  nvim-web-devicons
		];
	};
    };
};
}
