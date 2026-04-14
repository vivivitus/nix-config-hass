{
  imports = [
    ./global
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name  = "vivivitus";
      email = "vivi_vitus@hotmail.com";
    };
  };

  programs.ssh.matchBlocks = {
    "github.com" = {
      hostname = "github.com";
      identityFile = "/home/vivian/.ssh/vivian@oskar";
    };
  };
}