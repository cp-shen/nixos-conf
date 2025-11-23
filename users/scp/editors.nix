# read: https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509

{
  config,
  lib,
  pkgs,
  mkOutLink,
  userConfDir,
  ...
}:

{

  xdg.configFile."nvim".source = mkOutLink "${userConfDir}/nvim";
  xdg.configFile."doom".source = mkOutLink "${userConfDir}/doom";

  home.packages = with pkgs; [ jetbrains.idea-community-bin ];

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

  xdg.configFile."Code/User/settings.json".source = mkOutLink "${userConfDir}/vscode/settings.json";
  xdg.configFile."Code/User/keybindings.json".source =
    mkOutLink "${userConfDir}/vscode/keybindings.json";

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
      profiles.default.extensions = with pkgs.vscode-extensions; [
        ## C++ extensions
        vadimcn.vscode-lldb
        llvm-vs-code-extensions.vscode-clangd
        xaver.clang-format
        ms-vscode.hexeditor
        ms-vscode.makefile-tools
        ms-vscode.cmake-tools
        mesonbuild.mesonbuild

        ## containers
        ms-azuretools.vscode-docker
        ms-azuretools.vscode-containers

        ## other languages
        wgsl-analyzer.wgsl-analyzer
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        ziglang.vscode-zig
        jnoortheen.nix-ide
        sumneko.lua
        ms-python.python
        ms-python.debugpy
        charliermarsh.ruff

        ## misc util extensions
        vscodevim.vim
        k--kato.intellij-idea-keybindings
        bierner.docs-view
        codezombiech.gitignore
        github.vscode-github-actions

        ## themes
        zhuangtongfa.material-theme
        github.github-vscode-theme
        vscode-icons-team.vscode-icons
      ];
    };
}
