{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    
    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      ls = "ls --color";
    };


    oh-my-zsh = {
      enable = true;
      plugins = [
	"git" "sudo"
      ];
    };
  };
}

