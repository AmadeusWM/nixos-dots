import Utils from 'resource:///com/github/Aylur/ags/utils.js';

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

Utils.monitorFile(
    // directory that contains the scss files (recursively for all scss files)
    `${App.configDir}/style`,

    // reload function
    function() {
        // main scss file (that includes other scss files)
        const scss = `${App.configDir}/style/style.scss` 

        // target css file
        const css = `${App.configDir}/style.css` // compile into 1 .css file

        // compile, reset, apply
        Utils.exec(`sassc ${scss} ${css}`)
        App.resetCss()
        App.applyCss(css)
    },

    // specify that its a directory, to make the monitor recursive
    'directory',
)

export default main.default