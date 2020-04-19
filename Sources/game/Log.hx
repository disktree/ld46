package game;

import zui.*;
import zui.Themes;

class Log {

	static final THEME : TTheme = {
		NAME: "Log Theme",
		//LINK_STYLE: Line,
		ACCENT_COL: 0xff444444,
		ACCENT_HOVER_COL: 0xff494949,
		ACCENT_SELECT_COL: 0xff606060,
		ARROW_SIZE: 4,
		BUTTON_COL: 0xff464646,
		BUTTON_H: 14,
		BUTTON_HOVER_COL: 0xff494949,
		BUTTON_PRESSED_COL: 0xff1b1b1b,
		BUTTON_TEXT_COL: 0xffe8e7e5,
		CHECK_SELECT_SIZE: 8,
		CHECK_SIZE: 12,
		CONTEXT_COL: 0xff222222,
		ELEMENT_H: 11,
		ELEMENT_OFFSET: 1,
		ELEMENT_W: 100,
		FILL_ACCENT_BG: false,
		FILL_BUTTON_BG: true,
		FILL_WINDOW_BG: false,
		FONT_SIZE: 12,
		HIGHLIGHT_COL: 0xff205d9c,
		LABEL_COL: 0xffc8c8c8,
		PANEL_BG_COL: 0xff3b3b3b,
		SCROLL_W: 10,
		SEPARATOR_COL: 0xff272727,
		TAB_W: 8,
		//TEXT_COL: 0xffe8e7e5,
		TEXT_COL: 0xffffffff,
		TEXT_OFFSET: 2,
		//WINDOW_BG_COL: 0x99000000,
		WINDOW_BG_COL: 0x77000000,
		WINDOW_TINT_COL: 0xffffffff,
	};

	public var text = "";

	var ui : Zui;

	public function new() {
		UI.create( 'mono.ttf', THEME, ui -> this.ui = ui );
	}

	public inline function print( txt : String ) {
		trace( txt );
		text += txt+'\n';
	}
	
	public inline function clear() {
		text = '';
	}

	public function render( g : kha.graphics2.Graphics ) {
		g.end();
		if( ui != null ) {
			ui.begin( g );
			if( ui.window( Id.handle(), 600, 10, 300, 400, true ) ) {
				ui.text( text );
			}
			ui.end();
		}
		g.begin( false );
	}
}
