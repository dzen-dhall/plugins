let prelude = ../prelude/package.dhall
let types = ../types/package.dhall
let utils = ../utils/package.dhall

-- * Types

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
let query : Address → Shell = utils.query
let set : Variable → Shell → Shell = utils.set

let INACTIVE : State = mkState ""
let WAITING : State = mkState "WAITING"
let ACTIVE : State = mkState "ACTIVE"
let RINGING : State = mkState "RINGING"

let AutomatonAddress : Address = mkAddress "AUTOMATO"

let TomatoClicked = mkEvent "TomatoClicked"
let OkClicked = mkEvent "OkClicked"
let ResetClicked = mkEvent "ResetClicked"
let TimeIsUp = mkEvent "TimeIsUp"

let Seconds : Variable = mkVariable "Seconds"

let bitmap
	: Image
	= ''
	  #define tomato_width 15
	  #define tomato_height 15
	  static unsigned char tomato_bits[] = {
	   0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0xf8, 0x0e, 0xfc, 0x1f, 0xfc, 0x3f,
	   0xfe, 0x3f, 0xfe, 0x3f, 0xfe, 0x3f, 0xfc, 0x3f, 0xfc, 0x1f, 0xf8, 0x1f,
	   0xc0, 0x07, 0x00, 0x00, 0x00, 0x00 };
	  ''

let stateTransitionTable
	: List Transition
	= [ mkTransition TomatoClicked INACTIVE WAITING
	  , mkTransition OkClicked WAITING ACTIVE
	  , addHook
		( mkBashHook
		  ''
		  ${set Seconds "0"}
		  ''
		)
		(mkTransition ResetClicked WAITING INACTIVE)
	  , mkTransition TimeIsUp ACTIVE RINGING
	  , mkTransition TomatoClicked ACTIVE WAITING
	  , mkTransition TomatoClicked RINGING INACTIVE
	  ]

let mkIncreaseIntervalMinutes
	: ∀(Bar : Type) → Carrier Bar → Natural → Bar
	=   λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → λ(timeInterval : Natural)
	  → cr.ca
		Button.Left
		''
		seconds=${get Seconds}
		${set Seconds "$(( seconds + 60 * ${Natural/show timeInterval} ))"}
		''
		(cr.text "+${Natural/show timeInterval}m ")

let mkIncreaseIntervalSeconds
	: ∀(Bar : Type) → Carrier Bar → Natural → Bar
	=   λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → λ(timeInterval : Natural)
	  → cr.ca
		Button.Left
		''
		seconds=${get Seconds}
		seconds="$(( seconds + ${Natural/show timeInterval} ))"
		${set Seconds "$seconds"}
		''
		(cr.text "+${Natural/show timeInterval}s ")

let tomatoSourceScript =
	''
	seconds=${get Seconds}
	state=${query AutomatonAddress}
	if [ "$state" == ${showState ACTIVE} ]; then
		if [ "$seconds" -eq 0 ]; then
			${emit TimeIsUp};
		else
			seconds="$(( seconds - 1 ))"
			${set Seconds "$seconds"}
		fi;
	fi;
	if [ "$seconds" -lt 3600 ]; then
		printf "%02d:%02d" "$(( seconds / 60 ))" "$(( seconds % 60 ))"
	else
		printf "%02d:%02d:%02d" "$(( seconds / 60 / 60 ))" "$(( seconds / 60 % 60 ))" "$(( seconds % 60 ))"
	fi;
	''

let mkActiveTomato =
		λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → cr.fg "white" (utils.mkBash Bar cr 1000 tomatoSourceScript)

let mkWaitingTomato
	: ∀(Bar : Type) → Carrier Bar → Bar
	=   λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → cr.join
		[ mkActiveTomato Bar cr
		, cr.text " "
		, cr.fg
		  "#BDF"
		  ( cr.join
			( prelude.List.map
			  Natural
			  Bar
			  (mkIncreaseIntervalSeconds Bar cr)
			  [ 5, 15 ]
			)
		  )
		, cr.fg
		  "#FDB"
		  ( cr.join
			( prelude.List.map
			  Natural
			  Bar
			  (mkIncreaseIntervalMinutes Bar cr)
			  [ 1, 5, 15, 60 ]
			)
		  )
		, cr.text " "
		, cr.ca Button.Left (emit OkClicked) (cr.fg "green" (cr.text "OK"))
		, cr.text " "
		, cr.ca Button.Left (emit ResetClicked) (cr.fg "red" (cr.text "RESET"))
		]

let mkRingingTomato =
		λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → cr.fg
		"black"
		( cr.bg
		  "red"
		  ( cr.ca
			Button.Left
			(emit TomatoClicked)
			(cr.text " TIME IS UP ")
		  )
		)

let mkTomato
	: Text → Bar
	=   λ(command : Text)
	  → λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → let stateMap
			: StateMap Bar
			= [ { state = INACTIVE, bar = cr.text "" }
			  , { state = WAITING, bar = mkWaitingTomato Bar cr }
			  , { state = ACTIVE, bar = mkActiveTomato Bar cr }
			  , { state = RINGING, bar = mkRingingTomato Bar cr }
			  ]

		let bell =
			  cr.automaton
			  (mkAddress "BELL")
			  [ { hooks =
					[ { command = [ "bash" ], input = command } ]
				, events =
					[ TimeIsUp ]
				, from =
					[ INACTIVE ]
				, to =
					INACTIVE
				}
			  ]
			  ([] : StateMap Bar)

		in  cr.scope
			( cr.join
			  [ cr.define Seconds "0"
			  , cr.ca
				Button.Left
				(emit TomatoClicked)
				(cr.fg "red" (cr.i bitmap))
			  , cr.text " "
			  , cr.automaton AutomatonAddress stateTransitionTable stateMap
			  , bell
			  ]
			)

in  { meta =
		{ name =
			"tomato"
		, author =
			"klntsky"
		, email =
			Some "klntsky@gmail.com"
		, homepage =
			Some "https://github.com/dzen-dhall/plugins#tomato"
		, upstream =
			Some "tomato@master"
		, description =
			''
			A digital tomato-timer to increase your productivity.

			Allows to set a countdown for some period of time.
			''
		, usage =
			''
			let tomato = (./plugins/tomato.dhall).main

			in  plug
			  ( tomato
				'''
				notify-send --urgency critical " *** Time is up! *** "
				'''
			  )
			''
		, apiVersion =
			1
		}
	, main =
		λ(command : Text) → utils.mkPlugin (mkTomato command)
	}
