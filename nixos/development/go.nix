{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    godef
    go
    gopls
    gofumpt
    golines
    gotools
    goimports-reviser
    gomodifytags
    gotests
    golangci-lint
    delve
  ];

  environment.variables = {
    GOPLS_FORMAT_TOOL = "gofumpt";
  };
}
