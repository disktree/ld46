package ld46.scene;

import armory.trait.internal.CanvasScript;
import iron.system.Storage;
import zui.*;

typedef State = {
	var count : Int;
	//var time : Float;
}

class Game extends Trait {

	#if kha_krom
	//static final STATE_FILE = Krom.getFilesLocation()+'/state.json';
	#end

	var monkey : MeshObject;

	public function new() {
		super();
		notifyOnInit( init );
		notifyOnRemove( () -> {
			saveState();
		} );
	}
	
	function init() {
		
		trace( "init" );
		
		Scene.active.camera = Scene.active.getCamera( 'Camera_Game' );
		
		var state = loadState();
		trace(state); //TODO

		monkey = Scene.active.getMesh('Suzanne');
		
		notifyOnUpdate( update );
	}

	function update() {

		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();

		if( keyboard.started( "escape" ) ) {
			Scene.setActive( "Mainmenu" );
		}

		monkey.transform.rotate( Vec4.zAxis(), 0.01 );
	}
	
	function saveState() {
		var count = Storage.data.count;
		count = (count == null) ? 0 : count+1;
		Storage.data = { count: count };
		Storage.save();
		/* #if kha_krom
		var state = { time: 23 }; //TODO
		var bytes = Bytes.ofString( Json.stringify( state ) );
		Krom.fileSaveBytes( STATE_FILE, bytes.getData() );
		#end */
	}
	
	function loadState() {
		return Storage.data;
		/*
		#if kha_krom
		Data.getBlob( STATE_FILE, b -> {
			var state = Json.parse( b.toString() );
			//TODO
			trace(state);
		});
		#end
		*/
	}
	
}
