{ pkgs, config, lib, ... }@inputs: {
  options = {
    plasma-manager-config.enable = lib.mkEnableOption "Enables plasma manager config.";
  };

  config = lib.mkIf config.plasma-manager-config.enable {
    nixpkgs.overlays = [
      (final: prev: {
        plasmusic-toolbar = (import inputs.inputs.nixpkgs-unstable { system = final.system; }).plasmusic-toolbar;
        polonium = (import inputs.inputs.nixpkgs-unstable { system = final.system; }).polonium;
        # polonium = prev.libsForQt5.polonium;
      })
    ];

    # environment.systemPackages = with pkgs; [ plasmusic-toolbar ];
    home.packages = with pkgs; [
      plasmusic-toolbar
    ];

    programs.plasma = {
      enable = true;

      # workspace = {
      #   lookAndFeel = "com.github.vinceliuice.Graphite";
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
                icon = "nix-snowflake-colours";
                size = {
                  width = 48;
                  height = 48;
                };
              };
            }
            "org.kde.plasma.pager"

            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.icontasks"
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.marginsseparator"

            {
              plasmusicToolbar = {
                panelIcon = {
                  albumCover = {
                    useAsIcon = true;
                    radius = 8;
                  };
                  icon = "view-media-track";
                };
                # preferredSource = "spotify";
                musicControls.showPlaybackControls = true;
                songText = {
                  displayInSeparateLines = false;
                  # maximumWidth = 640;
                  scrolling = {
                    behavior = "alwaysScroll";
                    speed = 3;
                  };
                };
              };
            }

            # "org.kde.plasma.systemtray"

            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                ];
                hidden = [
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.clipboard"
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
          match = { };
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

        scripts.polonium = {
          enable = false;
          settings = {
            borderVisibility = "noBorderAll";
            filter.windowTitles = null; # Don't filter windows by title, for now...
            filter.processes = [
              "krunner"
              "yakuake"
              "kded"
              "polkit"
              "plasmashell"
            ];
          };
        };
      };

      # Additional config
      configFile = {
        "kwinrc"."MouseBindings"."CommandAllWheel" = "Change opacity";
      };
    };
  };
}
