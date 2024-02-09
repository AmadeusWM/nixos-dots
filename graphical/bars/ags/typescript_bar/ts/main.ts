import { timeout, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { Left } from "./left";
import { NotificationPopup } from "./notifications/notificationPopups";
import { Monitor } from "types/service/hyprland";
import Window from "types/widgets/window";
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Gdk from "types/@girs/gdk-3.0/gdk-3.0";
import { Right } from "./right";
const hyprland = await Service.import("hyprland");

const Bar = (monitor: number ) => Widget.Window({
  name: `bar-${monitor}`, // name has to be unique
  className: 'bar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: "exclusive",
  child: Widget.CenterBox({
      startWidget: Left({monitor: monitor}),
      endWidget: Right(),
  }),
})

let bars: Window<any, any>[] = []

function range(length: number, start = 1) {
    return Array.from({ length }, (_, i) => i + start);
}

function initBars(){
    bars.forEach(bar => !bar.is_destroyed && bar.destroy())
    const monitorCount = Gdk.Display.get_default()?.get_n_monitors() || 1
    bars = range(monitorCount, 0).map(i => Bar(i))
}

Hyprland.connect("monitor-added", (service, ...args) => {
    console.log("args", args)
    initBars()
})

Hyprland.connect("monitor-removed", (service, ...args) => {
    console.log("args", args)
    initBars()
})

initBars()

// exporting the config so ags can manage the windows
export default {
    style: App.configDir + '/style.css',
    windows: [
        ...bars,
        NotificationPopup
    ],
};