{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake /etc/nixos\\#default";


    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = ''
      source ~/.p10k.zsh
    '';

    antidote = {
      package = pkgs.antidote;
      enable = true;
      plugins = [''
        belak/zsh-utils path:editor
        jeffreytse/zsh-vi-mode
        mattmc3/ez-compinit
        zsh-users/zsh-completions kind:fpath path:src
        romkatv/zsh-bench kind:path
        olets/zsh-abbr kind:defer
        belak/zsh-utils path:history
        belak/zsh-utils path:prompt
        belak/zsh-utils path:utility
        romkatv/powerlevel10k kind:zsh
        mattmc3/zfunctions
        zsh-users/zsh-autosuggestions
        zdharma-continuum/fast-syntax-highlighting kind:defer
        zsh-users/zsh-history-substring-search
      ''];
    };
  };
}

