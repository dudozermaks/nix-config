{ config, lib, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      (neovim.override {
        configure = {
          customRC = ''
            luafile ${/home/maks/.config/nvim/init.lua}
          '';
          packages.nix = with pkgs.vimPlugins; {
            start = 
            let 
              new-lsp-zero-nvim = pkgs.vimUtils.buildVimPlugin {
                name = "new-lsp-zero-nvim";
                src = pkgs.fetchFromGitHub {
                  owner = "VonHeikemen";
                  repo = "lsp-zero.nvim";
                  rev = "f306adde671281d77cebd635098cc8b8fc8368ee";
                  sha256 = "0999nc4076959469blkfajd316lbzxqwpigcl3mvci7mbqwkdhlj";
                };
              };
              duck-nvim = pkgs.vimUtils.buildVimPlugin {
                name = "duck-nvim";
                src = pkgs.fetchFromGitHub {
                  owner = "tamton-aquib";
                  repo = "duck.nvim";
                  rev = "8f18dd79c701698fc150119ef642c1881ce6a538";
                  sha256 = "0wnad6l9pqyjrlydnv141z9lxp2zi09dm49dy5mmcdvcn7klbxk0";
                };
              };
            in
            [
              duck-nvim

              telescope-nvim
              nvim-treesitter.withAllGrammars
              nvim-ts-rainbow2
              comment-nvim
              gruvbox-nvim
              lualine-nvim
              bufferline-nvim
              nvim-autopairs
              alpha-nvim
              indent-blankline-nvim
              zen-mode-nvim
              todo-comments-nvim
              trouble-nvim
              rnvimr
              new-lsp-zero-nvim
              nvim-lspconfig
              nvim-cmp
              cmp-nvim-lsp
              luasnip
              nvim-web-devicons
              emmet-vim
            ];
          };
        };
      })
    ];
  };
}
