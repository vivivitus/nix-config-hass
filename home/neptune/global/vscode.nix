{ pkgs, ... }:

{
  programs.vscode = {
    enable = false;
    # extensions = with pkgs.vscode-extensions; [
    #   jnoortheen.nix-ide
    # ];
  };
}
