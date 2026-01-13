{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos-server"; # Define your hostname.
  programs.zsh.enable = true;

  # Enable BBR congestion control
  boot.kernelModules = ["tcp_bbr" "cifs"]; # Enables BBR
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr"; # Enables  BBR
  boot.kernel.sysctl."net.core.default_qdisc" = "fq"; # Sets QOS to fair queueing for outbound traffic
  boot.kernel.sysctl."net.core.wmem_max" = 1073741824; # 1 GiB
  boot.kernel.sysctl."net.core.rmem_max" = 1073741824; # 1 GiB
  boot.kernel.sysctl."net.ipv4.tcp_rmem" = "4096 87380 1073741824"; # 1 GiB max
  boot.kernel.sysctl."net.ipv4.tcp_wmem" = "4096 87380 1073741824"; # 1 GiB max

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "Mon 15:30";
    options = "--delete-older-than 20d";
  };

  # Enable automatic storage optimization
  nix.optimise = {
    automatic = true;
    dates = "Mon 15:30";
  };

  # Enable automatic deduplication of the Nix store
  nix.settings.auto-optimise-store = true;

  services.cron = {
    enable = true;
    systemCronJobs = [
      # Runs at 2am every Friday as mrbrooks
      "0 2 * * 5 mrbrooks bash /home/mrbrooks/backup_to_nas.sh"
      "0 5 * * 5 mrbrooks docker restart qbittorrent"
    ];
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "HomeLab" = {
        ingress = {
          "glance.mrbrooks.tech" = {
            service = "http://192.168.6.30:8084";
          };
          "nextcloud.mrbrooks.tech" = {
            service = "https://192.168.6.30:8043";
            originRequest = {noTLSVerify = true;};
          };
          "jellyfin.mrbrooks.tech" = {
            service = "http://192.168.6.30:8096";
          };
          "ssh.mrbrooks.tech" = {
            service = "ssh://localhost:22";
            originRequest = {proxyType = "";};
          };
          "portainer.mrbrooks.tech" = {
            service = "https://192.168.6.30:9443";
            originRequest = {noTLSVerify = true;};
          };
          "opnsense.mrbrooks.tech" = {
            service = "https://192.168.4.1";
            originRequest = {noTLSVerify = true;};
          };
          "proxmox.mrbrooks.tech" = {
            service = "https://192.168.4.25:8006";
            originRequest = {noTLSVerify = true;};
          };
          "adguard.mrbrooks.tech" = {
            service = "http://192.168.4.1:8080";
          };
        };
        credentialsFile = "/home/mrbrooks/.cloudflared/0bcf4c56-d7de-4308-a62d-21cd005c1ab5.json";
        default = "http_status:404";
      };
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable Vscode server
  services.openvscode-server.enable = true;

  # Enable nix-ld-rs to run non-nix executables
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
  };

  # List packages installed in system profile. To search, run:
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      mrbrooks = {
        isNormalUser = true;
        description = "MrBrooks";
        extraGroups = ["networkmanager" "wheel" "docker" "vscode-server"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    cifs-utils
    home-manager
    git
    kitty
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
