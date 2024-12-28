# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }:
{
  # Which nixpkgs channel to use
  channel = "unstable"; # or "stable-24.11"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.fastfetch
    pkgs.mise
  ];
  # Sets environment variables in the workspace
  env = {
    PORT = "9002";
    HOST = "0.0.0.0";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "denoland.vscode-deno"
      "tamasfe.even-better-toml"
      "hverlin.mise-vscode"
    ];
    workspace = {
      onStart = { };
      onCreate = {
        install-deno = ''
          mise use --global bun@1.1.42
          mise use --global deno@2.1.4
          echo 'eval "$(mise activate bash)"' >> ~/.bashrc
        '';
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ "main.ts" ];
      };
    };
    # Enable previews and customize configuration
    previews = {
      enable = false;
      previews = {
        web = {
          command = [
            "deno"
            "run"
            "--watch"
            "--allow-all"
            "main.ts"
          ];
          manager = "web";
        };
      };
    };
  };
}