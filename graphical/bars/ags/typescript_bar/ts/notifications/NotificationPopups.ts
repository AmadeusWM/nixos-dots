import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { lookUpIcon } from "resource:///com/github/Aylur/ags/utils.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import notifications, { Notification } from "types/service/notifications";
import Box from "types/widgets/box";
import Gtk from "types/@girs/gtk-3.0/gtk-3.0";

const NotificationIcon = ({ app_entry, app_icon, image }) => {
  if (image) {
    return Widget.Box({
      css: `
                background-image: url("${image}");
                background-size: contain;
                background-repeat: no-repeat;
                background-position: center;
            `,
    });
  }

  let icon = "dialog-information-symbolic";
  if (lookUpIcon(app_icon)) icon = app_icon;

  if (app_entry && lookUpIcon(app_entry)) icon = app_entry;

  return Widget.Box({ child: Widget.Icon(icon) });
};

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} notif */
const NotificationWidget = (notif: Notification) => {
  const icon = Widget.Box({
    vpack: "start",
    className: "icon",
    child: NotificationIcon(notif),
  });

  const title = Widget.Label({
    class_name: "title",
    xalign: 0,
    justification: "left",
    hexpand: true,
    max_width_chars: 24,
    truncate: "end",
    wrap: true,
    label: notif.summary,
    use_markup: true,
  });

  const body = Widget.Label({
    class_name: "body",
    hexpand: true,
    use_markup: true,
    xalign: 0,
    justification: "left",
    label: notif.body,
    wrap: true,
  });

  const actions = Widget.Box({
    class_name: "actions",
    children: notif.actions.map(({ id, label }) =>
      Widget.Button({
        class_name: "action-button",
        on_clicked: () => notif.invoke(id),
        hexpand: true,
        child: Widget.Label(label),
      })
    ),
  });

  return Widget.EventBox({
    on_primary_click: () => notif.dismiss(),
    child: Widget.Box({
      class_name: `notification ${notif.urgency}`,
      vertical: true,
      children: [
        Widget.Box({
          children: [
            icon,
            Widget.Box({
              vertical: true,
              children: [title, body],
            }),
          ],
        }),
        actions,
      ],
    }),
  });
};

const Popups = () => {
  const notifs = new Map<number, Gtk.Widget>();

  const onNotified = (box: Box<Gtk.Widget, unknown>, id: number) => {
    const notif = Notifications.getNotification(id);
    if (!notif) return;
    notifs.delete(id);
    notifs.set(id, NotificationWidget(notif));
    box.children = Array.from(notifs.values()).reverse();
    Utils.timeout(200, () => {});
  };

  const onDismissed = (box: Box<Gtk.Widget, unknown>, id: number) => {
    if (notifs.size - 1 === 0) {
    }
    Utils.timeout(200, () => {
      notifs.get(id)?.destroy();
      notifs.delete(id);
    });
  };

  return Widget.Box({
    class_name: "notifications",
    vertical: true,
  })
    .hook(Notifications, onNotified, "notified")
    .hook(Notifications, onDismissed, "dismissed")
    .hook(Notifications, onDismissed, "closed");
};

export const NotificationPopup = () => {
  return Widget.Window({
    name: "notifications",
    anchor: ["top", "right"],
    child: Widget.Box({
      children: [Widget.Label(" "), Popups()],
    }),
    setup: (self) =>
      self.hook(Hyprland, (self) => {
        self.monitor = Hyprland.active.monitor.id;
      }),
  });
};
