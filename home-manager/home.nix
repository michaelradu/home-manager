{ config, pkgs, lib, ... }:
 # a `home.nix` that is fed into home-manager
let
  # ...
  nixGLWrap = pkg: pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
    mkdir $out
    ln -s ${pkg}/* $out
    rm $out/bin
    mkdir $out/bin
    for bin in ${pkg}/bin/*; do
     wrapped_bin=$out/bin/$(basename $bin)
     echo "exec ${lib.getExe pkgs.nixgl.nixGLIntel} $bin \$@" > $wrapped_bin
     chmod +x $wrapped_bin
    done
  '';in {

  imports = [
    ./apps/git.nix
    ./apps/nixvim.nix
    ./apps/zsh.nix
    ./apps/starship.nix
    ./apps/hyprland.nix
    ./apps/vscode.nix
    ./apps/waybar.nix
    ./apps/hyprlock.nix
    ./apps/hyprpaper.nix
    ./apps/rofi.nix
  ];

  programs.kitty = {
    enable = true;
    package = nixGLWrap pkgs.kitty;
    themeFile = "Dracula";
    settings = {
      shell = "/home/alex/.nix-profile/bin/zsh";
    };
  };

  # EXPERIMENTAL

 # gtk = {
 #   enable = true;

 #   theme.package = pkgs.adw-gtk3;
 #   theme.name = "adw-gtk3";

 #   cursorTheme.package = pkgs.bibata-cursors;
 #   cursorTheme.name = "Bibata-Modern-Ice";

#  };

  # Change System Theme on Linux Mint
  dconf.settings = {
    
    # Cursors & GTK
    "org/cinnamon/desktop/interface" = {
      cursor-theme = "Bibata-Modern-Ice";
      gtk-theme = "Dracula";

    };

    # Panel
    "org/cinnamon/theme" = {
      name = "Dracula";
    };

    # Background
    "org/cinnamon/desktop/background" = {
      picture-uri = "file:///home/alex/.config/backgrounds/dracula-linux.png";
    };


    # Keybindings

    "org/cinnamon/desktop/keybindings" = {
      custom-list = [
	"custom0"
	"custom1"
	"custom2"
	"custom3"
	"custom4"
	#"custom5"
      ];
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
      binding = ["<Alt>1"];
      command = "wmctrl -s 0";
      name = "GO TO 1";
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom1" = {
      binding = ["<Alt>2"];
      command = "wmctrl -s 1";
      name = "GO TO 2";
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom2" = {
      binding = ["<Alt>3"];
      command = "wmctrl -s 2";
      name = "GO TO 3";
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom3" = {
      binding = ["<Alt>4"];
      command = "wmctrl -s 3";
      name = "GO TO 4";
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom4" = {
      binding = ["<Alt>Return"]; # or <Super>T
      command = "kitty";
      name = "Launch Kitty";
    };

    # Doesn't work, probably due to nix-store relative path, needing absolute path instead
    #"org/cinnamon/desktop/keybindings/custom-keybindings/custom5" = {
    #  binding = ["<Alt>D"];
    #  command = "rofi -show drun";
    #  name = "Launch Rofi";
    #};
    
    "org/cinnamon/desktop/keybindings/wm" = {
      close = ["<Alt>F4" "<Alt>q"];
      toggle-maximized = ["<Alt>F" "<Alt>Up"];
      minimize = ["<Alt>M" "<Alt>Down"];
    };

    "org/cinnamon" = {
      panels-enabled = ["1:0:top" "2:0:bottom"];
      panels-height = ["1:30" "2:30"];
      enabled-applets = [
	"panel1:left:0:menu@cinnamon.org:0"
	"panel1:left:1:separator@cinnamon.org:1"
	"panel1:left:2:grouped-window-list@cinnamon.org:2"
	"panel1:right:3:systray@cinnamon.org:3"
	"panel1:right:4:xapp-status@cinnamon.org:4"
	"panel1:right:5:notifications@cinnamon.org:5"
	"panel1:right:6:printers@cinnamon.org:6"
	"panel1:right:7:removable-drives@cinnamon.org:7"
	"panel1:right:8:keyboard@cinnamon.org:8"
	"panel1:right:9:favorites@cinnamon.org:9"
	"panel1:right:10:network@cinnamon.org:10"
	"panel1:right:11:sound@cinnamon.org:11"
	"panel1:right:12:power@cinnamon.org:12"
	"panel1:right:13:calendar@cinnamon.org:13"
	"panel1:right:14:cornerbar@cinnamon.org:14"

	"panel2:right:2:workspace-switcher@cinnamon.org:18"
	"panel2:left:0:window-list@cinnamon.org:19"
      ];
    };


    
  };
  
  home.file = {

  # Set VSCode Theme
  ".config/Code/User/settings.json" = {
    text = ''
      {
        "workbench.colorTheme": "Dracula Theme" 
      }
    '';

  };

  # Font Config for Non-NixOS
  ".config/fontconfig/conf.d/10-nix-fonts.conf" = {
    text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
      <dir>~/.nix-profile/share/fonts/</dir>
    </fontconfig>
    '';
  };


 # Wallpaper
  ".config/backgrounds/shaded.png" = {
    source = ../backgrounds/shaded.png;
    target = ".config/backgrounds/shaded.png";
  };
  ".config/backgrounds/dracula-linux.png" = {
    source = ../backgrounds/dracula-linux.png;
    target = ".config/backgrounds/dracula-linux.png";
  };

  # themes
  ".themes/Dracula" = {
    source = "${pkgs.dracula-theme}/share/themes" ;
    target = ".themes";
  };

  # Set Dracula Theme on Mint
  #".themes/Dracula" = {
  #  source = ../Dracula;
  #  target = ".themes/Dracula";
  #};

};

  # Styling Options
  stylix = {
    enable = true;
   autoEnable = false;
    image = ../backgrounds/shaded.png;
    # base16Scheme = {
    #   base00 = "232136";
    #   base01 = "2a273f";
    #   base02 = "393552";
    #   base03 = "6e6a86";
    #   base04 = "908caa";
    #   base05 = "e0def4";
    #   base06 = "e0def4";
    #   base07 = "56526e";
    #   base08 = "eb6f92";
    #   base09 = "f6c177";
    #   base0A = "ea9a97";
    #   base0B = "3e8fb0";
    #   base0C = "9ccfd8";
    #   base0D = "c4a7e7";
    #   base0E = "f6c177";
    #   base0F = "56526e";
    # };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

  stylix.targets.waybar.enable = false;
  stylix.targets.wofi.enable = false;
  stylix.targets.hyprland.enable = false;
  #stylix.targets.vscode.enable = true;
  #stylix.targets.gtk.enable = true;


   
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    fastfetch
    git
    git-credential-manager
    (discord.override {
      withVencord = true;
    })
    tree
    nixgl.nixGLIntel

    #(nixGLWrap pkgs.kitty) # Works fine!
    (nixGLWrap pkgs.vlc)

    # Depends of Hypr Setup
    #(nixGLWrap pkgs.wofi)
    #(nixGLWrap pkgs.hyprlock)
    #(nixGLWrap pkgs.waybar)
    (nixGLWrap pkgs.hyprpaper)
    (nixGLWrap pkgs.hyprshot)
    brightnessctl

    # Nerd Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "NerdFontsSymbolsOnly" ]; })

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];


  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/alex/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  # Allow apps into Cinnamon Menus
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
}
