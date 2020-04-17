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
		
		trace( "init" );
		
		/*
		canvas = Scene.active.getTrait( CanvasScript );
		canvas.notifyOnReady( function() {
			canvas.getElement("Version").text = App.VERSION;
		});
		*/
		
		UI.create( ui -> this.ui = ui );

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
			//SoundEffect.load('boot', s -> s.play() );
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
			//trace( "scene activated:. "+obj );
		} );
	}

}
