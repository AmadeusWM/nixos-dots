{ pkgs, config, lib, osConfig, ... }:
let 
  lock = "${lib.getExe pkgs.swaylock} -c000000";
in
{
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];
  services.swayidle = {
    enable = true;
    # start as part of hyprland instead of sway
    extraArgs = ["-w"];
    # Turn screen off
    timeouts = [
      {
        timeout = 1800;
          command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
          resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
      # {
      #   timeout = 2040;
      #   command = "${lock}";
      # }
      {
        timeout = 2100;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
