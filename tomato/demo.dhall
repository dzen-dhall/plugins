let prelude = ./prelude/package.dhall

let types = ./types/package.dhall

let utils = ./utils/package.dhall

let Bar = types.Bar

let Settings = types.Settings

let Carrier = types.Carrier

let Configuration = types.Configuration

let Plugin = types.Plugin

let mkConfigs = utils.mkConfigs

let defaultSettings : Settings = utils.defaults.settings

let bar
	: Bar
	=   λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → let plug : Plugin → Bar = carrier.plug

		let tomato = (./plugins/tomato.dhall).main

		in  plug
			( tomato
			  ''
			  notify-send --urgency critical " *** Time is up! *** "
			  ''
			)

in  mkConfigs [ { bar = bar, settings = defaultSettings } ]
