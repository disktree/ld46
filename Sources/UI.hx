
import kha.Font;
import zui.Zui;
import zui.Themes;

class UI {

	public static final FONT_DEFAULT = "helvetica_neue_75.ttf";

	public static final THEME_DEFAULT : TTheme = {
		NAME: "Default Theme",
		WINDOW_BG_COL: 0xff333333,
		WINDOW_TINT_COL: 0xffffffff,
		ACCENT_COL: 0xff444444,
		ACCENT_HOVER_COL: 0xff494949,
		ACCENT_SELECT_COL: 0xff606060,
		BUTTON_COL: 0xff464646,
		BUTTON_TEXT_COL: 0xffe8e7e5,
		BUTTON_HOVER_COL: 0xff494949,
		BUTTON_PRESSED_COL: 0xff1b1b1b,
		TEXT_COL: 0xffe8e7e5,
		LABEL_COL: 0xffc8c8c8,
		SEPARATOR_COL: 0xff272727,
		HIGHLIGHT_COL: 0xff205d9c,
		CONTEXT_COL: 0xff222222,
		PANEL_BG_COL: 0xff3b3b3b,
		FONT_SIZE: 13,
		ELEMENT_W: 100,
		ELEMENT_H: 24,
		ELEMENT_OFFSET: 4,
		ARROW_SIZE: 5,
		BUTTON_H: 22,
		CHECK_SIZE: 15,
		CHECK_SELECT_SIZE: 8,
		SCROLL_W: 6,
		TEXT_OFFSET: 8,
		TAB_W: 6,
		FILL_WINDOW_BG: false,
		FILL_BUTTON_BG: true,
		FILL_ACCENT_BG: false,
		//LINK_STYLE: Line,
	};

	public static final THEME_BOOT : TTheme = {
		NAME: "Boot Theme Dark",
		WINDOW_BG_COL: 0xFF000000,
		WINDOW_TINT_COL: 0xffffffff,
		ACCENT_COL: 0xff444444,
		ACCENT_HOVER_COL: 0xff494949,
		ACCENT_SELECT_COL: 0xff606060,
		BUTTON_COL: 0xff464646,
		BUTTON_TEXT_COL: 0xffe8e7e5,
		BUTTON_HOVER_COL: 0xff494949,
		BUTTON_PRESSED_COL: 0xff1b1b1b,
		TEXT_COL: 0xffe8e7e5,
		LABEL_COL: 0xffc8c8c8,
		SEPARATOR_COL: 0xff272727,
		HIGHLIGHT_COL: 0xff205d9c,
		CONTEXT_COL: 0xff222222,
		PANEL_BG_COL: 0xff3b3b3b,
		FONT_SIZE: 32,
		ELEMENT_W: 100,
		ELEMENT_H: 48,
		ELEMENT_OFFSET: 4,
		ARROW_SIZE: 5,
		BUTTON_H: 22,
		CHECK_SIZE: 15,
		CHECK_SELECT_SIZE: 8,
		SCROLL_W: 6,
		TEXT_OFFSET: 8,
		TAB_W: 6,
		FILL_WINDOW_BG: false,
		FILL_BUTTON_BG: true,
		FILL_ACCENT_BG: false,
		//LINK_STYLE: Line,
	};

	static var fonts = new Map<String,Font>();

	public var visible : Bool;

	var ui : Zui;

	function new( visible = true ) {
		this.visible = visible;
	}

	public function render( g : kha.graphics2.Graphics ) {
		if( !visible || ui == null )
			return;
		g.end();
		ui.begin( g );
		renderGraphics( g );
		ui.end();
		g.begin( false );
	}

	function renderGraphics( g : kha.graphics2.Graphics ) {}

	public static function create( ?fontName : String, ?theme : TTheme, callback : Zui->Void ) {
		
		if( fontName == null ) fontName = FONT_DEFAULT;
		if( theme == null ) theme = THEME_DEFAULT;

		function createUI( f : Font ) {
			var ui = new Zui( {
				font: f,
				theme: theme // now working
			} );
			ui.ops.theme = theme;
			return ui;
		}

		if( fonts.exists( fontName )) {
			callback( createUI( fonts.get( fontName ) ) );
		} else {
			Data.getFont( fontName, f -> {
				callback( createUI( f ) );
			});
		}
	}

}
