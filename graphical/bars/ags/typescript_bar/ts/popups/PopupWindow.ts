import AgsWindow from 'resource:///com/github/Aylur/ags/widgets/window.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import GObject from 'gi://GObject';
import Gtk from 'types/@girs/gtk-3.0/gtk-3.0';
import { Revealer } from 'resource:///com/github/Aylur/ags/widgets/revealer.js';
import { AgsWidget } from 'resource:///com/github/Aylur/ags/widgets/widget.js';

type Attr = {}
type Props = {
  transition: "none" | "crossfade" | "slide_right" | "slide_left" | "slide_up" | "slide_down"
  name: string
  child: AgsWidget<Gtk.Widget>
  visible: boolean
}

class PopupWindow extends AgsWindow<Gtk.Widget, Attr> {
    static { GObject.registerClass(this); }

    private revealer: Revealer<Gtk.Widget, any>;

    /** @param {import('types/widgets/window').WindowProps & {
     *      name: string
     *      child: import('types/widgets/box').default
     *      transition?: import('types/widgets/revealer').RevealerProps['transition']
     *  }} o
     */
    constructor({ name, child, transition = 'none', visible = false, ...rest }: Props) {
        super({
            ...rest,
            name,
            popup: true,
            focusable: true,
            class_names: ['popup-window', name],
        });

        child.toggleClassName('window-content');
        this.revealer = Widget.Revealer({
            transition,
            child,
            transitionDuration: 200,
            setup: self => self.hook(App, (_, wname, visible) => {
                if (wname === name)
                    this.revealer.reveal_child = visible;
            }),
        });

        this.child = Widget.Box({
            css: 'padding: 1px;',
            child: this.revealer,
        });

        this.show_all();
        this.visible = visible;
    }

    set transition(dir) { this.revealer.transition = dir; }
    get transition() { return this.revealer.transition; }
}



/** @param {import('types/widgets/window').WindowProps & {
 *      name: string
 *      child: import('types/widgets/box').default
 *      transition?: import('types/widgets/revealer').RevealerProps['transition']
 *  }} configimport { Widget } from 'resource:///com/github/Aylur/ags/widget.js';

 */
export default config => new PopupWindow(config);;
