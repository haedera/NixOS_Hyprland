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
