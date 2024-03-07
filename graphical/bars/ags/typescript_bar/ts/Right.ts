import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import CapsLockService from "./services/CapsLockService";
import { capsLock } from "./state/global";
import OptionsRevealer from "./widgets/Options";

const Separator = () => Widget.Box({ class_name: "separator" });

const BatteryLabel = () =>
  Widget.Box({
    className: "battery",
    children: [
      Widget.Label({
        setup: (self) =>
          self.hook(Battery, (self) => {
            const batterPercentage = Math.floor(Battery.percent)
            self.label = `${batterPercentage}%`;
            if (batterPercentage < 20){
              self.class_name = "low"
            } else {
              self.class_name = "high"
            }
          }),
      }),
    ],
  });

const Clock = () => Widget.Label({
    className: 'clock',
    setup: self => 
        self.poll(1000, self => execAsync(['date', '+%d-%m %H:%M:%S '])
            .then(date => self.label = date).catch(console.error)),
});

const CapsIndicator = () => Widget.Label({
  label: "CAPS",
  class_name: "caps caps-off",
  setup: (self) => self.hook(capsLock, (self) => {
    const capsOn = Utils.exec(`brightnessctl --device="input*::capslock" get`) == "1"
    self.class_name = capsOn ? "caps caps-on" : "caps caps-off"
    self.label = capsOn ? "CAPS ON" : "CAPS"
    self.visible = capsOn
  })
  // setup: (self) => self.bind("visible", CapsLockService, 'caps_lock_value', (value) => self.visible = value)
});

export const Right = () =>
  Widget.Box({
    hpack: "end",
    children: [
      CapsIndicator(),
      Separator(),
      OptionsRevealer(),
      Separator(),
      BatteryLabel(),
      Separator(),
      Clock(),
    ],
  });
