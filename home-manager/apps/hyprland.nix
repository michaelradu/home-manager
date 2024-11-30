{ pkgs, lib, config, ... }:
let
    startupScript = pkgs.pkgs.writeShellScriptBin "startHypr" ''
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.hyprpaper}/bin/hyprpaper &
    '';
in
{
  # Configure hyprland with home-manager
  wayland.windowManager.hyprland = {
    enable = true;
    #systemd.variables = ["--all"];
    settings = {

      # Fix Scaling
      monitor=",preferred,auto,1.2";
      
      xwayland = {
	force_zero_scaling = true;
      };


      exec-once = ''${startupScript}/bin/startHypr'';

      "$mainMod" = "SUPER";
      
      "$terminal" = "kitty";
      "$browser" = "firefox";
      "$fileManager" = "nautilus";
      "$menu" = "wofi --show drun";

      bind = [
	# Launchers
	"$mainMod, return, exec, $terminal"
	"$mainMod, d, exec, $menu"

	"$mainMod, b, exec, $browser"


      "$SUPER_SHIFT, l, exec, hyprlock"
      #"$SUPER_SHIFT r, exec, hyprctl reload"
      #"$SUPER_SHIFT, d, exec, hyprctl keyword monitor eDP-1, disable"
      #"$SUPER_SHIFT, f, exec, hyprctl keyword monitor eDP-1, enable"
      
	# Screenshots with hyprshot
	", Print, exec, hyprshot -m window"
	"shift, Print, exec, hyprshot -m region"
      



	# System
	"$mainMod, m, exit"
	
	# Volume Control with pactl
	", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
	", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
	", XF86AudioMut, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"



	# Brightness Control with brightnessctl
	", XF86MonBrightnessUp, exec, brightnessctl set +5%"
	", XF86MonBrightnessDown, exec, brightnessctl set 5%-"


	# Window Management
	"$mainMod, q, killactive"
	"$mainMod, v, togglefloating"
	"$mainMod, p, pseudo"
	"$mainMod, e, togglesplit"
	"$mainMod, f, fullscreen"
	"$mainMod, w, togglegroup"
	
	## Move Focus with VIM Bindings
	"$mainMod, h, movefocus, l"
	"$mainMod, l, movefocus, r"
	"$mainMod, k, movefocus, u"
	"$mainMod, j, movefocus, d"



      ] ++ (
	  # workspaces
	  # binds $mainMod + [shift +] {1..9} to [move to] workspace {1..9}
	  builtins.concatLists (builtins.genList (i:
	      let ws = i + 1;
	      in [
		"$mainMod, code:1${toString i}, workspace, ${toString ws}"
		"$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
	      ]
	    )
	    9)
	);
    };
  };
}

