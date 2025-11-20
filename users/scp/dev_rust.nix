{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    rustup
    # (rust-bin.stable.latest.default.override {
    #   extensions = [ "rust-src" "rust-analyzer" ];
    # })
  ];
}
