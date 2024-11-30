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
    };
  };
}
