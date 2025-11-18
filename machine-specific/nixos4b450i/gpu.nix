{pkgs, inputs, ...}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = false;
    package = pkgs.nixos25.mesa;
  };
}
