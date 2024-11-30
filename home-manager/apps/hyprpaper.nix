{pkgs, ...}:
{
  programs.hyprpaper = {
    enable = true;

    settings = {
      preload = [
	"~/.config/backgrounds/shaded.png"
      ];
      wallpaper = [
	", ~/.config/backgrounds/shaded.png"
      ];
    };
  };
}
