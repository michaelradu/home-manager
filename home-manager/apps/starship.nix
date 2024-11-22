{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      format = ''
      $username$hostname in $directory
      $character
      '';
      add_newline = true;
      hostname = {
	ssh_only = false;
	aliases = {"F15" = "Crim";};
      	#format = "@[$hostname](bold #bf5700) ";	
	format = "@[$hostname](bold purple)";
	
      };
      username = {
	show_always = true;
	style_user = "yellow";
	style_root = "red";
	format = "[$user]($style)";
      };
    };
  };
}

