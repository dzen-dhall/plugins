let prelude = ./prelude/package.dhall

let types = ./types/package.dhall

let utils = ./utils/package.dhall

let Bar = types.Bar

let BarSettings = types.BarSettings

let Carrier = types.Carrier

let Configuration = types.Configuration

let Plugin = types.Plugin

let mkConfigs = utils.mkConfigs

let defaultBarSettings : BarSettings = utils.defaultBarSettings

let bar
	: Bar
	=   λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → let plug : Plugin → Bar = carrier.plug

		let tomato = (./plugins/tomato.dhall).main

		in  plug
			( tomato
			  [ 1, 5, 15, 30, 60 ]
			  ''
			  notify-desktop --urgency critical " *** Time is up! *** "
			  ''
			)

in  mkConfigs [ { bar = bar, settings = defaultBarSettings } ]
