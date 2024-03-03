class CapsLockService extends Service {
  static {
    Service.register (
      this,
      {
        'caps-lock-changed': ['boolean']
      },
      {
        'caps-lock-value': ['boolean']
      }
    )
  }

  private capsLockValue: boolean = false;
  get caps_lock_value() {
    return this.capsLockValue
  }
  set caps_lock_value(value: boolean) {
    this.capsLockValue = value
  }

  private device = "input0::capslock"

  constructor() {
    super()
    const capsLock = `/sys/class/leds/${this.device}/brightness`
    Utils.monitorFile(capsLock, () => {console.log("caps lock changed"); this.onChange()}) // this doesn't work for some reason???
  }

  private onChange = () => {
    const value = Boolean(Utils.exec(`brightnessctl --device="${this.device}" get`));
    this.caps_lock_value = value
    console.log("setting caps value", value)
  }
}

const service = new CapsLockService

export default service