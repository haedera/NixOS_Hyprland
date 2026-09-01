{pkgs, ...}: {
  # Greeter
#  services.greetd = {
#    enable = true;
#
#    settings = {
#      default_session = {
#        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
#        user = "greeter";
#      };
#    };
#  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  #  openFirewall = true;
  };

  # Enable Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # Automount USB devices
  services.udisks2.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  # enable gamescope to fix some issues with Linux support from steam games (mostly scaling issues)
  programs.gamescope = {
    enable = true;
};
}
