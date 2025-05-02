# read: https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509

{ config, lib, pkgs, mkOutLink, userConfDir, ... }:

{

  xdg.configFile."nvim".source = mkOutLink "${userConfDir}/nvim";
  xdg.configFile."doom".source = mkOutLink "${userConfDir}/doom";

  #home.packages = with pkgs; [ jetbrains.idea-community jetbrains.rider ];

  programs.emacs = {
    enable = true;
    # package = pkgs.emacsUnstable;
    package = pkgs.emacs;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  services.emacs.enable = false;
  # FIXME: emacs as daemon not usable now (with some environment error)
  # magit complains about empty ident
  # vterm can't init starship

  programs.vscode =
    let
      myPython = pkgs.python310;
      lldb-plugin = pkgs.vscode-extensions.vadimcn.vscode-lldb.override {
        python3 = myPython;
      };
      lldb-plugin-wrapped = lldb-plugin.overrideAttrs (oldAttrs: {
        postFixup = ''
          wrapProgram $out/$installPrefix/adapter/codelldb \
            --prefix PATH : "${myPython}/bin" \
            --prefix LD_LIBRARY_PATH : "${myPython}/lib" \
        '';
            #--set PYTHONPATH "${oldAttrs.passthru.lldb.lib}/${myPython.sitePackages}"
      });
    in
    {
      enable = true;
      extensions = [
        lldb-plugin-wrapped
      ];
    };
}
