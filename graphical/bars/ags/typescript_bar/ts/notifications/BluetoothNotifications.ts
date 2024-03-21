// needs `gnome.gnome-bluetooth` package
import Bluetooth from "resource:///com/github/Aylur/ags/service/bluetooth.js";

Bluetooth.connect("device-added", (service, deviceAddr) => {
  const device = Bluetooth.getDevice(deviceAddr);
  if (!device) {
    Utils.execAsync([
      "notify-send",
      "--expire-time=4000",
      `--urgency=critical`,
      `Connected ${deviceAddr}`,
      "No more information...",
    ]);
  }
  let urgency = "normal";
  const title = `${device?.name}`;
  let message = "Connected";

  const battery = Utils.exec(
    `bash -c 'bluetoothctl info ${deviceAddr} | grep "Battery Percentage" | cut -d " " -f 4 | sed "s/.*(\\(.*\\))/\\1/"'`
  );
  if (battery) {
    message = message += ` ${battery}%`;
    if (Number(battery) <= 20) {
      urgency = "critical";
    }
  }

  Utils.execAsync([
    "notify-send",
    "--expire-time=4000",
    `--urgency=${urgency}`,
    title,
    message,
  ]);
});

Bluetooth.connect("device-removed", (service, deviceAddr) => {
  const urgency = "critical";
  const device = Bluetooth.getDevice(deviceAddr);
  let message = "";
  if (device?.name) {
    message = `Device ${device.name} disconnected`;
  } else {
    message = `Device ${deviceAddr} disconnected`;
  }
  Utils.execAsync([
    "notify-send",
    "--expire-time=4000",
    `--urgency=${urgency}`,
    "Bluetooth Device Connected",
    message,
  ]);
});

// Utils.timeout(1000, () => {
//   Bluetooth.connected_devices.forEach((device) => {
//     const title = `${device.name}`;
//     const message = device.connected
//       ? `Connected ${device.battery_percentage}%`
//       : "Disconnected";
//     Utils.execAsync([
//       "notify-send",
//       "--expire-time=4000",
//       `--urgency=normal`,
//       title,
//       message,
//     ]);
//   });
// })
