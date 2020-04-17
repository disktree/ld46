package ld46.scene;

import armory.trait.internal.CanvasScript;
import zui.*;

class Mainmenu extends Trait {

	//var canvas : CanvasScript;
	var ui : Zui;

	public function new() {
		super();
		notifyOnInit( init );
	}
	
	function init() {
		
		trace( "Mainmenu.init" );
		
		/*
		canvas = Scene.active.getTrait( CanvasScript );
		canvas.notifyOnReady( function() {
			canvas.getElement("Version").text = App.VERSION;
		});
		*/
		
		//Data.getFont("font_default.ttf", function(f:kha.Font) {
		///Data.getFont("BDGem.ttf", function(f:kha.Font) {
		Data.getFont("helvetica_neue_75.ttf", function(f:kha.Font) {
			ui = new Zui( {
				font: f,
				//theme: App.UI_THEME
			} );
			//ui.ops.theme = App.UI_THEME;
			//trace(ui.ops.theme);
		});
		
		Event.add( "play", () -> loadScene( 'Game' ) );
		Event.add( "quit", App.quit );
		
		notifyOnUpdate( update );
		notifyOnRender2D( render2D );
	}

	function update() {

		//if( !canvas.ready ) return;

		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();

		if( keyboard.started( "escape" ) ) {
			App.quit();
		}
	}

	function render2D( g : kha.graphics2.Graphics ) {
		g.end();
		if( ui != null ) {
			ui.begin( g );
			if( ui.window( Id.handle(), 20, 20, 240, 600, false ) ) {
				if( ui.panel( Id.handle( { selected: true } ), "Info" ) ) {
					ui.indent();
					ui.text("LD46");
					ui.text("DISKTREE.NET");
					if( ui.button( "PLAY" ) ) {
						loadScene( 'Game' );
					}
					ui.unindent();
				}
			}
			ui.end();
		}
        g.begin( false );
	}

	function loadScene( name : String ) {
		Scene.setActive( name, obj -> {
			trace("DONNE",obj);
		} );
	}

}
