let prelude = ./prelude/package.dhall
let types = ./types/package.dhall
let utils = ./utils/package.dhall

let Bar = types.Bar
let Settings = types.Settings
let Carrier = types.Carrier
let Configuration = types.Configuration
let Plugin = types.Plugin
let Shell = types.Shell
let Variable = types.Variable

let get : Variable → Shell = utils.get

let mkConfigs = utils.mkConfigs

let defaultSettings
	: Settings
	= utils.defaults.settings

let bar
	: Bar
	=   λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → let plug
			: Plugin → Bar
			= carrier.plug

		let mpc = ./plugins/mpc.dhall

		-- This demo shows how it is possible to override plugin appearance.
		-- When music is paused, only artist name will be shown.
		in    plug
				( mpc.main
					(   mpc.defaults
					  ⫽ { paused =
							  λ(Bar : Type)
							→ λ(cr : Carrier Bar)
							→ let bash
								  : Natural → Shell → Bar
								  = utils.mkBash Bar cr

							  in  bash
									1000
									''
									echo "[PAUSED] ${get mpc.defaults.variables.Artist}"
									''
						}
					)
				)
			: Bar

in  mkConfigs [ { bar = bar, settings = defaultSettings } ]
