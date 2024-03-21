import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { lookUpIcon } from "resource:///com/github/Aylur/ags/utils.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import notifications, { Notification } from "types/service/notifications";
import { Box } from "resource:///com/github/Aylur/ags/widgets/box.js";
import "./BluetoothNotifications"

function getRandomInt(max: number) {
  return Math.floor(Math.random() * max);
}

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

  let icon = "";
  if (lookUpIcon(app_icon)) icon = app_icon;

  // if (app_entry && lookUpIcon(app_entry)) icon = app_entry;
  if (icon) {
    return Widget.Box({ child: Widget.Icon(icon) });
  }else {
    return Widget.Box({});
  }
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
    // max_width_chars: 24,
    truncate: "end",
    hexpand: true,
    wrap: true,
    use_markup: true,
    label: notif.summary,
  });

  const body = Widget.Label({
    class_name: "body",
    xalign: 0,
    justification: "left",
    hexpand: true,
    wrap: true,
    use_markup: true,
    label: notif.body,
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

  const notifWidget = Widget.EventBox({
    on_primary_click: () => notif.dismiss(),
    child: Widget.Box({
      class_name: `notification ${notif.urgency}`,
      setup: (self) =>
        self.hook(
          notif,
          () => {
            if (notif.popup) {
              Utils.timeout(300, () => {
                self.toggleClassName("enter2");
              });
            } else {
              self.toggleClassName("enter2");
              Utils.timeout(300, () => {
                self.toggleClassName("leave");
              });
            }
          },
          "dismissed"
        ),
      children: [
        Widget.Box({
          className: "urgency-indicator",
        }),
        Widget.Box({
          className: "content",
          vexpand: true,
          vertical: true,
          children: [
            Widget.Box({
              className: "text",
              vexpand: true,
              vpack: "center",
              children: [
                Widget.Box({
                  vpack: "center",
                  vertical: true,
                  children: [title, body],
                }),
                icon,
              ],
            }),
            actions,
          ],
        }),
      ],
    }),
  });
  console.log("urgency: ", notif.urgency);
  const hider = Widget.EventBox({
    class_name: `hider ${notif.urgency}`,
    setup: (self) =>
      self.hook(
        notif,
        () => {
          if (notif.popup) {
            self.toggleClassName("enter");
            Utils.timeout(300, () => {
              self.toggleClassName("enter2");
              self.toggleClassName("enter");
            });
          } else {
            self.toggleClassName("enter2");
            self.toggleClassName("leave");
            Utils.timeout(300, () => {
              self.toggleClassName("leave2");
              self.toggleClassName("leave");
            });
          }
        },
        "dismissed"
      ),
  });

  return Widget.Box({
    class_name: "notification-overlay",
    child: Widget.Overlay({
      overlays: [hider],
      child: notifWidget,
    }),
  });
};

const Popups = () => {
  const notifs = new Map<number, Box<any, any>>();

  const onNotified = (box: Box<any, unknown>, id: number) => {
    const notif = Notifications.getNotification(id);
    if (!notif) return;
    const notifId = getRandomInt(1000000);
    notifs.delete(notifId);
    const notifWidget = NotificationWidget(notif);
    notifs.set(notifId, notifWidget);
    box.children = Array.from(notifs.values()).reverse();

    Utils.timeout(notif.timeout + 300, () => {
      notif.dismiss(); // TODO: fix, spotify notifications always have the same ID, and are thus dismissed in a weird order
      Utils.timeout(300, () => {
        console.log("destroying");
        notifWidget.destroy();
        notifs.delete(notifId);
      });
    });
  };

  return Widget.Box({
    class_name: "notifications",
    vertical: true,
  }).hook(Notifications, onNotified, "notified");
};

export const NotificationPopup = () => {
  return Widget.Window({
    name: "notifications",
    className: "notifications",
    anchor: ["top", "left"],
    child: Widget.Box({
      children: [Popups(), Widget.Label(" ")],
    }),
    setup: (self) =>
      self.hook(Hyprland, (self) => {
        self.monitor = Hyprland.active.monitor.id;
      }),
  });
};
