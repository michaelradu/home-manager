{pkgs, ...}:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
	layer = "top";
	position = "top";
	#height = 20;

	tray = {
	  icon-size = 20;
	  spacing = 8;
	};

	output = [
	  "eDP-1"
	  "HDMI-A-1"
	];
	modules-left = [ "custom/launcher hyprland/workspaces" "wlr/taskbar" ];
	modules-center = [ "hyprland/window" ];
	modules-right = [ "battery" "pulseaudio" "network" "clock" ];

	#"hyprland/workspaces" = {
	#  disable-scroll = true;
	#  all-outputs = true;
	#};

	"hyprland/language" = {
	  format = "Lang: {long}";
	  format-en = "US";
	  format-ro = "RO";
	};

	"custom/hello-from-waybar" = {
	  format = "hello {}";
	  max-length = 40;
	  interval = "once";
	  exec = pkgs.writeShellScript "hello-from-waybar" ''
	    echo "from within waybar"
	  '';
	};

	"clock" = {
	  format = " {:%a, %d %b, %I:%M %p}";
	  format-alt = " {:%d/%m}";
	  tooltip = true;
	  tooltip-format = ''<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>'';
	};

	"custom/launcher" = {
	  format = "";
	  tooltip = false;
	};

	"battery" = {
	  format = "{icon}  {capacity}%";
	  format-alt = "{icon} {time}";
	  format-charging = "  {capacity}%";
	  format-icons = [
	    ""
	    ""
	    ""
	    ""
	    ""
	  ];
	  format-plugged = " {capacity}% ";
	  states = {
	    "critical" = 15;
	    "good" = 95;
	    "warning" = 30;
	  };
	};

	"pulseaudio" = {
	  format = "{icon} {volume}%";
	  format-icons = {
	    "default" = [
	      "󰕿"
	      "󰖀"
	      "󰕾"
	    ];
	  };
	  format-muted = "󰝟";
	  on-click = "pavucontrol";
	  scroll-step = 5;
	};

	"network" = {
	  format-disconnected = "󰖪 0% ";
	  format-ethernet = "󰈀 100% ";
	  format-linked = "{ifname} (No IP)";
	  format-wifi = "  {signalStrength}%";
	  tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
	};

      };

    };

    style =''
      * {
	border: none;
	border-radius: 0px;
	font-family: JetBrainsMono NF;
	font-size: 12px;
	min-height: 0;
      }

      window#waybar {
	background: rgba(17,17,27,1);
      }

      #cava.left, #cava.right {
	background: #25253a;
	margin: 5px; 
	padding: 8px 16px;
	color: #cba6f7;
      }
      #cava.left {
	border-radius: 24px 10px 24px 10px;
      }
      #cava.right {
	border-radius: 10px 24px 10px 24px;
      }
      #workspaces {
	background: #25253a;
	margin: 5px 5px;
	padding: 8px 5px;
	border-radius: 16px;
	color: #cba6f7
      }
      #workspaces button {
	padding: 0px 5px;
	margin: 0px 3px;
	border-radius: 16px;
	color: transparent;
	background: rgba(17,17,27,1);
	transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
	background-color: #89b4fa;
	color: #11111B;
	border-radius: 16px;
	min-width: 20px;
	background-size: 400% 400%;
	transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
	background-color: #f5f5f5;
	color: #11111B;
	border-radius: 16px;
	min-width: 20px;
	background-size: 400% 400%;
      }

      #tray, #pulseaudio, #network, #battery,
      #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward{
	background: #25253a;
	font-weight: bold;
	margin: 5px 0px;
      }
      #tray, #pulseaudio, #network, #battery{
	color: #f5f5f5;
	border-radius: 10px 24px 10px 24px;
	padding: 0 20px;
	margin-left: 7px;
      }
      #clock {
	color: #f5f5f5;
	background: #25253a;
	border-radius: 0px 0px 0px 40px;
	padding: 5px 5px 10px 15px;
	margin-left: 7px;
	font-weight: bold;
	/*font-size: 16px;*/
      }
      #custom-launcher {
	color: #89b4fa;
	background: #25253a;
	border-radius: 0px 0px 40px 0px;
	margin: 0px;
	padding: 0px 35px 0px 15px;
	font-size: 14px;
      }

      #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward {
	background: #25253a;
	font-size: 22px;
      }
      #custom-playerctl.backward:hover, #custom-playerctl.play:hover, #custom-playerctl.foward:hover{
	color: #f5f5f5;
      }
      #custom-playerctl.backward {
	  color: #cba6f7;
	  border-radius: 24px 0px 0px 10px;
	  padding-left: 16px;
	  margin-left: 7px;
      }
      #custom-playerctl.play {
	  color: #89b4fa;
	  padding: 0 5px;
      }
      #custom-playerctl.foward {
	  color: #cba6f7;
	  border-radius: 0px 10px 24px 0px;
	  padding-right: 12px;
	  margin-right: 7px
      }
      #custom-playerlabel {
	  background: #25253a;
	  color: #f5f5f5;
	  padding: 0 20px;
	  border-radius: 24px 10px 24px 10px;
	  margin: 5px 0;
	  font-weight: bold;
      }
      #window{
	  background: #25253a;
	  padding-left: 15px;
	  padding-right: 15px;
	  border-radius: 16px;
	  margin-top: 5px;
	  margin-bottom: 5px;
	  font-weight: normal;
	  font-style: normal;
      }


    '';
  };
}

