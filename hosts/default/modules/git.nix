{ ... }:

{
  programs.git = {
    enable = true;
    userName = "bhhoang";
    userEmail = "canhchimcuajin@gmail.com";
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "bhhoang";
    extraConfig.credential.credentialStore = "cache";
  };
}

