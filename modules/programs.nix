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

 # Docker
 virtualisation.docker = {
	enable = true;
	rootless = {
		enable = true;
		setSocketVariable = true;
	};
 };

}
