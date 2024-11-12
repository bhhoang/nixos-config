{ ... }:

{
  programs.chromium.commandLineArgs = [
    "--enable-features=UseOzonePlatform" 
    "--enable-wayland-ime"
  ];
}

