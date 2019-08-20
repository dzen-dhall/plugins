let lib = ../lib/index.dhall
let types = ../src/types.dhall
let utils = ../src/utils.dhall

let Bar = types.Bar
let Carrier = types.Carrier
let Plugin = types.Plugin

let images =
		λ ( i
		  : Text → Plugin
		  )
	  → { ac_01 =
			i
			''
			#define ac_01_width 8
			#define ac_01_height 8
			static unsigned char ac_01_bits[] = {
			 0x30, 0x28, 0xE4, 0x27, 0x27, 0xE4, 0x28, 0x30 };
			''
		, ac =
			i
			''
			#define ac_width 8
			#define ac_height 8
			static unsigned char ac_bits[] = {
			 0xFF, 0xF8, 0xF0, 0xF6, 0x6F, 0x0F, 0x1F, 0xFF };
			''
		, alert =
			i
			''
			#define alert_width 16
			#define alert_height 16
			static unsigned char alert_bits[] = {
			   0xff, 0xff, 0x01, 0xf8, 0xf1, 0xf9, 0xe1, 0xc1, 0xe1, 0xc1, 0xe1, 0xc1,
			   0xe1, 0xc1, 0xe1, 0xc1, 0xe1, 0xc1, 0xe1, 0xc1, 0x01, 0xc0, 0xe1, 0xc1,
			   0xe1, 0xc1, 0x01, 0xc0, 0xff, 0xff, 0xff, 0xff};
			''
		, arch_10x10 =
			i
			''
			#define arch_10x10_width 10
			#define arch_10x10_height 10
			static unsigned char arch_10x10_bits[] = {
			 0x10, 0x00, 0x10, 0x00, 0x38, 0x00, 0x38, 0x00, 0x7C, 0x00, 0x7C, 0x00,
			 0xEE, 0x00, 0xC6, 0x00, 0xC7, 0x01, 0x01, 0x01 };
			''
		, arch =
			i
			''
			#define arch_width 8
			#define arch_height 8
			static unsigned char arch_bits[] = {
			 0x08, 0x08, 0x1C, 0x1C, 0x36, 0x22, 0x77, 0x41 };
			''
		, ball =
			i
			''
			#define ball_width 19
			#define ball_height 19
			static unsigned char ball_bits[] = {
			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0f, 0x00, 0xe0, 0x3f, 0x00,
			  0xf0, 0x7f, 0x00, 0x78, 0xfc, 0x00, 0x38, 0xf8, 0x00, 0x7c, 0xfe, 0x01,
			  0xfc, 0xff, 0x01, 0xfc, 0xff, 0x01, 0xfc, 0xff, 0x01, 0xfc, 0xff, 0x01,
			  0xf8, 0xff, 0x00, 0xf8, 0xff, 0x00, 0xf0, 0x7f, 0x00, 0xe0, 0x3f, 0x00,
			  0x80, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, };
			''
		, bat_empty_01 =
			i
			''
			#define bat_empty_01_width 8
			#define bat_empty_01_height 8
			static unsigned char bat_empty_01_bits[] = {
			 0x18, 0x7E, 0x42, 0x42, 0x42, 0x42, 0x42, 0x7E };
			''
		, bat_empty_02 =
			i
			''
			#define bat_empty_02_width 8
			#define bat_empty_02_height 8
			static unsigned char bat_empty_02_bits[] = {
			 0x00, 0x7F, 0x41, 0xC1, 0xC1, 0x41, 0x7F, 0x00 };
			''
		, bat_full_01 =
			i
			''
			#define bat_full_width 8
			#define bat_full_height 8
			static unsigned char bat_full_bits[] = {
			 0x18, 0x7E, 0x42, 0x5A, 0x5A, 0x5A, 0x42, 0x7E };
			''
		, bat_full_02 =
			i
			''
			#define bat_full_02_width 8
			#define bat_full_02_height 8
			static unsigned char bat_full_02_bits[] = {
			 0x00, 0x7F, 0x41, 0xDD, 0xDD, 0x41, 0x7F, 0x00 };
			''
		, bat_low_01 =
			i
			''
			#define bat_low_01_width 8
			#define bat_low_01_height 8
			static unsigned char bat_low_01_bits[] = {
			 0x18, 0x7E, 0x42, 0x42, 0x42, 0x5A, 0x42, 0x7E };
			''
		, bat_low_02 =
			i
			''
			#define bat_low_02_width 8
			#define bat_low_02_height 8
			static unsigned char bat_low_02_bits[] = {
			 0x00, 0x7F, 0x41, 0xC5, 0xC5, 0x41, 0x7F, 0x00 };
			''
		, battery =
			i
			''
			#define battery_width 15
			#define battery_height 15
			static unsigned char battery_bits[] = {
			   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0x0f,
			   0xfc, 0x08, 0xfc, 0x38, 0xfc, 0x38, 0xfc, 0x08, 0xfc, 0x0f, 0x00, 0x00,
			   0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
			''
		, bluetooth =
			i
			''
			#define bluetooth_width 8
			#define bluetooth_height 8
			static unsigned char bluetooth_bits[] = {
			 0x18, 0x2A, 0x6C, 0x38, 0x38, 0x6C, 0x2A, 0x18 };
			''
		, bug_01 =
			i
			''
			#define bug_width 8
			#define bug_height 8
			static unsigned char bug_bits[] = {
			 0xC3, 0x24, 0x18, 0xDB, 0x3C, 0x7E, 0xBD, 0x99 };
			''
		, bug_02 =
			i
			''
			#define bug_02_width 8
			#define bug_02_height 8
			static unsigned char bug_02_bits[] = {
			 0xC3, 0x24, 0x24, 0xDB, 0x3C, 0x7E, 0x99, 0x42 };
			''
		, cat =
			i
			''
			#define cat_width 8
			#define cat_height 8
			static unsigned char cat_bits[] = {
			 0x81, 0xC3, 0xBD, 0xFF, 0x99, 0xFF, 0x7E, 0xBD };
			''
		, clock =
			i
			''
			#define clock_width 8
			#define clock_height 8
			static unsigned char clock_bits[] = {
			 0x3C, 0x5E, 0xEF, 0xF7, 0x87, 0xFF, 0x7E, 0x3C };
			''
		, cpu =
			i
			''
			#define cpu_width 8
			#define cpu_height 8
			static unsigned char cpu_bits[] = {
			 0xDB, 0x81, 0x3C, 0xBD, 0xBD, 0x3C, 0x81, 0xDB };
			''
		, dish =
			i
			''
			#define dish_width 8
			#define dish_height 8
			static unsigned char dish_bits[] = {
			 0x81, 0x7B, 0x46, 0x4E, 0x5C, 0x3E, 0x77, 0xC3 };
			''
		, diskette =
			i
			''
			#define diskette_width 8
			#define diskette_height 8
			static unsigned char diskette_bits[] = {
			 0xFF, 0x81, 0x81, 0x81, 0xBD, 0xB5, 0xB5, 0xFE };
			''
		, empty =
			i
			''
			#define empty_width 8
			#define empty_height 8
			static unsigned char empty_bits[] = {
			 0x3C, 0x42, 0x81, 0x81, 0x81, 0x81, 0x42, 0x3C };
			''
		, envelope =
			i
			''
			#define envelope_width 15
			#define envelope_height 15
			static unsigned char envelope_bits[] = {
			   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0x1f, 0x0c, 0x18, 0x1c, 0x1c,
			   0x34, 0x16, 0xc4, 0x11, 0x84, 0x10, 0x04, 0x10, 0xfc, 0x1f, 0x00, 0x00,
			   0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
			''
		, eye_l =
			i
			''
			#define eye_l_width 8
			#define eye_l_height 8
			static unsigned char eye_l_bits[] = {
			 0x00, 0x00, 0x1B, 0x02, 0x02, 0x84, 0xF9, 0x02 };
			''
		, eye_r =
			i
			''
			#define eye_r_width 8
			#define eye_r_height 8
			static unsigned char eye_r_bits[] = {
			 0x00, 0x00, 0xD8, 0x40, 0x40, 0x21, 0x9F, 0x40 };
			''
		, fox =
			i
			''
			#define fox_width 8
			#define fox_height 8
			static unsigned char fox_bits[] = {
			 0x81, 0xC3, 0xBD, 0xFF, 0x99, 0xDB, 0x7E, 0x18 };
			''
		, fs_01 =
			i
			''
			#define fs_01_width 8
			#define fs_01_height 8
			static unsigned char fs_01_bits[] = {
			 0x46, 0x99, 0xBC, 0x66, 0x66, 0x3D, 0x99, 0x62 };
			''
		, fs_02 =
			i
			''
			#define fs_02_width 8
			#define fs_02_height 8
			static unsigned char fs_02_bits[] = {
			 0xF1, 0x5B, 0x3D, 0x67, 0xE6, 0xBC, 0xDA, 0x8F };
			''
		, full =
			i
			''
			#define full_width 8
			#define full_height 8
			static unsigned char full_bits[] = {
			 0x3C, 0x7E, 0xFF, 0xFF, 0xFF, 0xFF, 0x7E, 0x3C };
			''
		, fwd =
			i
			''
			#define fwd_width 8
			#define fwd_height 8
			static unsigned char fwd_bits[] = {
			 0x00, 0x12, 0x36, 0x7E, 0x7E, 0x36, 0x12, 0x00 };
			''
		, half =
			i
			''
			#define half_width 8
			#define half_height 8
			static unsigned char half_bits[] = {
			 0x3C, 0x4E, 0x8F, 0x8F, 0x8F, 0x8F, 0x4E, 0x3C };
			''
		, info_01 =
			i
			''
			#define info_01_width 8
			#define info_01_height 8
			static unsigned char info_01_bits[] = {
			 0x3C, 0x66, 0xFF, 0xE7, 0xE7, 0xE7, 0x66, 0x3C };
			''
		, info_02 =
			i
			''
			#define info_02_width 8
			#define info_02_height 8
			static unsigned char info_02_bits[] = {
			 0xFF, 0xE7, 0xFF, 0xE7, 0xE7, 0xE7, 0xE7, 0xFF };
			''
		, info_03 =
			i
			''
			#define info_width 8
			#define info_height 8
			static unsigned char info_bits[] = {
			 0x38, 0x38, 0x00, 0x3C, 0x38, 0x38, 0x38, 0x7C };
			''
		, mail =
			i
			''
			#define mail_width 8
			#define mail_height 8
			static unsigned char mail_bits[] = {
			 0x00, 0xFF, 0x7E, 0xBD, 0xDB, 0xE7, 0xFF, 0x00 };
			''
		, mem =
			i
			''
			#define mem_width 8
			#define mem_height 8
			static unsigned char mem_bits[] = {
			 0xAA, 0x00, 0xFE, 0xFE, 0xFE, 0xFE, 0x00, 0xAA };
			''
		, mouse_01 =
			i
			''
			#define mouse_01_width 8
			#define mouse_01_height 8
			static unsigned char mouse_01_bits[] = {
			 0xEE, 0xEE, 0xEE, 0x82, 0xFE, 0xFE, 0xFE, 0x7C };
			''
		, music =
			i
			''
			#define music_width 16
			#define music_height 16
			static unsigned char music_bits[] = {
			   0x00, 0x00, 0xe0, 0x00, 0xe0, 0x03, 0x20, 0x1f, 0x20, 0x1c, 0x20, 0x10,
			   0x20, 0x10, 0x20, 0x10, 0x20, 0x10, 0x2c, 0x10, 0x3e, 0x10, 0x1e, 0x16,
			   0x0c, 0x1f, 0x00, 0x0f, 0x00, 0x06, 0x00, 0x00 };
			''
		, net_down_01 =
			i
			''
			#define net_down_01_width 8
			#define net_down_01_height 8
			static unsigned char net_down_01_bits[] = {
			 0x1E, 0x3C, 0x3C, 0x3C, 0xFF, 0x7E, 0x3C, 0x18 };
			''
		, net_down_02 =
			i
			''
			#define net_down_02_width 8
			#define net_down_02_height 8
			static unsigned char net_down_02_bits[] = {
			 0x78, 0x3C, 0x3C, 0x3C, 0xFF, 0x7E, 0x3C, 0x18 };
			''
		, net_down_03 =
			i
			''
			#define net_down_03_width 8
			#define net_down_03_height 8
			static unsigned char net_down_03_bits[] = {
			 0x38, 0x38, 0x38, 0x38, 0xFE, 0x7C, 0x38, 0x10 };
			''
		, net_up_01 =
			i
			''
			#define net_up_01_width 8
			#define net_up_01_height 8
			static unsigned char net_up_01_bits[] = {
			 0x18, 0x3C, 0x7E, 0xFF, 0x3C, 0x3C, 0x3C, 0x78 };
			''
		, net_up_02 =
			i
			''
			#define net_up_02_width 8
			#define net_up_02_height 8
			static unsigned char net_up_02_bits[] = {
			 0x18, 0x3C, 0x7E, 0xFF, 0x3C, 0x3C, 0x3C, 0x1E };
			''
		, net_up_03 =
			i
			''
			#define net_up_03_width 8
			#define net_up_03_height 8
			static unsigned char net_up_03_bits[] = {
			 0x10, 0x38, 0x7C, 0xFE, 0x38, 0x38, 0x38, 0x38 };
			''
		, net_wired =
			i
			''
			#define net_wired_width 8
			#define net_wired_height 8
			static unsigned char net_wired_bits[] = {
			 0x00, 0x1C, 0x1C, 0x7F, 0x7F, 0x7F, 0x55, 0x7F };
			''
		, next =
			i
			''
			#define next_width 8
			#define next_height 8
			static unsigned char next_bits[] = {
			 0x00, 0x42, 0x4E, 0x7E, 0x7E, 0x4E, 0x42, 0x00 };
			''
		, note =
			i
			''
			#define note_width 8
			#define note_height 8
			static unsigned char note_bits[] = {
			 0xFC, 0xFC, 0x84, 0x84, 0x84, 0x84, 0xE7, 0xE7 };
			''
		, pacman =
			i
			''
			#define pacman_width 8
			#define pacman_height 8
			static unsigned char pacman_bits[] = {
			 0x3C, 0x6E, 0xE7, 0xFF, 0x07, 0x1F, 0x7E, 0x3C };
			''
		, pause =
			i
			''
			#define pause_width 8
			#define pause_height 8
			static unsigned char pause_bits[] = {
			 0x00, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x00 };
			''
		, phones =
			i
			''
			#define phones_width 8
			#define phones_height 8
			static unsigned char phones_bits[] = {
			 0x3C, 0x42, 0x81, 0x81, 0xA5, 0xE7, 0xE7, 0x66 };
			''
		, play =
			i
			''
			#define play_width 8
			#define play_height 8
			static unsigned char play_bits[] = {
			 0x00, 0x06, 0x1E, 0x7E, 0x7E, 0x1E, 0x06, 0x00 };
			''
		, plug =
			i
			''
			#define plug_width 8
			#define plug_height 8
			static unsigned char plug_bits[] = {
			 0x03, 0x0F, 0x1E, 0x3E, 0x3C, 0x58, 0xA0, 0xC0 };
			''
		, prev =
			i
			''
			#define prev_width 8
			#define prev_height 8
			static unsigned char prev_bits[] = {
			 0x00, 0x42, 0x72, 0x7E, 0x7E, 0x72, 0x42, 0x00 };
			''
		, rwd =
			i
			''
			#define rwd_width 8
			#define rwd_height 8
			static unsigned char rwd_bits[] = {
			 0x00, 0x48, 0x6C, 0x7E, 0x7E, 0x6C, 0x48, 0x00 };
			''
		, scorpio =
			i
			''
			#define scorpio_width 8
			#define scorpio_height 8
			static unsigned char scorpio_bits[] = {
			 0x42, 0x81, 0xDB, 0x3C, 0xDB, 0x5A, 0x99, 0x30 };
			''
		, shroom =
			i
			''
			#define shroom_width 8
			#define shroom_height 8
			static unsigned char shroom_bits[] = {
			 0x3C, 0x42, 0x81, 0x81, 0xFF, 0x3C, 0x3C, 0x3C };
			''
		, spkr_01 =
			i
			''
			#define spkr_01_width 8
			#define spkr_01_height 8
			static unsigned char spkr_01_bits[] = {
			 0x08, 0x4C, 0x8F, 0xAF, 0xAF, 0x8F, 0x4C, 0x08 };
			''
		, spkr_02 =
			i
			''
			#define spkr_02_width 8
			#define spkr_02_height 8
			static unsigned char spkr_02_bits[] = {
			 0x08, 0x0C, 0x0F, 0x1F, 0x1F, 0x0F, 0x0C, 0x08 };
			''
		, spkr_03 =
			i
			''
			#define ysick_width 8
			#define ysick_height 8
			static unsigned char ysick_bits[] = {
			 0x4C, 0x93, 0x93, 0x97, 0x97, 0x93, 0x93, 0x4C };
			''
		, stop =
			i
			''
			#define stop_width 8
			#define stop_height 8
			static unsigned char stop_bits[] = {
			 0x00, 0x7E, 0x7E, 0x7E, 0x7E, 0x7E, 0x7E, 0x00 };
			''
		, temp =
			i
			''
			#define temp_width 8
			#define temp_height 8
			static unsigned char temp_bits[] = {
			 0xC8, 0xE0, 0x72, 0x28, 0x16, 0x09, 0x09, 0x06 };
			''
		, test =
			i
			''
			#define test_width 8
			#define test_height 8
			static unsigned char test_bits[] = {
			 0x0E, 0x13, 0x21, 0x41, 0x82, 0x84, 0xC8, 0x70 };
			''
		, usb_02 =
			i
			''
			#define usb_02_width 8
			#define usb_02_height 8
			static unsigned char usb_02_bits[] = {
			 0x10, 0x50, 0x54, 0x54, 0x34, 0x18, 0x10, 0x10 };
			''
		, usb =
			i
			''
			#define usb_width 8
			#define usb_height 8
			static unsigned char usb_bits[] = {
			 0x70, 0x88, 0xC4, 0xE2, 0x7E, 0x32, 0x09, 0x07 };
			''
		, volume =
			i
			''
			#define volume_width 16
			#define volume_height 16
			static unsigned char volume_bits[] = {
			   0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x1b, 0x60, 0x1b, 0x60, 0x1b,
			   0x6c, 0x1b, 0x6c, 0x1b, 0x6c, 0x1b, 0x60, 0x1b, 0x60, 0x1b, 0x00, 0x1b,
			   0x00, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
			''
		, wifi_01 =
			i
			''
			#define wifi_01_width 8
			#define wifi_01_height 8
			static unsigned char wifi_01_bits[] = {
			 0x80, 0xA0, 0xA8, 0xAB, 0xAB, 0xA8, 0xA0, 0x80 };
			''
		, wifi_02 =
			i
			''
			#define wifi_02_width 8
			#define wifi_02_height 8
			static unsigned char wifi_02_bits[] = {
			 0x40, 0x90, 0xA4, 0xA9, 0xA9, 0xA4, 0x90, 0x40 };
			''
		}

let main =
	  images
	  (   λ(image : Text)
		→ let bar
			  : Bar
			  = λ(Bar : Type) → λ(carrier : Carrier Bar) → carrier.i image

		  in  utils.mkPlugin bar
	  )

in  { meta =
		{ name =
			"icons"
		, author =
			"Author(s) of these images is (are) not known."
		, email =
			None Text
		, homepage =
			Some "https://github.com/dzen-dhall/plugins/icons/"
		, upstream =
			Some "icons@master"
		, description =
			"A pack of XBM icons."
		, usage =
			''
			let icons = (./plugins/icons.dhall).main

			in	join
			  [ plug icons.ac_01
			  , plug icons.ac
			  , plug icons.alert
			  , plug icons.arch_10x10
			  , plug icons.arch
			  , plug icons.ball
			  , plug icons.bat_empty_01
			  , plug icons.bat_empty_02
			  , plug icons.bat_full_01
			  , plug icons.bat_full_02
			  , plug icons.bat_low_01
			  , plug icons.bat_low_02
			  , plug icons.battery
			  , plug icons.bluetooth
			  , plug icons.bug_01
			  , plug icons.bug_02
			  , plug icons.cat
			  , plug icons.clock
			  , plug icons.cpu
			  , plug icons.dish
			  , plug icons.diskette
			  , plug icons.empty
			  , plug icons.envelope
			  , plug icons.eye_l
			  , plug icons.eye_r
			  , plug icons.fox
			  , plug icons.fs_01
			  , plug icons.fs_02
			  , plug icons.full
			  , plug icons.fwd
			  , plug icons.half
			  , plug icons.info_01
			  , plug icons.info_02
			  , plug icons.info_03
			  , plug icons.mail
			  , plug icons.mem
			  , plug icons.mouse_01
			  , plug icons.music
			  , plug icons.net_down_01
			  , plug icons.net_down_02
			  , plug icons.net_down_03
			  , plug icons.net_up_01
			  , plug icons.net_up_02
			  , plug icons.net_up_03
			  , plug icons.net_wired
			  , plug icons.next
			  , plug icons.note
			  , plug icons.pacman
			  , plug icons.pause
			  , plug icons.phones
			  , plug icons.play
			  , plug icons.plug
			  , plug icons.prev
			  , plug icons.rwd
			  , plug icons.scorpio
			  , plug icons.shroom
			  , plug icons.spkr_01
			  , plug icons.spkr_02
			  , plug icons.spkr_03
			  , plug icons.stop
			  , plug icons.temp
			  , plug icons.test
			  , plug icons.usb_02
			  , plug icons.usb
			  , plug icons.volume
			  , plug icons.wifi_01
			  , plug icons.wifi_02
			  ]
			''
		, apiVersion =
			1
		}
	, main =
		main
	}
