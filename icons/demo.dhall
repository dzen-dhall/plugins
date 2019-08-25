let types = ./types/package.dhall
let utils = ./utils/package.dhall

let Bar = types.Bar
let Carrier = types.Carrier
let Plugin = types.Plugin

let mkConfigs = utils.mkConfigs

let bar
	: Bar
	=   λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → let join : List Bar → Bar = carrier.join
		let plug : Plugin → Bar = carrier.plug

		let icons = (./plugins/icons.dhall).main

		in  join
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

in  mkConfigs [ { bar = bar, settings = utils.defaults.settings } ]
