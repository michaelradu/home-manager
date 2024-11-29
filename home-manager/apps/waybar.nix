{pkgs, ...}:
{
  programs.waybar = {
    enable = true;
    style =''
      * {
	font-family: JetBrainsMono NF;
      }
    '';
  };
}

