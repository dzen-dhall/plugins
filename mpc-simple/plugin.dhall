let prelude = ../prelude/package.dhall
let types = ../types/package.dhall
let utils = ../utils/package.dhall

let Assertion = types.Assertion
let Bar = types.Bar
let Button = types.Button
let Carrier = types.Carrier
let Check = types.Check
let Color = types.Color
let Shell = types.Shell
let Source = types.Source
let Settings = types.Settings

let PluginSettings : Type = { useXClip : Bool }

let bar
	: PluginSettings → Bar
	=   λ ( settings
		  : PluginSettings
		  )
	  → λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → let text
			: Text → Bar
			= cr.text

		let join : List Bar → Bar = cr.join

		let fg : Color → Bar → Bar = cr.fg

		let ca : Button → Shell → Bar → Bar = cr.ca

		let source : Source → Bar = cr.source

		let check : Text → Assertion → Bar = cr.check

		let bashWithBinaries
			: List Text → Natural → Text → Bar
			= utils.mkBashWithBinaries Bar cr

		let mkMPCOutput
			: Text → Text → Bar
			=   λ ( format
				  : Text
				  )
			  → λ(color : Text)
			  → let mpcSource =
					  fg
					  color
					  ( bashWithBinaries
						[ "mpc" ]
						1000
						"mpc current -f %${format}%"
					  )

				in        if settings.useXClip

					then  join
						  [ check
							''
							--
							-- xclip not found, you should disable it using:
							--
							(mpc-simple.defaults // { useXClip = False })
							''
							(Assertion.BinaryInPath "xclip")
						  , ca
							Button.Left
							''
							mpc current -f %${format}% | xclip -selection clipboard
							''
							mpcSource
						  ]

					else  mpcSource

		in  join
			[ mkMPCOutput "artist" "#CFC"
			, text " - "
			, mkMPCOutput "title" "#FFC"
			, text " / "
			, mkMPCOutput "album" "#CCF"
			, text " "
			]

in  { meta =
		{ name =
			"mpc-simple"
		, author =
			"klntsky"
		, email =
			Some "klntsky@gmail.com"
		, homepage =
			Some "https://github.com/dzen-dhall/plugins#mpc-simple"
		, upstream =
			Some "mpc-simple@master"
		, description =
			''
			A minimal mpd status viewer that uses mpc. Prints artist, title and album.

			Clicking the output copies it to clipboard (using xclip).

			To disable clipboard feature, override the default settings:

			```dhall
			(mpc-simple.defaults // { useXClip = False })
			```
			''
		, usage =
			''
			let mpc-simple = ./plugins/mpc-simple.dhall

			in  plug (mpc-simple.main mpc-simple.defaults) : Bar
			''
		, apiVersion =
			1
		}
	, main =
		λ(settings : PluginSettings) → utils.mkPlugin (bar settings)
	, defaults =
		{ useXClip = True } : PluginSettings
	}
