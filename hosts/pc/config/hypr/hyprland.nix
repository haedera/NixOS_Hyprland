{
  wayland.windowManager.hyprland.settings = {

    monitorv2 = [
      {
        output = "DP-2";
        mode = "2560x1440@180";
        position = "0x0";
        scale = 1;
        bitdepth = 10;
        cm = "hdredid";
        sdrbrightness = 1.22;
        sdrsaturation = 1;
      }

      {
        output = "HDMI-A-1";
        mode = "1920x1080@120";
        position = "2560x300";
        scale = 1;
        bitdepth = 8;
        cm = "auto";
      }

      {
        output = "DP-1";
        mode = "682x2560@60";
        position = "-682x0";
        scale = 1;
        bitdepth = 8;
        cm = "auto";
	transform = 90;  # rotate 90° counterclockwise
      }
    ];

    workspace = [
      "2, monitor:DP-2"
      "1, monitor:HDMI-A-1"
      "3, monitor:DP-1"
    ];

    input = {
      touchdevice = {
        output = "DP-1";
      };
    };
  };
}
