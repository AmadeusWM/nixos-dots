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

const Tray = () => {
  return Widget.Box({
    class_name: "bar-tray",
    child: Widget.EventBox({
      child: Widget.Box({
        children: [
          Widget.Revealer({
            transition_duration: 300,
            transition: "slide_left",
            child: SysTray(),
          }).bind("reveal_child", isRevealed),
          Widget.Label("TR"),
        ],
      }),
      on_hover: (self, event) => {
        isRevealed.setValue(true);
      },
      on_hover_lost: (self, event) => {
        isRevealed.setValue(false);
      },
    })
  });
};

export default Tray;
