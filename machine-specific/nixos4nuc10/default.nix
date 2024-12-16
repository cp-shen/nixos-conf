{
  imports = [
    ./fileSystems.nix
    ./gitea.nix
    ./gpu.nix
    ./hardware-configuration.nix
    #./jira.nix # deprecated
    ./networking.nix
    ./redmine.nix
  ];
}
