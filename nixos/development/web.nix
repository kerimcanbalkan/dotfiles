{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    typescript-language-server
    vscode-langservers-extracted
    astro-language-server
    typescript
    typescript-language-server
    vscode-langservers-extracted
    astro-language-server
    nodejs_24
    nodePackages.prettier
    eslint
    eas-cli
    tailwindcss-language-server
  ];
}
