package ld46.scene;

import armory.trait.internal.CanvasScript;
import zui.*;

class Game extends Trait {

	public function new() {
		super();
		notifyOnInit( init );
	}
	
	function init() {
		
		trace( "init" );

		Scene.active.camera = Scene.active.getCamera( 'Camera_Game' );
		
		notifyOnUpdate( update );
	}

	function update() {

		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();

		if( keyboard.started( "escape" ) ) {
			Scene.setActive( "Mainmenu" );
		}
	}
	
}
