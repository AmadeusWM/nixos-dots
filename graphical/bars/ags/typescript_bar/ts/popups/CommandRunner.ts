import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import Fuse, { IFuseOptions } from "../../node_modules/fuse.js/dist/fuse.js";
import Entry from "types/widgets/entry.js";

const query = Variable("");

type Command = {
  key: string;
  command: string;
  short?: string[];
};

const fuseOptions: IFuseOptions<any> = {
  minMatchCharLength: 0,
  keys: ["key", "short"],
};

const baprClient =
  "/home/amadeusw/projects/school/bapr/inf-bachpr-23-24-student-WolfM-2158257/tictactoe/client";
const baprServer =
  "/home/amadeusw/projects/school/bapr/inf-bachpr-23-24-student-WolfM-2158257/tictactoe/server";

const commands: Command[] = [
  {
    key: "nixos",
    command: "kitty --detach --hold sh -c 'hx ~/nixos'",
  },
  {
    key: "nix packages",
    short: ["pkgs"],
    command: "kitty --detach --hold sh -c 'hx ~/nixos'",
  },
  {
    key: "chatgpt",
    command: "firefox --new-window https://chat.openai.com/",
  },
  {
    key: "rust",
    command:
      "firefox 'https://doc.rust-lang.org/book/title-page.html' 'https://doc.rust-lang.org/rust-by-example/' 'https://github.com/mre/idiomatic-rust'",
  },
  {
    key: "github euthymia",
    command:
      "firefox --new-window https://github.com/users/AmadeusWM/projects/1",
  },
  {
    key: "bapr code",
    command: `bash -c "code '${baprClient}' && code '${baprServer}'"`,
  },
  {
    key: "bapr notes",
    command:
      "kitty --detach --hold sh -c 'hx /home/amadeusw/projects/school/bapr/inf-bachpr-23-24-student-WolfM-2158257/docs'",
  },
  {
    key: "bapr sites",
    // makes use of https://addons.mozilla.org/en-US/firefox/addon/open-url-in-container/
    // check firefox issue tracker: https://github.com/mozilla/multi-account-containers/issues/365
    command:
      "firefox 'ext+container:name=Work&url=https://docs.google.com/spreadsheets/d/1vsQ9AEYGxq6CH7EpFhXjnT6okCrVdPlI61n_2hRWrlY/edit' 'ext+container:name=Work&url=https://github.com/INF-Vakken-BachPr-23-24/inf-bachpr-23-24-student-WolfM-2158257/issues'",
  },
  {
    key: "bapr all",
    command:
      `bash -c "code '${baprClient}' && code '${baprServer}'` +
      "&" +
      `firefox 'ext+container:name=Work&url=https://docs.google.com/spreadsheets/d/1vsQ9AEYGxq6CH7EpFhXjnT6okCrVdPlI61n_2hRWrlY/edit' 'ext+container:name=Work&url=https://github.com/INF-Vakken-BachPr-23-24/inf-bachpr-23-24-student-WolfM-2158257/issues'` +
      "&" +
      `kitty --detach --hold sh -c 'hx /home/amadeusw/projects/school/bapr/inf-bachpr-23-24-student-WolfM-2158257/docs'\"`,
  },
  {
    key: "bapr chromium",
    command: `bash -c "hyprctl dispatch exec 'vivaldi  --new-window http://localhost:5173/' && hyprctl dispatch exec 'vivaldi  --new-window http://localhost:5173/'"`,
  },
];

const execCommand = async (command: Command) => {
  await execAsync(command.command);
};

const execCommandAndExit = (command: Command) => {
  execCommand(command);
  query.setValue("")
  App.toggleWindow("command-runner");
};

const filterCommands = () => {
  const fuse = new Fuse(commands, fuseOptions);
  const result = fuse.search(query.value);
  const filteredCommands = result.map((r) => r.item);
  return filteredCommands;
};

const CommandEntry = (command: Command) =>
  Widget.Button({
    class_name: "command-entry",
    xalign: 0,
    hexpand: true,
    child: Widget.Label({
      hexpand: true,
      label: command.key,
    }),
    on_clicked: () => {
      execCommandAndExit(command);
    },
  });

const CommandList = () => {
  return Widget.Box({
    class_name: "command-list",
    vertical: true,
    setup: (self) =>
      self.hook(query, (self) => {
        self.children = filterCommands().map((command, index: number) =>
          CommandEntry(command)
        );
      }),
  });
};

const Search = () => {
  return Widget.Box({
    class_name: "command-runner-search",
    children: [
      Widget.Label({ class_name: "prefix", label: ":" }),
      Widget.Entry({
        placeholder_text: "search",
        "can-focus": true,
        isFocus: true,
        on_change: (value: Entry<unknown>) =>
          (query.value = value.text ? value.text : ""),
        on_accept: () => {
          const commandsFiltered = filterCommands();
          if (commandsFiltered.length > 0) {
            execCommandAndExit(commandsFiltered[0]);
          }
        },
      }).bind("text", query),
    ],
  });
};

const Menu = () => {
  return Widget.Box({
    class_name: "menu",
    vertical: true,
    children: [Search(), CommandList()],
  });
};

export const CommandRunner = () =>
  Widget.Window({
    name: "command-runner",
    class_name: "command-runner",
    anchor: ["left", "top"],
    keymode: "exclusive",
    layer: "top",
    exclusivity: "ignore",
    visible: false,
    child: Menu(),
  }).keybind("Escape", () => {
    query.setValue("")
    App.closeWindow("command-runner");
  });
