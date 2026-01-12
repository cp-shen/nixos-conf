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
  programs.helix.enable = true;
  programs.zed-editor.enable = true;

  xdg.configFile."nvim".source = mkOutLink "${userConfDir}/nvim";
  xdg.configFile."doom".source = mkOutLink "${userConfDir}/doom";

  home.packages = with pkgs; [
    jetbrains.idea-community-bin
    neovim-unwrapped
  ];

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

  xdg.configFile."VSCodium/User/settings.json".source =
    mkOutLink "${userConfDir}/vscode/settings.json";
  xdg.configFile."VSCodium/User/keybindings.json".source =
    mkOutLink "${userConfDir}/vscode/keybindings.json";

  programs.vscode =
    # let
    #   myPython = pkgs.python310;
    #   lldb-plugin = pkgs.vscode-extensions.vadimcn.vscode-lldb.override {
    #     python3 = myPython;
    #   };
    #   lldb-plugin-wrapped = lldb-plugin.overrideAttrs (oldAttrs: {
    #     postFixup = ''
    #       wrapProgram $out/$installPrefix/adapter/codelldb \
    #         --prefix PATH : "${myPython}/bin" \
    #         --prefix LD_LIBRARY_PATH : "${myPython}/lib" \
    #         --set PYTHONPATH "${oldAttrs.passthru.lldb.lib}/${myPython.sitePackages}"
    #     '';
    #   });
    # in
    {
      enable = true;
      package = pkgs.vscode;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        ## C++ extensions
        vadimcn.vscode-lldb
        llvm-vs-code-extensions.vscode-clangd
        xaver.clang-format
        ms-vscode.hexeditor
        ms-vscode.makefile-tools
        ms-vscode.cmake-tools
        mesonbuild.mesonbuild

        ## Rust, Zig, Golang extensions
        rust-lang.rust-analyzer
        ziglang.vscode-zig
        golang.go

        ## Java and Scala extensions
        scala-lang.scala
        scalameta.metals
        redhat.java
        vscjava.vscode-java-pack
        vscjava.vscode-java-debug
        vscjava.vscode-java-dependency
        vscjava.vscode-java-test
        vscjava.vscode-gradle
        vscjava.vscode-maven

        ## Lua and Python extensions
        ms-python.python
        ms-python.debugpy
        charliermarsh.ruff
        sumneko.lua

        ## Misc other languages
        tamasfe.even-better-toml
        wgsl-analyzer.wgsl-analyzer
        jnoortheen.nix-ide
        davidanson.vscode-markdownlint
        myriad-dreamin.tinymist
        biomejs.biome

        ## Containers
        ms-azuretools.vscode-docker
        ms-azuretools.vscode-containers

        ## Utils
        vscodevim.vim
        k--kato.intellij-idea-keybindings
        bierner.docs-view
        codezombiech.gitignore
        github.vscode-github-actions

        ## LLM tools
        continue.continue

        ## Themes
        zhuangtongfa.material-theme
        github.github-vscode-theme
        vscode-icons-team.vscode-icons
      ];
    };
}
