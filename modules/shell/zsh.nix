{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh_nix";
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "bira";
      };

      shellAliases = {
        ls = "ls --color=auto";
        ll = "ls -lav --ignore=..";
        l = "ls -lav --ignore.?*";
        la = "ls -A";

        ".." = "cd ..";

        mv = "mv -i";
        rm = "rm -i";

        nv = "nvim";
      };
    };
  };
}
