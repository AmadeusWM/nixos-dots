import { timeout, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { Left } from "./left";
import { NotificationPopup } from "./notifications/notificationPopups";
import { Monitor } from "types/service/hyprland";
import Window from "types/widgets/window";
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Gdk from "types/@girs/gdk-3.0/gdk-3.0";
import { Right } from "./right";
import PopupWindow from "./popups/PopupWindow";
import { VolumeMixerContent } from "./notifications/volume";

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

// delay so that Hyprland can be initialized
setTimeout(() => {
    initBars()
}, 500)
 

const AudioMenu = () => PopupWindow({
    name: 'quicksettings',
    anchor: ['right', 'top'],
    transition: 'slide_down',
    child: VolumeMixerContent()
});

// exporting the config so ags can manage the windows
export default {
    style: App.configDir + '/style.css',
    windows: [
        ...bars,
        NotificationPopup(),
        AudioMenu()
    ],
};