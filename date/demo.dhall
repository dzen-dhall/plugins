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

		let date = (./plugins/date.dhall).main

		in  plug (date "%d.%m.%Y %A - %H:%M:%S")

in  mkConfigs [ { bar = bar, settings = defaultBarSettings } ]
