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

let bar
	: Bar
	=   λ(Bar : Type)
	  → λ(cr : Carrier Bar)
	  → -- Text primitives:
		let text : Text → Bar = cr.text
		let markup : Text → Bar = cr.markup

		-- Combining multiple `Bar`s into one:
		let join : List Bar → Bar = cr.join

		-- Primitives of Dzen markup language:
		let fg : Color → Bar → Bar = cr.fg
		let bg : Color → Bar → Bar = cr.bg
		let i : Image → Bar = cr.i
		let r : Natural → Natural → Bar = cr.r
		let ro : Natural → Natural → Bar = cr.ro
		let c : Natural → Bar = cr.c
		let co : Natural → Bar = cr.co
		let p : Position → Bar → Bar = cr.p
		let pa : AbsolutePosition → Bar → Bar = cr.pa
		let ca : Button → Shell → Bar → Bar = cr.ca
		let ib : Bar → Bar = cr.ib

		-- Animations:
		let slider : Slider → List Bar → Bar = cr.slider
		let marquee : Marquee → Bar → Bar = cr.marquee

		-- Other:
		let pad : Natural → Padding → Bar → Bar = cr.pad
		let trim : Natural → Direction → Bar → Bar = cr.trim
		let source : Source → Bar = cr.source
		let plug : Plugin → Bar = cr.plug
		let automaton
			: Address → List Transition → StateMap Bar → Bar
			= cr.automaton
		let check : Text -> Assertion → Bar = cr.check
		let scope : Bar → Bar = cr.scope
		let define : Variable → Text → Bar = cr.define

		-- Utilities:
		let separateBy : Bar → List Bar → Bar = utils.mkSeparateBy Bar cr
		let separate : List Bar → Bar = separateBy (text " | ")
		let bash : Natural → Text → Bar = utils.mkBash Bar cr
		let bashWithBinaries
			: List Text → Natural → Text → Bar
			= utils.mkBashWithBinaries Bar cr

		-- *** Place your implementation below: ***

		in text "This is a plugin template"


in  { meta =
		{ name =
			"plugin-template"
		, author =
			""
		, email =
			None Text
		, homepage =
			None Text
		, upstream =
			Some "plugin-template@master"
		, description =
			''
			A template for new plugins.
			''
		, usage =
			''
			let plugin-template = (./plugins/plugin-template.dhall).main

			in  plug plugin-template : Bar
			''
		, apiVersion =
			1
		}
	, main =
		utils.mkPlugin bar
	}
