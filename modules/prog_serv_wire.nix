{ lib, config, pkgs, ... }:
{

  #####################################################
  ##----------------  Game-Settings  ----------------##
  #####################################################

  #fixex some issues with Linux support (steam games)
  programs.gamescope = {
    enable = true;
  };

  #Enable gamemode
  programs.gamemode = {
    enable = true;
  };


  #####################################################
  ##--------------------  Steam  --------------------##
  #####################################################

  programs.steam = {
	enable = true;
	#remotePlay.openFirewall = true;
	#dedicatedServer.openFirewall = true;
	#localNetworkGameTransfers.openFirewall = true;
  };


  #####################################################
  ##------------------  Wireshark  ------------------##
  #####################################################

 # Wireshark
 #  programs.wireshark = {
 #	enable = true;
 #  };
 # Work Wireguard
 #  networking.wg-quick.interfaces.work = {
 #   configFile = "/home/kaisel/Work/WireGuard.conf";
 #  autostart = false;
 # };



  #####################################################
  ##-----------------  Proton-Mail  -----------------##
  #####################################################

  environment.systemPackages = [ pkgs.protonmail-desktop ];


  #####################################################
  ##----------------  Virtualisation  ---------------##
  #####################################################

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
 
   virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.host.enableExtensionPack = true;
   environment.extraInit = ''
     export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
   '';
   programs.dconf.enable = true;


  #####################################################
  ##--------------------  Docker  -------------------##
  #####################################################

  virtualisation.docker = {
       enable = true;
       rootless = {
		enable = true;
		setSocketVariable = true;
       };
  };


  #####################################################
  ##-------------------  Printers  ------------------##
  #####################################################
  #May the Omnissiah bless this machine and uplift it's restricions imposed upon it by the malicious Printers,
  #for these Documents are meant to spread the will of the machine spirit. (F*ck it's not working)
  #Work in progress

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  #  openFirewall = true;
  };



  #####################################################
  ##--------------------  Sound  --------------------##
  #####################################################

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
    };
  };


  #####################################################
  ##-------------------  OpenSSH  -------------------##
  #####################################################

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };


  #####################################################
  ##---------------------  USB  ---------------------##
  #####################################################

  # Automount USB devices	-> not working entirely
  services.udisks2.enable = true;


  #####################################################
  ##---------------  SUID-wrappers?  ----------------##
  #####################################################

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}
