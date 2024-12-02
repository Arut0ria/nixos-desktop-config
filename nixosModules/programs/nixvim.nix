{ pkgs, lib, config, ... }: {
  options = {
    nixvim-program.enable = lib.mkEnableOption "Enables nixvim config.";
  };

  config = lib.mkIf config.nixvim-program.enable {
    # imports = [
    #   ./nvim_keymaps.nix
    # ];

    environment.systemPackages = with pkgs; [
      ripgrep # Adding ripgrep for telescope
    ];

    programs.nixvim = {
      enable = true;

      keymaps = import ./nvim_keymaps.nix;
      globalOpts = import ./nvim_options.nix;
      
      globals.mapleader = " ";

      colorschemes.catppuccin.enable = true;
      plugins = {
        lualine.enable = true;

        neoscroll.enable = true;

        # oil.enable = true;

        neo-tree = {
          enable = true;
          enableGitStatus = true;
          closeIfLastWindow = true;
        };

        telescope.enable = true;
        treesitter.enable = true;

        cmp.enable = true;
        cmp-nvim-lsp.enable = true;

        lsp = {
          enable = true;
          servers = {
            pyright.enable = true;
          };
        };
      };
    };
  };
}
