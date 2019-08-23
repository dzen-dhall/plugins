let types = ../types/package.dhall

let utils = ../utils/package.dhall

let Assertion = types.Assertion

let Bar = types.Bar

let Carrier = types.Carrier

let Plugin = types.Plugin

let main
	: Text → Plugin
	=   λ(format : Text)
	  → let bar
			: Bar
			=   λ(Bar : Type)
			  → λ(carrier : Carrier Bar)
			  → carrier.join
				[ carrier.check
				  "`date` binary is required by `date` plugin."
				  (Assertion.BinaryInPath "date")
				, carrier.source
				  { command =
					  [ "date", "+${format}" ]
				  , input =
					  ""
				  , updateInterval =
					  Some 1000
				  , escapeMode =
					  { joinLines = False, escapeMarkup = True }
				  }
				]

		in  utils.mkPlugin bar

in  { meta =
		{ name =
			"date"
		, author =
			"klntsky"
		, email =
			Some "klntsky@gmail.com"
		, homepage =
			Some "https://github.com/dzen-dhall/plugins/date/"
		, upstream =
			Some "date@master"
		, description =
			"A wrapper over `date` binary, prints current date formatted according to a given format string."
		, usage =
			''
			let date = (./plugins/date.dhall).main

			in plug (date "%d.%m.%Y %A - %H:%M:%S")
			''
		, apiVersion =
			1
		}
	, main =
		main
	}
