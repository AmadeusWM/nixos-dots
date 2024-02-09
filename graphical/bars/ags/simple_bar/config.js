// importing 
import App from 'resource:///com/github/Aylur/ags/app.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import PopupWindow from './PopupWindow.js';
import { VolumeMixerContent } from './Volume.js';

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, just make it a function
// then you can use it by calling simply calling it
const dispatch = ws => execAsync(`hyprctl dispatch workspace ${ws}`);

const workspaceIcons = {
    "1": "I",
    "2": "II",
    "3": "III",
    "4": "IV",
    "5": "V",
    "6": "VI",
    "7": "VII",
    "8": "VIII",
    "9": "IX",
    "10": "X",
    "11": "XI",
    "12": "XII",
    "13": "XIII",
    "14": "XIV",
    "15": "XV",
    "16": "XVI",
    "17": "XVII",
    "18": "XVIII",
    "19": "XIX",
    "21": "XXI",
    "22": "XXII",
    "23": "XXIII",
    "24": "XXIV",
    "25": "XXV",
    "26": "XXVI",
    "27": "XXVII",
    "28": "XXVIII",
    "29": "XXIX",
    "30": "XXX",
    "urgent": ""
}


const Workspaces = ({monitor}) => Widget.Box({
    className: 'workspaces',
    children: Array.from({ length: 30 }, (_, i) => i + 1).map(i => Widget.Button({
        setup: btn => btn.id = i,
        label: `${workspaceIcons[i]}`,
        onClicked: () => dispatch(i),
    })),
    connections: [[Hyprland, box => box.children.forEach(btn => {
        btn.visible = Hyprland.workspaces.some(ws => ws.id === btn.id && ws.monitorID === monitor);
        btn.className = Hyprland.active.workspace.id == btn.id ? 'focused' : ''
    })]],
});

const ClientTitle = () => Widget.Label({
    className: 'client-title',
    binds: [
        ['label', Hyprland.active.client, 'title'],
    ],
});

const Clock = () => Widget.Label({
    className: 'clock',
    connections: [
        // this is bad practice, since exec() will block the main event loop
        // in the case of a simple date its not really a problem
        [1000, self => self.label = exec('date "+%H:%M:%S %b %e."')],

        // this is what you should do
        [1000, self => execAsync(['date', '+%H:%M:%S %b %e.'])
            .then(date => self.label = date).catch(console.error)],
    ],
});

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
const Notification = () => Widget.Box({
    className: 'notification',
    children: [
        Widget.Icon({
            icon: 'preferences-system-notifications-symbolic',
            connections: [
                [Notifications, self => self.visible = Notifications.popups.length > 0],
            ],
        }),
        Widget.Label({
            connections: [[Notifications, self => {
                self.label = Notifications.popups[0]?.summary || '';
            }]],
        }),
    ],
});

const Media = () => Widget.Button({
    className: 'media',
    onPrimaryClick: () => Mpris.getPlayer('')?.playPause(),
    onScrollUp: () => Mpris.getPlayer('')?.next(),
    onScrollDown: () => Mpris.getPlayer('')?.previous(),
    child: Widget.Label({
        connections: [[Mpris, self => {
            const mpris = Mpris.getPlayer('');
            // mpris player can be undefined
            if (mpris)
                self.label = `${mpris.trackArtists.join(', ')} - ${mpris.trackTitle}`;
            else
                self.label = 'Nothing is playing';
        }]],
    }),
});

const BatteryLabel = () => Widget.Box({
    className: 'battery',
    children: [
        Widget.Label({
            connections: [[Battery, self => {
                self.label = `BAT ${Math.floor(Battery.percent / 10) * 10}%`;
            }]],
        }),
    ],
});

const SysTray = () => Widget.Box({
    className: "sys-tray",
    connections: [[SystemTray, self => {
        self.children = SystemTray.items.map(item => Widget.Button({
            child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
            onPrimaryClick: (_, event) => item.activate(event),
            onSecondaryClick: (_, event) => item.openMenu(event),
            binds: [['tooltip-markup', item, 'tooltip-markup']],
        }));
    }]],
});

const ButtonAudio = () => Widget.Button({
    className: 'audio-button',
    child: Widget.Label("AUDIO"),
    onPrimaryClick: (_, event) => { 
        App.toggleWindow('quicksettings');
    } 
})

const AudioMenu = () => PopupWindow({
    name: 'quicksettings',
    anchor: ['right', 'top'],
    transition: 'slide_down',
    child: VolumeMixerContent()
});

// layout of the bar
const Left = ({ monitor }) => Widget.Box({
    children: [
        Workspaces({monitor: monitor}),
        ClientTitle(),
    ],
});

const Center = () => Widget.Box({
    children: [
        Media(),
        Notification(),
    ],
});

const Right = () => Widget.Box({
    hpack: 'end',
    children: [
        SysTray(),
        ButtonAudio(),
        BatteryLabel(),
        Clock(),
    ],
});

const Bar = ({ monitor } = {}) => Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    className: 'bar',
    monitor,
    anchor: ['top', 'left', 'right'],
    exclusive: true,
    child: Widget.CenterBox({
        startWidget: Left({monitor: monitor}),
        centerWidget: Center(),
        endWidget: Right(),
    }),
})

const scss = App.configDir + '/style.scss';
const css = App.configDir + '/style.css';

exec(`sassc ${scss} ${css}`);



// exporting the config so ags can manage the windows
export default {
    style: App.configDir + '/style.css',
    windows: [
        // you can call it, for each monitor
        Bar({ monitor: 0 }),
        Bar({ monitor: 1 }),
        Bar({ monitor: 2 }),
        AudioMenu()
    ],
};
