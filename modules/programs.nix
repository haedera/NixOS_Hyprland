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
 xdg.mime.enable = true;
 xdg.desktopEntries."proton-mail" = {
   name = "Proton Mail";
   genericName = "Mail Client";
   comment = "Proton Mail Desktop";
   exec = "proton-mail %U";
   icon = "proton-mail";
   terminal = false;
   categories = [ "Network" "Email" ];
   mimeType = [ "x-scheme-handler/mailto" ];
 };

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
