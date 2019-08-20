let lib = ./lib/index.dhall
let types = ./src/types.dhall
let utils = ./src/utils.dhall

let Bar = types.Bar
let Carrier = types.Carrier

let mkConfigs = utils.mkConfigs

let defaultBar
	: Bar
	=   λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → let join : List Bar → Bar = carrier.join

		in  let icons = (./plugins/icons.dhall).main Bar carrier

			in  join
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

in  mkConfigs [ { bar = defaultBar, settings = utils.defaultBarSettings } ]
