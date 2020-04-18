package ld46.scene;

import armory.trait.internal.CanvasScript;
import iron.system.Storage;
import zui.*;

using armory.object.TransformExtension;

typedef State = {
	var count : Int;
	//var time : Float;
}

class Game extends Trait {

	var time = 0.0;
	var ambulance : MeshObject;
	var cameraTarget : Object;
	var triggers : Array<Transform>;
	var activeTrigger : Int;
	var sickness : Sickness;

	public function new() {
		super();
		notifyOnInit( init );
		notifyOnAdd( () -> {
			trace("ADD");
		});
		notifyOnRemove( () -> {
			saveState();
			//Input.getMouse().unlock();
		} );
	}
	
	function init() {
		
		trace( "init" );
		
		time = 0.0;

		Scene.active.camera = Scene.active.getCamera( 'Camera_Game' );
		//Input.getMouse().lock();

		ambulance = Scene.active.getMesh( "Ambulance" );
		cameraTarget = Scene.active.getEmpty( "CameraTarget" );
		
		sickness = new Sickness();

		triggers = [];
		var i = 0;
		while( true ) {
			var tr = Scene.active.getChild( 'Trigger'+i );
			if( tr == null ) break else triggers.push( tr.transform );
			i++;
		}
		trace(triggers.length+' triggers found' );

		//trace(Scene.active.getChild( 'Trigger1' ) );
		//Event.add( "play", () -> gotoScene( 'Game' ) );
		
		//var state = loadState();
		///trace(state); //TODO

		notifyOnUpdate( update );
	}

	function update() {

		var delta = iron.system.Time.delta;
		time += delta;
		//var sec = Std.int( time );
		//var ms = Std.int( (time - sec) * 100);

		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();

		if( keyboard.started( "escape" ) ) {
			Scene.setActive( "Mainmenu" );
			return;
		}

		Scene.active.camera.transform.loc.x = ambulance.transform.loc.x;
		Scene.active.camera.transform.loc.y = ambulance.transform.loc.y;
		Scene.active.camera.transform.buildMatrix();
		//cameraTarget.transform.loc = ambulance.transform.loc;
		//cameraTarget.transform.buildMatrix();

		sickness.update( time );

		activeTrigger = null;
		for( i in 0...triggers.length ) {
			var tr = triggers[i];
			if( ambulance.transform.overlap( tr ) ) {
				//Event.send( 'trigger_$i' );
				activeTrigger = i;
				break;
			}
		}
		if( activeTrigger != null ) {
			trace("Trigger "+activeTrigger );
		}
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
