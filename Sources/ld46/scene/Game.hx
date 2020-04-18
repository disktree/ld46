package ld46.scene;

import armory.trait.internal.CanvasScript;
import iron.system.Storage;
import ld46.game.Ambulance;
import ld46.game.Mission;
import ld46.game.Sickness;
import zui.*;

using armory.object.TransformExtension;

typedef State = {
	var count : Int;
	//var time : Float;
}

class Game extends Trait {

	#if kha_krom
	//static final STATE_FILE = Krom.getFilesLocation()+'/state.json';
	#end

	var time = 0.0;
	var cameraTarget : Object;
	var arrow : MeshObject;
	var ambulance : Ambulance;
	var missions : Array<Mission>;
	var maxMissions = 3;
	//var sickness : Sickness;

	public function new() {
		super();
		notifyOnInit( init );
		notifyOnRemove( () -> {
			saveState();
		} );
	}
	
	function init() {
		
		trace( "init" );
		
		var scene = Scene.active;

		scene.camera = scene.getCamera( 'Camera_Game' );
		
		cameraTarget = scene.getEmpty( "CameraTarget" );
		arrow = scene.getMesh( "DirectionArrow" );
		ambulance = new Ambulance( scene.getMesh( "Ambulance" ) );

		//sickness = new Sickness();

		/* triggers = [];
		var i = 0;
		while( true ) {
			var tr = scene.getChild( 'Trigger'+i );
			if( tr == null ) break else triggers.push( tr.transform );
			i++;
		}
		trace(triggers.length+' triggers found' ); */

		//var state = loadState();

		missions = [];
		createMission();
		
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
		
		var camera = Scene.active.camera;
		
		camera.transform.loc.x = ambulance.object.transform.loc.x;
		camera.transform.loc.y = ambulance.object.transform.loc.y;
		camera.transform.buildMatrix();
	
		//sickness.update( time );

		for( mission in missions ) {
			mission.update();
			if( mission.health <= 0 ) {
				trace("Mission failed");
				mission.end();
				missions.remove( mission );
				mission = null;
			} else {
				
				var direction = ambulance.object.transform.world.getLoc().sub( mission.trigger.transform.world.getLoc() );
				var angleZ = Math.atan( direction.y / direction.x ) + PI2;
				if( direction.x < 0 ) angleZ += Math.PI;
				arrow.transform.loc.set( ambulance.loc.x, ambulance.loc.y, 3 );
				arrow.transform.setRotation( 0, 0, angleZ );
				
				var distanceToMission = ambulance.distanceTo( mission.loc );
				if( distanceToMission <= 15 ) {
					trace("NEAR MISSION GOAL");
					if( mission.arrived( ambulance.object ) ) {
						trace("ARRIVED AT MISSION");
						mission.end();
						missions.remove( mission );
						mission = null;
					}
				}
			}
		}

		ambulance.update();

		/*
		activeTrigger = null;
		for( i in 0...triggers.length ) {
			var tr = triggers[i];
			if( ambulance.object.transform.overlap( tr ) ) {
				//Event.send( 'trigger_$i' );
				activeTrigger = i;
				break;
			}
		}
		if( activeTrigger != null ) {
			trace("Trigger "+activeTrigger );
		}
		*/
	}

	///TODO random select from a list of mission origin objects in world 
	function createMission() {
		//var px = Math.random();
		var mission = new Mission( new Vec3( 10, 15 ), 1.0, 0.5 );
		missions.push( mission );
		return mission;
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
