import { Left } from "./Left";
import { NotificationPopup } from "./notifications/NotificationPopups";
import Window from "types/widgets/window";
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import { Right } from "./Right";
import { AudioMenu } from "./popups/AudioMenu";
import { CommandRunner } from "./popups/CommandRunner";

const Bar = (monitor: number ) => Widget.Window({
  name: `bar-${monitor}`, // name has to be unique
  className: 'bar',
  monitor: monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: "exclusive",
  child: Widget.CenterBox({
      startWidget: Left({monitor: monitor}),
      endWidget: Right(),
  }),
})

let bars: Window<any, any>[] = []

function initBars(){
    bars.forEach(bar => !bar.is_destroyed && bar.destroy())
    bars = Hyprland.monitors.map(monitor => Bar(monitor.id))
}


Hyprland.connect("monitor-added", (service, ...args) => {
    console.log("args", args)
    initBars()
})

Hyprland.connect("monitor-removed", (service, ...args) => {
    console.log("args", args)
    initBars()
})

// delay to make sure `Hyprland` is ready
setTimeout(() => {
    initBars()
}, 500)

// exporting the config so ags can manage the windows
export default {
    style: App.configDir + '/style.css',
    windows: [
        ...bars,
        NotificationPopup(),
        AudioMenu(),
        CommandRunner()
    ],
};