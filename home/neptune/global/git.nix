{ lib, ... }:

{
  programs.git = {
    enable = true;
    userName  = "neptune";
    userEmail = "neptune@aurilia.ch";
  };

  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "github.com-underwater-communication-nix-config" = {
      hostname = "github.com";
      identityFile = "/home/neptune/.ssh/neptune@underwater-communication-nix-config";
    };
    "github.com-underwater-communication-software" = {
      hostname = "github.com";
      identityFile = "/home/neptune/.ssh/neptune@underwater-communication-software";
    };
  };
}
