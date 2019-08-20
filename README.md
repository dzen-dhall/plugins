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

Run `dzen-dhall plug icons` to install.

<details><summary><strong>Show usage</strong></summary>
<p>

```dhall
let icons = (./plugins/icons.dhall).main Bar carrier

in	join
  [ icons.ac_01
  , icons.ac
  , icons.alert
  , icons.arch_10x10
  , icons.arch
  , icons.ball
  , icons.bat_empty_01
  , icons.bat_empty_02
  , icons.bat_full_01
  , icons.bat_full_02
  , icons.bat_low_01
  , icons.bat_low_02
  , icons.battery
  , icons.bluetooth
  , icons.bug_01
  , icons.bug_02
  , icons.cat
  , icons.clock
  , icons.cpu
  , icons.dish
  , icons.diskette
  , icons.empty
  , icons.envelope
  , icons.eye_l
  , icons.eye_r
  , icons.fox
  , icons.fs_01
  , icons.fs_02
  , icons.full
  , icons.fwd
  , icons.half
  , icons.info_01
  , icons.info_02
  , icons.info_03
  , icons.mail
  , icons.mem
  , icons.mouse_01
  , icons.music
  , icons.net_down_01
  , icons.net_down_02
  , icons.net_down_03
  , icons.net_up_01
  , icons.net_up_02
  , icons.net_up_03
  , icons.net_wired
  , icons.next
  , icons.note
  , icons.pacman
  , icons.pause
  , icons.phones
  , icons.play
  , icons.plug
  , icons.prev
  , icons.rwd
  , icons.scorpio
  , icons.shroom
  , icons.spkr_01
  , icons.spkr_02
  , icons.spkr_03
  , icons.stop
  , icons.temp
  , icons.test
  , icons.usb_02
  , icons.usb
  , icons.volume
  , icons.wifi_01
  , icons.wifi_02
  ]
```

</p>
</details>
