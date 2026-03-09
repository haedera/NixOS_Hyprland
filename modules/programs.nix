{ lib, config, pkgs, ... }:
{
 # Steam (enable, and open ports)
  programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	localNetworkGameTransfers.openFirewall = true;
  };

 # Wireshark
  programs.wireshark = {
	enable = true;
  };

 # Proton-Mail
  environment.systemPackages = [ pkgs.protonmail-desktop ];

  environment.etc."xdg/applications/proton-mail.desktop".text = ''
    [Desktop Entry]
    Name=Proton Mail
    GenericName=Mail Client
    Comment=Proton Mail Desktop
    Exec=proton-mail %U
    Terminal=false
    Type=Application
    Categories=Network;Email;
    MimeType=x-scheme-handler/mailto;
  '';

 # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
 
 #Virtualisierung
   virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.host.enableExtensionPack = true;
   environment.extraInit = ''
     export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
   '';
   programs.dconf.enable = true;

 # Docker
  virtualisation.docker = {
       enable = true;
       rootless = {
		enable = true;
		setSocketVariable = true;
       };
  };

}
