{pkgs, ...}:
{
  programs.hyprlock = {
    enable=true;

    # Wrap hyprlock with the system's libpam, won't work... TODO: FIXME
#    package = pkgs.hyprlock.overrideAttrs (oldAttrs: rec {
 #     nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
  #    postInstall = ''
   #     makeWrapper $out/bin/hyprlock $out/bin/hyprlock \
    #      --set LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libpam.so.0
     # '';
    #});

    settings = {
      
      general = {
	disable_loading_bar = true;
	grace = 300;
	hide_cursor = true;
	no_fade_in = false;
      };

      background = [
            {
              monitor = "";
              #path = "/tmp/screenshot1.png";

              blur_passes = 1; # 0 disables blurring
              blur_size = 7;
              noise = 1.17e-2;
            }
            {
              monitor = "HDMI-A-1";
              #path = "/tmp/screenshot2.png";

              blur_passes = 2; # 0 disables blurring
              blur_size = 7;
              noise = 1.17e-2;
            }
          ];

          label = [
            {
              monitor = "DP-2";
              text = "$TIME";
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 95;
              font_family = "JetBrains Mono";
              position = "0, 300";
              halign = "center";
              valign = "center";
            }
            {

              monitor = "";
              text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 22;
              font_family = "JetBrains Mono";
              position = "0, 200";
              halign = "center";
              valign = "center";

            }
          ];

          image = {
            monitor = "";
            #path = "/home/alex/Pictures/profile.png";

            position = "0, 50";
            halign = "center";
            valign = "center";
          };

          input-field = {
            monitor = "";
            size = "200,50";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color = "rgba(0, 0, 0, 0)";
            inner_color = "rgba(0, 0, 0, 0.2)";
            font_color = "rgb(111, 45, 104)";
            fade_on_empty = false;
            rounding = -1;
            check_color = "rgb(30, 107, 204)";
            placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
            hide_input = false;
            position = "0, -100";
            halign = "center";
            valign = "center";  
	};
      };
  };
}
