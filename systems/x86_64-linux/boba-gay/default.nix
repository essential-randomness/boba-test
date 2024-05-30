{ pkgs, inputs,  ... }: {
  imports = [
    ./hardware.nix
    # Generated at runtime by nixos-infect
    ./networking.nix
    inputs.vscode-server.nixosModules.default
  ];

  services.openssh.enable = true;
  services.tailscale.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
  ];

  # services.bobaboard = {
  #   enable = true;
  #   database = {
  #     user = "boba-test";
  #     # host = "private-big-global-dboi-do-user-12927016-0.c.db.ondigitalocean.com";
  #     local = true;
  #     # port = 25060;
  #     port = 5432;
  #     name = "boba-test";
  #     # passwordFile = "/var/lib/bobaboard/db-password";
  #     # sslRootCertPath = "/var/lib/bobaboard/db-ca";
  #     seed = true;
  #   };

  #   server = {
  #     # This has to be an address whose DNS is mapped to this
  #     # server. It can be the address of any realm (or of no realm),
  #     # as long as the DNS is mapped.
  #     backend = {
  #       address = "api.bobaboard.gay";
  #     };
  #     name =  "^(?<subdomain>.+)bobaboard\.gay$";
  #   };

  #   firebaseCredentials = "/var/lib/bobaboard/firebase-sdk.json";
  # };

  programs.git.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins=["git" "vi-mode" "systemd" "z"];
    };
  };
  services.vscode-server.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE08e9yPCfh8kEp/sUxzF+hJIkOnoPCrjwjUNr3cdt2I"
  ];

  users.users.msboba = {
    isNormalUser = true;

    name = "msboba";
    initialPassword = "password";

    home = "/home/msboba";
    group = "users";
  
    shell = pkgs.zsh;

    # wheel is needed for sudo
    extraGroups = [ "wheel" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE08e9yPCfh8kEp/sUxzF+hJIkOnoPCrjwjUNr3cdt2I"
    ];
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "essential.randomn3ss@gmail.com";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}