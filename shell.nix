{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/5148520bfab61f99fd25fb9ff7bfbb50dad3c9db.tar.gz") {} }:

pkgs.mkShell {
  packages = [
    pkgs.which
    pkgs.htop
    pkgs.zlib
    pkgs.neovim
    pkgs.git
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.volta
    pkgs.curl
    pkgs.bat
    pkgs.fzf
    pkgs.jq
    pkgs.w3m
    pkgs.fd
    pkgs.diff-so-fancy
  ];

  shellHook = ''
    source ~/.path
  '';
}
