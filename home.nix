{ config, pkgs, inputs, lib, ... }:

{

        imports =
                [ 
                        ./starship.nix
                        ./zsh.nix
                        ./nvf-config.nix
                ];


        # Home Manager needs a bit of information about you and the paths it should
        # manage.
        home.username = "mrbrooks";
        home.homeDirectory = "/home/mrbrooks";


        home.stateVersion = "25.05"; # Please read the comment before changing.


        nixpkgs.config.allowUnfree = true;

        home.packages = with pkgs; [

                # CLI Utilites
                btop
                bat
                viu
                cloudflared
                chafa
                ueberzugpp
                eza
                fastfetch
                fd
                unzip
                tcpdump
                dig
                p7zip

                # Development
                bootdev-cli
                docker-compose
                go
                gcc
                python3
                nodejs
                stdenv.cc.cc.lib
                ripgrep
                wlr-protocols
                python3.pkgs.xkbcommon
                python3.pkgs.pywayland
                lua51Packages.jsregexp


        ];



        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
}
