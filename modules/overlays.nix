{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    inputs.sddm-sugar-candy-nix.overlays.default
    (final: prev: {
      # see https://github.com/NixOS/nixpkgs/issues/349012#issuecomment-2424719649
      openvpn3 = prev.openvpn3.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ./fix-tests.patch # Update the path to fix-tests.patch as needed
        ];
      });
    })
  ];
}

