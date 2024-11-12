{ inputs, pkgs, ... }:

{
  imports = [
    inputs.sddm-sugar-candy-nix.nixosModules.default
  ];
}

