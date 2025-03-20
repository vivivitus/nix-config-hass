{ lib, pkgs, config, outputs, ... }:

{
  imports = [
    ./cli.nix
    ./git.nix
    ./vscode.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  manual.manpages.enable = false;

  home = {
    username = lib.mkDefault "neptune";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/underwater-communication-nix-config";
    };
  };
}
