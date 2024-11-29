{pkgs, ...}:
{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      #ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      ms-python.python
      dracula-theme.theme-dracula
      vscodevim.vim
    ];
  };
}

