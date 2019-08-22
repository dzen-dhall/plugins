# dzen-dhall plugins

[![Build Status](https://travis-ci.com/dzen-dhall/plugins.svg?branch=master)](https://travis-ci.com/dzen-dhall/plugins/)

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
| `ac_01`        | ![icons/previews/ac_01.png](icons/previews/ac_01.png)               |
| `ac`           | ![icons/previews/ac.png](icons/previews/ac.png)                     |
| `alert`        | ![icons/previews/alert.png](icons/previews/alert.png)               |
| `arch_10x10`   | ![icons/previews/arch_10x10.png](icons/previews/arch_10x10.png)     |
| `arch`         | ![icons/previews/arch.png](icons/previews/arch.png)                 |
| `ball`         | ![icons/previews/ball.png](icons/previews/ball.png)                 |
| `bat_empty_01` | ![icons/previews/bat_empty_01.png](icons/previews/bat_empty_01.png) |
| `bat_empty_02` | ![icons/previews/bat_empty_02.png](icons/previews/bat_empty_02.png) |
| `bat_full_01`  | ![icons/previews/bat_full_01.png](icons/previews/bat_full_01.png)   |
| `bat_full_02`  | ![icons/previews/bat_full_02.png](icons/previews/bat_full_02.png)   |
| `bat_low_01`   | ![icons/previews/bat_low_01.png](icons/previews/bat_low_01.png)     |
| `bat_low_02`   | ![icons/previews/bat_low_02.png](icons/previews/bat_low_02.png)     |
| `battery`      | ![icons/previews/battery.png](icons/previews/battery.png)           |
| `bluetooth`    | ![icons/previews/bluetooth.png](icons/previews/bluetooth.png)       |
| `bug_01`       | ![icons/previews/bug_01.png](icons/previews/bug_01.png)             |
| `bug_02`       | ![icons/previews/bug_02.png](icons/previews/bug_02.png)             |
| `cat`          | ![icons/previews/cat.png](icons/previews/cat.png)                   |
| `clock`        | ![icons/previews/clock.png](icons/previews/clock.png)               |
| `cpu`          | ![icons/previews/cpu.png](icons/previews/cpu.png)                   |
| `dish`         | ![icons/previews/dish.png](icons/previews/dish.png)                 |
| `diskette`     | ![icons/previews/diskette.png](icons/previews/diskette.png)         |
| `empty`        | ![icons/previews/empty.png](icons/previews/empty.png)               |
| `envelope`     | ![icons/previews/envelope.png](icons/previews/envelope.png)         |
| `eye_l`        | ![icons/previews/eye_l.png](icons/previews/eye_l.png)               |
| `eye_r`        | ![icons/previews/eye_r.png](icons/previews/eye_r.png)               |
| `fox`          | ![icons/previews/fox.png](icons/previews/fox.png)                   |
| `fs_01`        | ![icons/previews/fs_01.png](icons/previews/fs_01.png)               |
| `fs_02`        | ![icons/previews/fs_02.png](icons/previews/fs_02.png)               |
| `full`         | ![icons/previews/full.png](icons/previews/full.png)                 |
| `fwd`          | ![icons/previews/fwd.png](icons/previews/fwd.png)                   |
| `half`         | ![icons/previews/half.png](icons/previews/half.png)                 |
| `info_01`      | ![icons/previews/info_01.png](icons/previews/info_01.png)           |
| `info_02`      | ![icons/previews/info_02.png](icons/previews/info_02.png)           |
| `info_03`      | ![icons/previews/info_03.png](icons/previews/info_03.png)           |
| `mail`         | ![icons/previews/mail.png](icons/previews/mail.png)                 |
| `mem`          | ![icons/previews/mem.png](icons/previews/mem.png)                   |
| `mouse_01`     | ![icons/previews/mouse_01.png](icons/previews/mouse_01.png)         |
| `music`        | ![icons/previews/music.png](icons/previews/music.png)               |
| `net_down_01`  | ![icons/previews/net_down_01.png](icons/previews/net_down_01.png)   |
| `net_down_02`  | ![icons/previews/net_down_02.png](icons/previews/net_down_02.png)   |
| `net_down_03`  | ![icons/previews/net_down_03.png](icons/previews/net_down_03.png)   |
| `net_up_01`    | ![icons/previews/net_up_01.png](icons/previews/net_up_01.png)       |
| `net_up_02`    | ![icons/previews/net_up_02.png](icons/previews/net_up_02.png)       |
| `net_up_03`    | ![icons/previews/net_up_03.png](icons/previews/net_up_03.png)       |
| `net_wired`    | ![icons/previews/net_wired.png](icons/previews/net_wired.png)       |
| `next`         | ![icons/previews/next.png](icons/previews/next.png)                 |
| `note`         | ![icons/previews/note.png](icons/previews/note.png)                 |
| `pacman`       | ![icons/previews/pacman.png](icons/previews/pacman.png)             |
| `pause`        | ![icons/previews/pause.png](icons/previews/pause.png)               |
| `phones`       | ![icons/previews/phones.png](icons/previews/phones.png)             |
| `play`         | ![icons/previews/play.png](icons/previews/play.png)                 |
| `plug`         | ![icons/previews/plug.png](icons/previews/plug.png)                 |
| `prev`         | ![icons/previews/prev.png](icons/previews/prev.png)                 |
| `rwd`          | ![icons/previews/rwd.png](icons/previews/rwd.png)                   |
| `scorpio`      | ![icons/previews/scorpio.png](icons/previews/scorpio.png)           |
| `shroom`       | ![icons/previews/shroom.png](icons/previews/shroom.png)             |
| `spkr_01`      | ![icons/previews/spkr_01.png](icons/previews/spkr_01.png)           |
| `spkr_02`      | ![icons/previews/spkr_02.png](icons/previews/spkr_02.png)           |
| `spkr_03`      | ![icons/previews/spkr_03.png](icons/previews/spkr_03.png)           |
| `stop`         | ![icons/previews/stop.png](icons/previews/stop.png)                 |
| `temp`         | ![icons/previews/temp.png](icons/previews/temp.png)                 |
| `test`         | ![icons/previews/test.png](icons/previews/test.png)                 |
| `usb_02`       | ![icons/previews/usb_02.png](icons/previews/usb_02.png)             |
| `usb`          | ![icons/previews/usb.png](icons/previews/usb.png)                   |
| `volume`       | ![icons/previews/volume.png](icons/previews/volume.png)             |
| `wifi_01`      | ![icons/previews/wifi_01.png](icons/previews/wifi_01.png)           |
| `wifi_02`      | ![icons/previews/wifi_02.png](icons/previews/wifi_02.png)           |


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

## tomato

![tomato](tomato/img/tomato.png)

A digital tomato-timer to increase your productivity.

Allows to set a countdown for some period of time, and run arbitrary shell command when the time is up.

![waiting](tomato/img/waiting.png)

![active](tomato/img/active.png)

![ringing](tomato/img/ringing.png)


Run `dzen-dhall plug tomato` to install.
<details><summary><strong>Show usage</strong></summary>
<p>

```dhall
let tomato = (./plugins/tomato.dhall).main

in	plug
  ( tomato
	''
	notify-desktop --urgency critical " *** Time is up! *** "
	''
  )
```
</p>
</details>
