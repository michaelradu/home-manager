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
  ];

  programs.kitty = {
    enable = true;
    package = nixGLWrap pkgs.kitty;
    themeFile = "Dracula";
    settings = {
      shell = "/home/alex/.nix-profile/bin/zsh";
    };
  };

  #programs.vscode = {
   # enable = true;
    #package = pkgs.vscode;
    #extensions = with pkgs.vscode-extensions; [
      #ms-vscode.cpptools
     # ms-vscode.cpptools-extension-pack
      #ms-python.python
      #dracula-theme.theme-dracula
      #vscodevim.vim
    #];
  #};

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
};


  # Hyprland Depends
 # programs.hyprlock = {
  #  enable=true;
    #package = nixGLWrap pkgs.hyprlock;

   # settings = {
    #  general = {
#	disable_loading_bar = true;
#	grace = 300;
#	hide_cursor = true;
#	no_fade_in = false;
 #     };

  #    background = [
#	{
#	  path = "screenshot";
#	  blur_passes = 3;
#	  blur_size = 8;
#	}
 #     ];

  #    input-field = [
#	{
#	  size = "200, 50";
#	  position = "0, -80";
#	  monitor = "";
#	  dots_center = true;
#	  fade_on_empty = false;
#	  font_color = "rgb(202, 211, 245)";
#	  inner_color = "rgb(91, 96, 120)";
#	  outer_color = "rgb(24, 25, 38)";
#	  outline_thickness = 5;
#	  placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
#	  shadow_passes = 2;
#	}
 #     ];
  #  };
 # };

  #programs.vlc = {
  #  enable=true;
  #  package = nixGLWrap pkgs.vlc;
  #};
  
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
    (nixGLWrap pkgs.wofi)
    #(nixGLWrap pkgs.hyprlock)
    #(nixGLWrap pkgs.waybar)
    (nixGLWrap pkgs.hyprpaper)
    (nixGLWrap pkgs.hyprshot)
    brightnessctl

    # Nerd Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

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
