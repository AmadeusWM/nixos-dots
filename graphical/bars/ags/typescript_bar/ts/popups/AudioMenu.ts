import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import { substitute } from "ts/utils/helpers";
import icons from "ts/utils/icons";
import { Align } from "types/@girs/gtk-3.0/gtk-3.0.cjs";
import { Stream } from "types/service/audio";

function getAudioTypeIcon(icon) {
  const substitues = [
    ["audio-headset-bluetooth", icons.audio.type.headset],
    ["audio-card-analog-usb", icons.audio.type.speaker],
    ["audio-card-analog-pci", icons.audio.type.card],
  ];

  return substitute(substitues, icon);
}

const SinkItem = (stream: Stream) =>
  Widget.Button({
    hexpand: true,
    on_clicked: () => (Audio.speaker = stream),
    class_name: "sink-item" + (stream.id === Audio.speaker.id ? " active" : ""),
    child: Widget.Box({
      children: [
        Widget.Icon({
          class_name: "sink-icon",
          icon: getAudioTypeIcon(stream.icon_name || ""),
          tooltip_text: stream.icon_name,
        }),
        Widget.Label(
          (stream.description || "").split(" ").slice(0, 4).join(" ")
        ),
        Widget.Icon({
          icon: icons.ui.tick,
          hexpand: true,
          hpack: "end",
        }).bind("visible", Audio, "speaker", (s) => s === stream),
      ],
    }),
  });

const VolumeSlider = () =>
  Widget.Box({
    hexpand: true,
    vertical: false,
    class_name: "volume-slider-box",
    children: [
      Widget.Icon({
        class_name: "volume-icon",
        icon: icons.audio.volume.high,
      }),
      Widget.Slider({
        class_name: "volume-slider",
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => (Audio.speaker.volume = value),
      }).bind("value", Audio.speaker, "volume"),
    ],
  });

// todo: combine with VolumeSlider
const MicrophoneSlider = () =>
  Widget.Box({
    hexpand: true,
    vertical: false,
    class_name: "volume-slider-box",
    children: [
      Widget.Icon({
        class_name: "volume-icon",
        icon: icons.audio.mic.high,
      }),
      Widget.Slider({
        class_name: "volume-slider",
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => (Audio.microphone.volume = value),
      }).bind("value", Audio.microphone, "volume"),
    ],
  });

const SinkSelector = () =>
  Widget.Box({
    name: "sink-selector",
    class_name: "sink-selector",
    vertical: true,
    children: [
      Widget.Box({
        vertical: true,
      }).bind("children", Audio, "speakers", (s) => s.map(SinkItem)),
      VolumeSlider(),
      MicrophoneSlider(),
    ],
  });

const MixerItem = (stream) =>
  Widget.Box({
    hexpand: true,
    valign: Align.CENTER,
    class_name: "mixer-item horizontal",
    children: [
      Widget.Icon({
        class_name: "mixer-icon",
      })
        .bind("tooltip_text", stream, "name")
        .hook(stream, (icon) => {
          icon.icon = Utils.lookUpIcon(stream.name || "")
            ? stream.name || ""
            : icons.mpris.fallback;
        }),
      Widget.Box({
        vertical: true,
        class_name: "mixer-content",
        children: [
          Widget.Label({
            xalign: 0,
            truncate: "end",
          }).bind("label", stream, "description"),
          Widget.Slider({
            class_name: "mixer-slider",
            hexpand: true,
            draw_value: false,
            on_change: ({ value }) => (stream.volume = value),
          }).bind("value", stream, "volume"),
        ],
      }),
      Widget.Label({
        class_name: "mixer-percentage",
        xalign: 1,
      }).hook(stream, (l) => {
        l.label = `${Math.floor(stream.volume * 100)}%`;
      }),
    ],
  });

const AppMixer = () =>
  Widget.Box({
    name: "app-mixer",
    class_name: "app-mixer",
    children: [
      Widget.Box({
        vertical: true,
      }).bind("children", Audio, "apps", (audio: Stream[]) => {
        return audio.map(MixerItem);
      }),
    ],
  });

const VolumeMixerContent = () =>
  Widget.Box({
    vertical: true,
    children: [
      Widget.Box({
        class_name: "sliders-box vertical",
        vertical: true,
        children: [SinkSelector(), AppMixer()],
      }),
    ],
  });

export const AudioMenu = () =>
  Widget.Window({
    name: "audio",
    anchor: ["right", "top"],
    visible: false,
    keymode: "on-demand",
    child: VolumeMixerContent(),
  }).keybind("Escape", () => App.closeWindow("audio"));
