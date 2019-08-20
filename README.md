# dzen-dhall plugins

A set of curated plugins for [dzen-dhall](https://github.com/dzen-dhall/dzen-dhall).

Follow [the instructions](https://github.com/dzen-dhall/dzen-dhall#installing-plugins) to install any of them.

You are welcome to contribute yours via pull requests. The advantage of doing so is that your plugins will be updated by maintainer(s) in case of a breaking API change, and other users will be able to easily discover your code.

# Requirements

To be merged into this repo, a plugin must fulfill these requirements:

- It must not contain URL imports in dhall code. We aim to support fully offline usage.
- `usage` section of the meta field should contain a complete example that is ready to be copy-pasted by users to their `config.dhall`s.
- Plugin code should be human-readable.
- If a plugin emits events or contains automata, it should be wrapped in a separate [`scope`](https://github.com/dzen-dhall/dzen-dhall#scopes).
- If a plugin calls binaries, it should check if they are present in `PATH` using [assertions](https://github.com/dzen-dhall/dzen-dhall#assertions). If it depends on particular versions of the binaries, it should contain a `SuccessfulExit` assertion where version checks should be performed.
- `description` should not contain distribution-specific instructions for installing depndencies, e.g. "run `apt-get install foo`" is bad, "Install `foo` using you package manager" is good.

# Good advices

These are optional, but always good to have.

- A plugin should be fixed-width, i.e. occupy the same area on the screen during runtime. Use [trimming](https://github.com/dzen-dhall/dzen-dhall#trimming-text) and [padding](https://github.com/dzen-dhall/dzen-dhall#padding-text) functions to achieve this.
- Put a `preview.png` of your plugin in its folder (if applicable), and add a new entry to the list below (preserving alphabetic ordering).

# Catalogue

A list of all available plugins.

## date

A wrapper over `date` binary, prints current date formatted according to a given format string.

Run `dzen-dhall plug date` to install.

<details><summary><strong>Show usage</strong></summary>
<p>

```dhall
let date = (./plugins/date.dhall).main

in plug (date "%d.%m.%Y %A - %H:%M:%S")
```

</p>
</details>

## icons

A pack of XBM icons.

![Preview](icons/preview.png)

<details><summary><strong>Show detailed previews</strong></summary>
<p>


| Name           | Preview                                                                     |
|----------------|-----------------------------------------------------------------------------|
| `ac_01`        | ![icons/previews/ac_01.xbm.png](icons/previews/ac_01.xbm.png)               |
| `ac`           | ![icons/previews/ac.xbm.png](icons/previews/ac.xbm.png)                     |
| `alert`        | ![icons/previews/alert.xbm.png](icons/previews/alert.xbm.png)               |
| `arch_10x10`   | ![icons/previews/arch_10x10.xbm.png](icons/previews/arch_10x10.xbm.png)     |
| `arch`         | ![icons/previews/arch.xbm.png](icons/previews/arch.xbm.png)                 |
| `ball`         | ![icons/previews/ball.xbm.png](icons/previews/ball.xbm.png)                 |
| `bat_empty_01` | ![icons/previews/bat_empty_01.xbm.png](icons/previews/bat_empty_01.xbm.png) |
| `bat_empty_02` | ![icons/previews/bat_empty_02.xbm.png](icons/previews/bat_empty_02.xbm.png) |
| `bat_full_01`  | ![icons/previews/bat_full_01.xbm.png](icons/previews/bat_full_01.xbm.png)   |
| `bat_full_02`  | ![icons/previews/bat_full_02.xbm.png](icons/previews/bat_full_02.xbm.png)   |
| `bat_low_01`   | ![icons/previews/bat_low_01.xbm.png](icons/previews/bat_low_01.xbm.png)     |
| `bat_low_02`   | ![icons/previews/bat_low_02.xbm.png](icons/previews/bat_low_02.xbm.png)     |
| `battery`      | ![icons/previews/battery.xbm.png](icons/previews/battery.xbm.png)           |
| `bluetooth`    | ![icons/previews/bluetooth.xbm.png](icons/previews/bluetooth.xbm.png)       |
| `bug_01`       | ![icons/previews/bug_01.xbm.png](icons/previews/bug_01.xbm.png)             |
| `bug_02`       | ![icons/previews/bug_02.xbm.png](icons/previews/bug_02.xbm.png)             |
| `cat`          | ![icons/previews/cat.xbm.png](icons/previews/cat.xbm.png)                   |
| `clock`        | ![icons/previews/clock.xbm.png](icons/previews/clock.xbm.png)               |
| `cpu`          | ![icons/previews/cpu.xbm.png](icons/previews/cpu.xbm.png)                   |
| `dish`         | ![icons/previews/dish.xbm.png](icons/previews/dish.xbm.png)                 |
| `diskette`     | ![icons/previews/diskette.xbm.png](icons/previews/diskette.xbm.png)         |
| `empty`        | ![icons/previews/empty.xbm.png](icons/previews/empty.xbm.png)               |
| `envelope`     | ![icons/previews/envelope.xbm.png](icons/previews/envelope.xbm.png)         |
| `eye_l`        | ![icons/previews/eye_l.xbm.png](icons/previews/eye_l.xbm.png)               |
| `eye_r`        | ![icons/previews/eye_r.xbm.png](icons/previews/eye_r.xbm.png)               |
| `fox`          | ![icons/previews/fox.xbm.png](icons/previews/fox.xbm.png)                   |
| `fs_01`        | ![icons/previews/fs_01.xbm.png](icons/previews/fs_01.xbm.png)               |
| `fs_02`        | ![icons/previews/fs_02.xbm.png](icons/previews/fs_02.xbm.png)               |
| `full`         | ![icons/previews/full.xbm.png](icons/previews/full.xbm.png)                 |
| `fwd`          | ![icons/previews/fwd.xbm.png](icons/previews/fwd.xbm.png)                   |
| `half`         | ![icons/previews/half.xbm.png](icons/previews/half.xbm.png)                 |
| `info_01`      | ![icons/previews/info_01.xbm.png](icons/previews/info_01.xbm.png)           |
| `info_02`      | ![icons/previews/info_02.xbm.png](icons/previews/info_02.xbm.png)           |
| `info_03`      | ![icons/previews/info_03.xbm.png](icons/previews/info_03.xbm.png)           |
| `mail`         | ![icons/previews/mail.xbm.png](icons/previews/mail.xbm.png)                 |
| `mem`          | ![icons/previews/mem.xbm.png](icons/previews/mem.xbm.png)                   |
| `mouse_01`     | ![icons/previews/mouse_01.xbm.png](icons/previews/mouse_01.xbm.png)         |
| `music`        | ![icons/previews/music.xbm.png](icons/previews/music.xbm.png)               |
| `net_down_01`  | ![icons/previews/net_down_01.xbm.png](icons/previews/net_down_01.xbm.png)   |
| `net_down_02`  | ![icons/previews/net_down_02.xbm.png](icons/previews/net_down_02.xbm.png)   |
| `net_down_03`  | ![icons/previews/net_down_03.xbm.png](icons/previews/net_down_03.xbm.png)   |
| `net_up_01`    | ![icons/previews/net_up_01.xbm.png](icons/previews/net_up_01.xbm.png)       |
| `net_up_02`    | ![icons/previews/net_up_02.xbm.png](icons/previews/net_up_02.xbm.png)       |
| `net_up_03`    | ![icons/previews/net_up_03.xbm.png](icons/previews/net_up_03.xbm.png)       |
| `net_wired`    | ![icons/previews/net_wired.xbm.png](icons/previews/net_wired.xbm.png)       |
| `next`         | ![icons/previews/next.xbm.png](icons/previews/next.xbm.png)                 |
| `note`         | ![icons/previews/note.xbm.png](icons/previews/note.xbm.png)                 |
| `pacman`       | ![icons/previews/pacman.xbm.png](icons/previews/pacman.xbm.png)             |
| `pause`        | ![icons/previews/pause.xbm.png](icons/previews/pause.xbm.png)               |
| `phones`       | ![icons/previews/phones.xbm.png](icons/previews/phones.xbm.png)             |
| `play`         | ![icons/previews/play.xbm.png](icons/previews/play.xbm.png)                 |
| `plug`         | ![icons/previews/plug.xbm.png](icons/previews/plug.xbm.png)                 |
| `prev`         | ![icons/previews/prev.xbm.png](icons/previews/prev.xbm.png)                 |
| `rwd`          | ![icons/previews/rwd.xbm.png](icons/previews/rwd.xbm.png)                   |
| `scorpio`      | ![icons/previews/scorpio.xbm.png](icons/previews/scorpio.xbm.png)           |
| `shroom`       | ![icons/previews/shroom.xbm.png](icons/previews/shroom.xbm.png)             |
| `spkr_01`      | ![icons/previews/spkr_01.xbm.png](icons/previews/spkr_01.xbm.png)           |
| `spkr_02`      | ![icons/previews/spkr_02.xbm.png](icons/previews/spkr_02.xbm.png)           |
| `spkr_03`      | ![icons/previews/spkr_03.xbm.png](icons/previews/spkr_03.xbm.png)           |
| `stop`         | ![icons/previews/stop.xbm.png](icons/previews/stop.xbm.png)                 |
| `temp`         | ![icons/previews/temp.xbm.png](icons/previews/temp.xbm.png)                 |
| `test`         | ![icons/previews/test.xbm.png](icons/previews/test.xbm.png)                 |
| `usb_02`       | ![icons/previews/usb_02.xbm.png](icons/previews/usb_02.xbm.png)             |
| `usb`          | ![icons/previews/usb.xbm.png](icons/previews/usb.xbm.png)                   |
| `volume`       | ![icons/previews/volume.xbm.png](icons/previews/volume.xbm.png)             |
| `wifi_01`      | ![icons/previews/wifi_01.xbm.png](icons/previews/wifi_01.xbm.png)           |
| `wifi_02`      | ![icons/previews/wifi_02.xbm.png](icons/previews/wifi_02.xbm.png)           |


</p>
</details>


Run `dzen-dhall plug icons` to install.

<details><summary><strong>Show usage</strong></summary>
<p>

```dhall
let icons = (./plugins/icons.dhall).main

in	join
  [ plug icons.ac_01
  , plug icons.ac
  , plug icons.alert
  , plug icons.arch_10x10
  , plug icons.arch
  , plug icons.ball
  , plug icons.bat_empty_01
  , plug icons.bat_empty_02
  , plug icons.bat_full_01
  , plug icons.bat_full_02
  , plug icons.bat_low_01
  , plug icons.bat_low_02
  , plug icons.battery
  , plug icons.bluetooth
  , plug icons.bug_01
  , plug icons.bug_02
  , plug icons.cat
  , plug icons.clock
  , plug icons.cpu
  , plug icons.dish
  , plug icons.diskette
  , plug icons.empty
  , plug icons.envelope
  , plug icons.eye_l
  , plug icons.eye_r
  , plug icons.fox
  , plug icons.fs_01
  , plug icons.fs_02
  , plug icons.full
  , plug icons.fwd
  , plug icons.half
  , plug icons.info_01
  , plug icons.info_02
  , plug icons.info_03
  , plug icons.mail
  , plug icons.mem
  , plug icons.mouse_01
  , plug icons.music
  , plug icons.net_down_01
  , plug icons.net_down_02
  , plug icons.net_down_03
  , plug icons.net_up_01
  , plug icons.net_up_02
  , plug icons.net_up_03
  , plug icons.net_wired
  , plug icons.next
  , plug icons.note
  , plug icons.pacman
  , plug icons.pause
  , plug icons.phones
  , plug icons.play
  , plug icons.plug
  , plug icons.prev
  , plug icons.rwd
  , plug icons.scorpio
  , plug icons.shroom
  , plug icons.spkr_01
  , plug icons.spkr_02
  , plug icons.spkr_03
  , plug icons.stop
  , plug icons.temp
  , plug icons.test
  , plug icons.usb_02
  , plug icons.usb
  , plug icons.volume
  , plug icons.wifi_01
  , plug icons.wifi_02
  ]
```

</p>
</details>
