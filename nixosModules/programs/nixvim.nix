{ pkgs, lib, config, ...}: {
  options = {
    nixvim-program.enable = lib.mkEnableOption "Enables nixvim config.";
  };

  config = lib.mkIf config.nixvim-program.enable {
    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin.enable = true;
      plugins = {
        lualine.enable = true;
        oil.enable = true;
        neoscroll.enable = true;
        
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
