{
  programs.git = {
    enable = true;
    userName = "Michael";
    userEmail = "miihairadu@gmail.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
    extraConfig = {
      credential.helper = "manager";
      credential.credentialStore = "secretservice";
    };
  };
}

