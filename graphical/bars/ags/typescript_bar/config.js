import Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Gio from 'gi://Gio';

const entry = App.configDir + '/ts/main.ts'
const outdir = '/tmp/ags/js'

try {
    await Utils.execAsync([
        'bun', 'build', entry,
        '--outdir', outdir,
        '--external', 'resource://*',
        '--external', 'gi://*',
    ])
} catch (error) {
    console.error(error)
}

const main = await import(`file://${outdir}/main.js`)

const scssDirectories = [
    `${App.configDir}/style`,
    `${App.configDir}/style/core`
]
scssDirectories.forEach((dir) => {
    Utils.monitorFile(dir, reloadCss)
})

// Utils.monitorFile("/sys/devices/platform/i8042/serio0/input/input0/input0::capslock", () => {console.log("capslock changed")}, 'directory') // doesn't work
// Utils.monitorFile("/sys/class/backlight/amdgpu_bl0/brightness", () => {console.log("brightness changed")}) // works!

// reload function
function reloadCss() {
    console.log('reloading css')
    // main scss file (that includes other scss files)
    const scss = `${App.configDir}/style/style.scss` 

    // target css file
    const css = `${App.configDir}/style.css` // compile into 1 .css file

    // compile, reset, apply
    Utils.exec(`sassc ${scss} ${css}`)
    App.resetCss()
    App.applyCss(css)
}

export default main.default