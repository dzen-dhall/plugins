let types = ../types/package.dhall

let utils = ../utils/package.dhall

let prelude = ../prelude/package.dhall

let AbsolutePosition = types.AbsolutePosition

let Address = types.Address

let Assertion = types.Assertion

let Bar = types.Bar

let BarSettings = types.BarSettings

let Button = types.Button

let Carrier = types.Carrier

let Check = types.Check

let Color = types.Color

let Configuration = types.Configuration

let Event = types.Event

let Hook = types.Hook

let Image = types.Image

let Plugin = types.Plugin

let Slot = types.Slot

let Source = types.Source

let State = types.State

let StateMap = types.StateMap

let StateTransitionTable = types.StateTransitionTable

let Transition = types.Transition

let Variable = types.Variable

let emit = utils.emit

let get = utils.get

let set = utils.set

let getState = utils.getState

let TOMATO_SLOT : Slot = "TOMATO_SLOT"

let INACTIVE : State = ""

let WAITING : State = "WAITING"

let ACTIVE : State = "ACTIVE"

let RINGING : State = "RINGING"

let AutomatonAddress = "AUTOMATO"

let TomatoClicked = Event.Custom "TomatoClicked"

let OkClicked = Event.Custom "OkClicked"

let ResetClicked = Event.Custom "ResetClicked"

let TimeIsUp = Event.Custom "TimeIsUp"

let Minutes : Variable = "Seconds"

let Seconds : Variable = "Minutes"

let bitmap : Image =
	  ''
	  #define tomato_width 15
	  #define tomato_height 15
	  static unsigned char tomato_bits[] = {
	   0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0xf8, 0x0e, 0xfc, 0x1f, 0xfc, 0x3f,
	   0xfe, 0x3f, 0xfe, 0x3f, 0xfe, 0x3f, 0xfc, 0x3f, 0xfc, 0x1f, 0xf8, 0x1f,
	   0xc0, 0x07, 0x00, 0x00, 0x00, 0x00 };
	  ''

let mkTransition
	: Event → State → State → Text → Transition
	=   λ(event : Event)
	  → λ(from : State)
	  → λ(to : State)
	  → λ(script : Text)
	  → { slots =
			[ TOMATO_SLOT ]
		, hooks =
			[ { command = [ "bash" ], input = script } ] : List Hook
		, events =
			[ event ]
		, from =
			[ from ]
		, to =
			to
		}

let stt
	: StateTransitionTable
	= [ mkTransition TomatoClicked INACTIVE WAITING ""
	  , mkTransition OkClicked WAITING ACTIVE ""
	  , mkTransition
		ResetClicked
		WAITING
		INACTIVE
		''
		$SET Minutes "0"
		$SET Seconds "0"
		''
	  , mkTransition TimeIsUp ACTIVE RINGING ""
	  , mkTransition TomatoClicked ACTIVE WAITING ""
	  , mkTransition TomatoClicked RINGING INACTIVE ""
	  ]

let mkIncreaseIntervalMinutes
	: ∀(Bar : Type) → Carrier Bar → Natural → Bar
	=   λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → λ(timeInterval : Natural)
	  → carrier.ca
		Button.Left
		''
		minutes=${get Minutes}
		${set Minutes "\$(( minutes + ${Natural/show timeInterval} ))"}
		''
		(carrier.text "+${Natural/show timeInterval}m ")

let mkIncreaseIntervalSeconds
	: ∀(Bar : Type) → Carrier Bar → Natural → Bar
	=   λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → λ(timeInterval : Natural)
	  → carrier.ca
		Button.Left
		''
		seconds=${get Seconds}
		seconds="$(( seconds + ${Natural/show timeInterval} ))"
		if [[ seconds -lt 60 ]]; then
		   ${set Seconds "\$seconds"}
		fi;
		''
		(carrier.text "+${Natural/show timeInterval}s ")

let tomatoSourceScript =
      ''
      minutes=${get Minutes}
      seconds=${get Seconds}
      state=${getState AutomatonAddress}
      if [[ "$state" == ${ACTIVE} ]]; then
        if [[ seconds -eq 0 ]]; then
          if [[ minutes -eq 0 ]]; then
            ${emit TOMATO_SLOT TimeIsUp};
          else
            seconds=59
            ${set Seconds "$seconds"}
            minutes="$(( minutes - 1 ))"
            ${set Minutes "$minutes"};
          fi;
        else
          seconds="$(( seconds - 1 ))"
          ${set Seconds "$seconds"}
        fi;
      fi;
      if [[ minutes -lt 10 ]]; then minutes="0$minutes"; fi
      if [[ seconds -lt 10 ]]; then seconds="0$seconds"; fi
      echo "$minutes:$seconds"
      ''

let mkTomatoClocks =
		λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → carrier.fg "white" (utils.mkBash Bar carrier 1000 tomatoSourceScript)

let mkWaitingTomato
	: ∀(Bar : Type) → Carrier Bar → Bar
	=   λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → cr.join
		[ mkTomatoClocks Bar cr
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
		, cr.ca
		  Button.Left
		  (emit TOMATO_SLOT OkClicked)
		  (cr.fg "green" (cr.text "OK"))
		, cr.text " "
		, cr.ca
		  Button.Left
		  (emit TOMATO_SLOT ResetClicked)
		  (cr.fg "red" (cr.text "RESET"))
		]

let mkRingingTomato =
		λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → carrier.fg
		"black"
		( carrier.bg
		  "red"
		  ( carrier.ca
			Button.Left
			(emit TOMATO_SLOT TomatoClicked)
			(carrier.text " TIME IS UP ")
		  )
		)

let mkTomato
	: Text → Bar
	=   λ(command : Text)
	  → λ(Bar : Type)
	  → λ(carrier : Carrier Bar)
	  → let stateMap
			: StateMap Bar
			= [ { state = INACTIVE, bar = carrier.text "" }
			  , { state = WAITING, bar = mkWaitingTomato Bar carrier }
			  , { state = ACTIVE, bar = mkTomatoClocks Bar carrier }
			  , { state = RINGING, bar = mkRingingTomato Bar carrier }
			  ]

		let finalizer =
			  carrier.automaton
			  "FINALIZER"
			  [ { slots =
					[ TOMATO_SLOT ]
				, hooks =
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

		in  carrier.join
			[ carrier.define Minutes "0"
			, carrier.define Seconds "0"
			, carrier.ca
			  Button.Left
			  (emit TOMATO_SLOT TomatoClicked)
			  (carrier.fg "red" (carrier.i bitmap))
			, carrier.text " "
			, carrier.automaton AutomatonAddress stt stateMap
			, finalizer
			]

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
				notify-desktop --urgency critical " *** Time is up! *** "
				'''
			  )
			''
		, apiVersion =
			1
		}
	, main =
		  λ(command : Text)
		→ utils.mkPlugin (mkTomato command)
	}
