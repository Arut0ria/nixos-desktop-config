{ pkgs, config, lib, ... }@inputs: {
  options = {
    plasma-manager-config.enable = lib.mkEnableOption "Enables plasma manager config.";
  };

  config = lib.mkIf config.plasma-manager-config.enable {
    programs.plasma = {
      enable = true;

      # workspace = {
      #   lookAndFeel = "";
      # };

      # Hotkeys
      hotkeys.commands."launch-kitty" = {
        name = "Launch Kitty";
        key = "Meta+Ctrl+T";
        command = "kitty";
      };

      # Panel Setup
      panels = [
        {
          location = "bottom";
          hiding = "none";
          floating = true;
          alignment = "center";
          lengthMode = "fill";

          widgets = [
            # "org.kde.plasma.kickoff"
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-white";
              };
            }
            "org.kde.plasma.pager"
            "org.kde.plasma.icontasks"

            "org.kde.plasma.marginsseparator"

            # {
            #   plasmusicToolbar = {
            #     panelIcon = {
            #       albumCover = {
            #         useAsIcon = false;
            #         radius = 8;
            #       };
            #       icon = "view-media-track";
            #     };
            #     # preferredSource = "spotify";
            #     musicControls.showPlaybackControls = true;
            #     songText = {
            #       displayInSeparateLines = true;
            #       maximumWidth = 640;
            #       scrolling = {
            #         behavior = "alwaysScroll";
            #         speed = 3;
            #       };
            #     };
            #   };
            # }

            # "org.kde.plasma.systemtray"
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                ];
                # And explicitly hide networkmanagement and volume
                hidden = [
                ];
              };
            }
            "org.kde.plasma.digitalclock"
            "org.kde.plasma.showdesktop"
          ];
        }

      ];

      window-rules = [
        {
          description = "Kitty Rule";
          match = {
            window-class = {
              value = "kitty";
              type = "substring";
            };
            window-types = [
              "normal"
            ];
          };

          apply = {
            noborder = {
              value = true;
              apply = "force";
            };
            opacityactiverule = {
              value = 2;
              apply = "force";
            };
            opacityinactiverule = {
              value = 2;
              apply = "force";
            };
          };
        }
        {
          description = "Forced Opacity";
          match = {};
          apply = {
            opacityactive = {
              value = 95;
              apply = "force";
            };
            opacityactiverule = {
              value = 2;
              apply = "force";
            };
            opacityinactive = {
              value = 85;
              apply = "force";
            };
            opacityinactiverule = {
              value = 2;
              apply = "force";
            };
          };
        }
      ];

      # Kwin setup
      kwin = {
        edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
        cornerBarrier = false;

        effects = {
          translucency.enable = true;
          blur.enable = false;
          # forceblur.enable = lib.optionals (builtins.hasAttr "kwin-effects-forceblur" inputs.inputs) true;
        };

        virtualDesktops = {
          rows = 2;
          number = 4;
        };

        borderlessMaximizedWindows = true;

        # scripts.polonium = {
        #   enable = true;
        #   settings = {
        #     borderVisibility = "noBorderAll";
        #     filter.windowTitles = null; # Don't filter windows by title, for now...
        #     filter.processes = [
        #       "krunner"
        #       "yakuake"
        #       "kded"
        #       "polkit"
        #       "plasmashell"
        #     ];
        #   };
        # };
      };
    };
  };
}
