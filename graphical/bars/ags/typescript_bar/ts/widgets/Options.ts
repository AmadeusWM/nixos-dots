import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";

const isRevealed = Variable(false);

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

const ButtonAudio = () =>
  Widget.Button({
    className: "audio-button",
    child: Widget.Label("AUDIO"),
    onPrimaryClick: (_, event) => {
      App.toggleWindow("audio");
    },
  });

const OptionsRevealer = () => {
  return Widget.Box({
    class_name: "options",
    child: Widget.EventBox({
      child: Widget.Box({
        children: [
          Widget.Revealer({
            transition_duration: 300,
            transition: "slide_left",
            child: Widget.Box({
              children: [SysTray(), ButtonAudio()],
            }),
          }).bind("reveal_child", isRevealed),
          Widget.Button({
            className: "options-button",
            child: Widget.Label({
              label: "OPT",
            }),
            on_primary_click: (self, event) => {
              isRevealed.setValue(!isRevealed.value);
              App.closeWindow("audio");
            },
          }),
        ],
      }),
    }),
  });
};

export default OptionsRevealer;
