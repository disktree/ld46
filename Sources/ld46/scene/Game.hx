package ld46.scene;

import armory.trait.internal.CanvasScript;
import zui.*;

typedef State = {
	var time : Float;
}

class Game extends Trait {

	#if kha_krom
	static final STATE_FILE = Krom.getFilesLocation()+'/state.json';
	#end

	public function new() {
		super();
		notifyOnInit( init );
	}
	
	function init() {
		
		trace( "init" );
		
		Scene.active.camera = Scene.active.getCamera( 'Camera_Game' );
		
		loadState();
		
		notifyOnUpdate( update );

		saveState();
	}

	function update() {

		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();

		if( keyboard.started( "escape" ) ) {
			Scene.setActive( "Mainmenu" );
		}
	}
	
	function saveState() {
		#if kha_krom
		var state = { time: 23 }; //TODO
		var bytes = Bytes.ofString( Json.stringify( state ) );
		Krom.fileSaveBytes( STATE_FILE, bytes.getData() );
		#end
	}

	function loadState() {
		#if kha_krom
		Data.getBlob( STATE_FILE, b -> {
			var state = Json.parse( b.toString() );
			//TODO
			trace(state);
		});
		#end
	}
	
}
