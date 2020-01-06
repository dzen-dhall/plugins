let prelude = ../prelude/package.dhall
let types = ../types/package.dhall
let utils = ../utils/package.dhall

let AbsolutePosition = types.AbsolutePosition
let Address = types.Address
let Assertion = types.Assertion
let Bar = types.Bar
let Button = types.Button
let Carrier = types.Carrier
let Check = types.Check
let Color = types.Color
let Configuration = types.Configuration
let Direction = types.Direction
let Event = types.Event
let Fade = types.Fade
let Hook = types.Hook
let Image = types.Image
let Marquee = types.Marquee
let Padding = types.Padding
let Plugin = types.Plugin
let Position = types.Position
let Settings = types.Settings
let Shell = types.Shell
let Slider = types.Slider
let Source = types.Source
let State = types.State
let StateMap = types.StateMap
let Transition = types.Transition
let Variable = types.Variable
let VerticalDirection = types.VerticalDirection

-- * Utility functions

let mkAddress : Text → Address = utils.mkAddress
let mkEvent : Text → Event = utils.mkEvent
let mkState : Text → State = utils.mkState
let mkVariable : Text → Variable = utils.mkVariable

let showAddress : Address → Text = utils.showAddress
let showEvent : Event → Text = utils.showEvent
let showState : State → Text = utils.showState
let showVariable : Variable → Text = utils.showVariable

let mkBashHook : Shell → Hook = utils.mkBashHook
let addHook : Hook → Transition → Transition = utils.addHook

let mkFade : VerticalDirection → Natural → Natural → Fade = utils.mkFade
let mkSlider : Fade → Fade → Natural → Slider = utils.mkSlider
let mkMarquee : Natural → Natural → Bool → Marquee = utils.mkMarquee

let mkTransition : Event → State → State → Transition = utils.mkTransition
let mkTransitions : Event → List State → State → Transition = utils.mkTransitions

let emit : Event → Shell = utils.emit
let get : Variable → Shell = utils.get
let getEvent : Shell = utils.getEvent
let getCurrentState : Shell = utils.getCurrentState
let getNextState : Shell = utils.getNextState
let query : Address → Shell = utils.query
let set : Variable → Shell → Shell = utils.set

let OFF
	: State
	= mkState "OFF"

let PAUSED
	: State
	= mkState ""

let PLAYING
	: State
	= mkState "PLAYING"

let Album
	: Variable
	= mkVariable "Album"

let Title
	: Variable
	= mkVariable "Title"

let Artist
	: Variable
	= mkVariable "Artist"

let Resume
	: Event
	= mkEvent "Resume"

let TurnOff
	: Event
	= mkEvent "TurnOff"

let Pause
	: Event
	= mkEvent "Pause"

let Settings
	: Type
	= { playing : Bar
	  , off : Bar
	  , paused : Bar
	  , events : { Resume : Event, Pause : Event, TurnOff : Event }
	  , variables : { Album : Variable, Artist : Variable, Title : Variable }
	  , updateInterval : Natural
	  , scoped : Bool
	  }

let defaults
	: Settings
	= let mkUI =
			  λ(artistColor : Text)
			→ λ(trackColor : Text)
			→ λ(albumColor : Text)
			→ λ(Bar : Type)
			→ λ(cr : Carrier Bar)
			→ let prevButton =
					cr.ca
					  Button.Left
					  ''
					  mpc prev
					  ''
					  ( cr.i
						  ''
						  #define prev_width 8
						  #define prev_height 8
						  static unsigned char prev_bits[] = {
						   0x00, 0x42, 0x72, 0x7E, 0x7E, 0x72, 0x42, 0x00 };
						  ''
					  )

			  let nextButton =
					cr.ca
					  Button.Left
					  ''
					  mpc next
					  ''
					  ( cr.i
						  ''
						  #define next_width 8
						  #define next_height 8
						  static unsigned char next_bits[] = {
						   0x00, 0x42, 0x4E, 0x7E, 0x7E, 0x4E, 0x42, 0x00 };
						  ''
					  )

			  let pauseButton =
					let stateTransitionTable
						: List Transition
						= [ mkTransition Resume PAUSED PLAYING
						  , mkTransition Pause PLAYING PAUSED
						  , mkTransition TurnOff PLAYING PAUSED
						  ]

					let stateMap
						: StateMap Bar
						= [ { state = PAUSED
							, bar =
								cr.i
								  ''
								  #define play_width 8
								  #define play_height 8
								  static unsigned char play_bits[] = {
								   0x00, 0x06, 0x1E, 0x7E, 0x7E, 0x1E, 0x06, 0x00 };
								  ''
							}
						  , { state = PLAYING
							, bar =
								cr.i
								  ''
								  #define pause_width 8
								  #define pause_height 8
								  static unsigned char pause_bits[] = {
								   0x00, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x00 };
								  ''
							}
						  ]

					in  cr.ca
						  Button.Left
						  "mpc toggle"
						  ( cr.automaton
							  (mkAddress "MPC_PAUSE_BUTTON")
							  stateTransitionTable
							  stateMap
						  )

			  let bashWithBinaries
				  : List Text → Natural → Text → Bar
				  = utils.mkBashWithBinaries Bar cr

			  let mkMPCOutput
				  : Text → Variable → Text → Bar
				  =   λ(format : Text)
					→ λ(variable : Variable)
					→ λ(color : Text)
					→ let mpcSource =
							cr.fg
							  color
							  ( bashWithBinaries
								  [ "mpc" ]
								  1000
								  ''
								  echo "${get variable}"
								  ''
							  )

					  in  cr.ca
							Button.Left
							''
							mpc current -f %${format}% | xclip -selection clipboard
							''
							mpcSource

			  in  cr.join
					[ prevButton
					, cr.text " "
					, pauseButton
					, cr.text " "
					, nextButton
					, cr.text "  "
					, mkMPCOutput "artist" Artist artistColor
					, cr.text "  "
					, mkMPCOutput "title" Title trackColor
					, cr.text "  "
					, mkMPCOutput "album" Album albumColor
					]

	  in  { playing = mkUI "#FCC" "#FFF" "#CCF"
		  , paused = mkUI "#C88" "#AAA" "#88C"
		  , off = λ(Bar : Type) → λ(cr : Carrier Bar) → cr.text "no track"
		  , updateInterval = 1000
		  , scoped = True
		  , events = { Resume = Resume, TurnOff = TurnOff, Pause = Pause }
		  , variables = { Title = Title, Artist = Artist, Album = Album }
		  }

let bar
	: Settings → Bar
	=   λ(settings : Settings)
	  → λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → let bashWithBinaries
			: List Text → Natural → Text → Bar
			= utils.mkBashWithBinaries Bar cr

		let stateTransitionTable
			: List Transition
			= [ mkTransition Resume PAUSED PLAYING
			  , mkTransition Resume OFF PLAYING
			  , mkTransition Pause PLAYING PAUSED
			  , mkTransition Pause OFF PAUSED
			  , mkTransition TurnOff PLAYING OFF
			  , mkTransition TurnOff PAUSED OFF
			  ]

		let stateMap
			: StateMap Bar
			= [ { state = PAUSED, bar = settings.paused Bar cr }
			  , { state = OFF, bar = settings.off Bar cr }
			  , { state = PLAYING, bar = settings.playing Bar cr }
			  ]

		let emitter =
			  bashWithBinaries
				[ "mpc" ]
				settings.updateInterval
				''
				{
					status="$(mpc status)"
					artist="$(mpc current -f %artist%)"
					title="$(mpc current -f %title%)"
					album="$(mpc current -f %album%)"

					if [[ -z "$album" ]]; then album="Unknown"; fi;
					if [[ -z "$title" ]]; then title="Unknown"; fi;
					if [[ -z "$artist" ]]; then artist="Unknown"; fi;

					${set Artist "\$artist"}
					${set Album "\$album"}
					${set Title "\$title"}

					if [[ "$(echo "$status" | wc -l)" == 1 ]]; then
					   ${emit TurnOff}
					elif [[ -z "$(echo "$status" | tail -n +2 | head -n 1 | grep playing)" ]]; then
					   ${emit Pause}
					else
					   ${emit Resume}
					fi;
				} &>/dev/null
				''

		let mpc =
			  cr.join
				[ cr.automaton (mkAddress "MPC") stateTransitionTable stateMap
				, emitter
				]

		in  if settings.scoped then cr.scope mpc else mpc

in  { meta =
		{ name = "mpc"
		, author = "klntsky"
		, email = None Text
		, homepage = Some "https://github.com/dzen-dhall/plugins#mpc"
		, upstream = Some "mpc@master"
		, description =
			''
			MPD integration using MPC.
			''
		, usage =
			''
			let mpc = (./plugins/mpc.dhall)

			in  plug (mpc.main mpc.defaults) : Bar
			''
		, apiVersion = 1
		}
	, defaults = defaults
	, main = λ(settings : Settings) → utils.mkPlugin (bar settings)
	}
