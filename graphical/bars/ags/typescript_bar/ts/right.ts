import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const SysTray = () =>
  Widget.Box({
    className: "sys-tray",
    setup: (self) =>
      self.hook(SystemTray, (self) => {
        self.children = SystemTray.items.map((item) =>
          Widget.Button({
            child: Widget.Icon({
              setup: (self) => self.bind("icon", item, "icon"),
            }),
            onPrimaryClick: (_, event) => item.activate(event),
            onSecondaryClick: (_, event) => item.openMenu(event),
            setup: (self) =>
              self.bind("tooltip_markup", item, "tooltip_markup"),
          })
        );
      }),
  });

const BatteryLabel = () =>
  Widget.Box({
    className: "battery",
    children: [
      Widget.Label({
        setup: (self) =>
          self.hook(Battery, (self) => {
            const batterPercentage = Math.floor(Battery.percent / 10) * 10
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
        self.poll(1000, self => execAsync(['date', '+%H:%M:%S %a%e %b'])
            .then(date => self.label = date).catch(console.error)),
});

const ButtonAudio = () => Widget.Button({
    className: 'audio-button',
    child: Widget.Label("AUDIO"),
    onPrimaryClick: (_, event) => { 
        App.toggleWindow('quicksettings');
    } 
})

export const Right = () =>
  Widget.Box({
    hpack: "end",
    children: [
      // SysTray(),
      BatteryLabel(),
      Clock(),
      ButtonAudio(),
    ],
  });
