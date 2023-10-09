{ pkgs ? import <nixpkgs> {} }:

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
    pkgs.cargo
    pkgs.tmux
    pkgs.sshfs
    pkgs.rclone
    (pkgs.nnn.override { withNerdIcons = true; })
  ];

  shellHooks = ''
    source ~/.path
  '';
}
