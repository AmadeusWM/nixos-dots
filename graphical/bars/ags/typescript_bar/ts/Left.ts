import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const hyprland = await Service.import("hyprland");

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, just make it a function
// then you can use it by calling simply calling it
const dispatch = (ws: number) => execAsync(`hyprctl dispatch workspace ${ws}`);

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
  "20": "XX",
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
  urgent: "",
};

const Workspaces = ({ monitor }) =>
  Widget.Box({
    className: "workspaces",
    children: Array.from({ length: 31 }, (_, i) => i + 1).map((i) =>
      Widget.Button({
        setup: (btn) => (btn.attribute = i),
        label: `${workspaceIcons[i]}`,
        onClicked: () => dispatch(i),
      })
    ),
    setup: (self) =>
      self.hook(hyprland, (box) =>
        box.children.forEach((btn) => {
          btn.visible = hyprland.workspaces.some(
            (ws) => ws.id === btn.attribute && ws.monitorID === monitor
          );
          btn.class_name =
            hyprland.active.workspace.id == btn.attribute ? "focused" : "";
        })
      ),
  });

const ClientTitle = () =>
  Widget.Label({
    className: "client-title",
    setup: (self) =>
      self.hook(hyprland, (self) => {
        const client = hyprland.active.client;
        if (client.class && client.title) {
          self.label = `${client.class} ✦ ${client.title}`;
        } else {
          self.label = client.class; // pick class in case it exists
        }
      }),
  });

// layout of the bar
export const Left = ({ monitor }) =>
  Widget.Box({
    children: [Workspaces({ monitor: monitor }), ClientTitle()],
  }).hook(App, (self, windowName, visible)=> {
    if (windowName === "command-runner") {
      self.visible = !visible
    }
  }, "window-toggled");
