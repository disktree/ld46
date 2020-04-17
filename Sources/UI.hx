
import zui.Zui;
import zui.Themes;

class UI {

	public static final FONT = "helvetica_neue_75.ttf";

	public static final THEME = {
		NAME: "Custom Dark",
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

	public static function create( callback : Zui->Void ) {
		Data.getFont( FONT, function(f:kha.Font) {
			var ui = new Zui( {
				font: f,
				//theme: App.UI_THEME // now working
			} );
			ui.ops.theme = THEME;
			callback( ui );
		});
	}
}