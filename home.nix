{
  config,
  pkgs,
  ...
}: let
  username = "dog";
  homeStateVersion = "26.05";
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = homeStateVersion;
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      cls = "clear";
      ".." = "cd ..";
      ll = "ls -l";
    };
  };

  home.packages = with pkgs; [
    neovim
    ripgrep
    kitty
    thunar
  ];
}
