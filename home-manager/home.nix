{

  imports = [
    ./zsh.nix
    ./modules/bundle.nix
  ];

  home = {
    username = "ssstein";
    homeDirectory = "/home/ssstein";
    stateVersion = "23.11";
  };
}
