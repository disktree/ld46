package game;

import zui.*;
import zui.Themes;

class HUD extends UI {

	static final THEME : TTheme = {
		NAME: "HUD Theme",
		//LINK_STYLE: Line,
		ACCENT_COL: 0xff444444,
		ACCENT_HOVER_COL: 0xff494949,
		ACCENT_SELECT_COL: 0xff606060,
		ARROW_SIZE: 4,
		BUTTON_COL: 0xff464646,
		BUTTON_H: 24,
		BUTTON_HOVER_COL: 0xff494949,
		BUTTON_PRESSED_COL: 0xff1b1b1b,
		BUTTON_TEXT_COL: 0xffe8e7e5,
		CHECK_SELECT_SIZE: 8,
		CHECK_SIZE: 16,
		CONTEXT_COL: 0xff222222,
		ELEMENT_H: 24,
		ELEMENT_OFFSET: 4,
		ELEMENT_W: 100,
		FILL_ACCENT_BG: false,
		FILL_BUTTON_BG: true,
		FILL_WINDOW_BG: false,
		FONT_SIZE: 24,
		HIGHLIGHT_COL: 0xff205d9c,
		LABEL_COL: 0xffc8c8c8,
		PANEL_BG_COL: 0xff3b3b3b,
		SCROLL_W: 8,
		SEPARATOR_COL: 0xff272727,
		TAB_W: 8,
		//TEXT_COL: 0xffe8e7e5,
		TEXT_COL: 0xffffffff,
		TEXT_OFFSET: 8,
		//WINDOW_BG_COL: 0x99000000,
		WINDOW_BG_COL: 0x00000000,
		WINDOW_TINT_COL: 0xffffffff,
	};

	public var text = "ANTRUM";

	public function new( ?visible : Bool, text = "" ) {
		super( visible );
		this.text = text;
		UI.create( THEME, ui -> this.ui = ui );
	}

	override function renderGraphics( g : kha.graphics2.Graphics ) {
		if( ui.window( Id.handle(), 10, 10, 600, 200, false ) ) {
			ui.text( text );
		}
	}

}
