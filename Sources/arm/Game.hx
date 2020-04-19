package arm;

import armory.trait.internal.CanvasScript;
import game.*;
import iron.system.Storage;
import zui.*;

import App.GAMEPAD_STICK_LOWPASS;

using armory.object.TransformExtension;

typedef State = {
	var count : Int;

	///var missions : Array<Dynamic>;
}

class Game extends Trait {

	#if arm_azerty
	static inline var keyUp = "z";
	static inline var keyDown = "s";
	static inline var keyLeft = "q";
	static inline var keyRight = "d";
	static inline var keyStrafeUp = "e";
	static inline var keyStrafeDown = "a";
	#else
	static inline var keyUp = "w";
	static inline var keyDown = "s";
	static inline var keyLeft = "a";
	static inline var keyRight = "d";
	static inline var keyStrafeUp = "e";
	static inline var keyStrafeDown = "q";
	#end

	var time = 0.0;

	var cameraPlay : CameraObject;
	var cameraIdle : CameraObject;
	
	var arrow : MeshObject;

	var hospitals : Array<Hospital>;
	var ambulance : Ambulance;

	var targets : Array<Target>;
	var minConcurrentTargets = 1;
	var maxConcurrentTargets = 3;

	var hud : HUD;
	var log : Log;

	var ambientSound : SoundEffect;
	
	public function new() {
		super();
		notifyOnInit( init );
	}
	
	function init() {
		
		trace( "init" );

		var scene = Scene.active;

		cameraPlay = scene.getCamera( 'Camera_play' );
		cameraIdle = scene.getCamera( 'Camera_idle' );
		scene.camera = cameraPlay;
		//scene.camera = cameraIdle;

		var ground = scene.getMesh( 'Ground' );

		var ambulanceObject = scene.getMesh( "Ambulance_jeep" );
		// var ambulanceObject = scene.getMesh( "Ambulance_van" );
		ambulanceObject.transform.loc.set( 0, 0, 2 );
		ambulance = new Ambulance( ambulanceObject );

		arrow = scene.getMesh('Arrow');

		hospitals = [];
		for( h in scene.getGroup( 'Hospitals' ) ) {
			var t = h.getTrait( Hospital );
			if( t == null ) {
				trace('WARNING: mesh in hospital group is missing hospital trait');
			} else {
				hospitals.push( t );
			}
		}

		/*
		var scene = Scene.active;
		
		scene.camera = scene.getCamera( 'Camera_Game' );
		
		cameraTarget = scene.getEmpty( "CameraTarget" );
		arrow = scene.getMesh( "DirectionArrow" );
		ambulance = new Ambulance( scene.getMesh( "Ambulance" ) );

		//sickness = new Sickness();

		hospitals =  [];
		for( obj in scene.meshes ) {
			var t  = obj.getTrait( Hospital );
			if( t != null ) {
				hospitals.push( t );
				//trace(obj.properties);
			}
		}
		trace(hospitals.length+' hospitals found' ); 

		//var state = loadState();

		missions = [];
		createMission();
		
		notifyOnUpdate( update );
		*/

		targets = [for(i in 0...minConcurrentTargets) createTarget() ];

		hud = new HUD();
		log = new Log();
		//for( i in 0...1 ) log.print("DISKTREE");
		//log.clear();

		SoundEffect.load( 'traffic', s -> ambientSound = s.play( 0.3, true ) );

		notifyOnUpdate( update );
		notifyOnRender2D( g -> {
			hud.render( g );
			log.render( g );
		} );
		notifyOnRemove( () -> {
			saveState();
			if( ambientSound != null ) ambientSound.stop();
		} );
	}

	function update() {

		time += Time.delta;
		//var sec = Std.int( time );
		//var ms = Std.int( (time - sec) * 100);

		if( Scene.active.camera == cameraPlay ) {
			var camera = Scene.active.camera;
			var loc = ambulance.object.transform.world.getLoc();
			Scene.active.camera.transform.loc.set( loc.x, loc.y, 100 ); //TODO
		}
		
		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();
		
		if( keyboard.started( "escape" ) ) {
			Scene.setActive( "Mainmenu" );
			return;
		}

		if( keyboard.started( "h" ) ) ambulance.honk();
		
		var forward = keyboard.down(keyUp);
		var backward = keyboard.down(keyDown);
		var left = keyboard.down(keyLeft);
		var right = keyboard.down(keyRight);
		var brake = keyboard.down("space");

		if( keyboard.down('1') ) {
			Scene.active.camera = cameraPlay;
		} else if( keyboard.down('2') ) {
			Scene.active.camera = cameraIdle;
		}

		/*
		if( forward ) {
			ambulance.vehicle.forward();
		} else if( backward ) {
			ambulance.vehicle.backward();
		} else {
			// ambulance.vehicle.engineForce = - ambulance.vehicle.maxEngineForce;
			// ambulance.vehicle.engineForce = 0;
			// ambulance.vehicle.breakingForce = 100;
			ambulance.vehicle.rollout();
		}
		if( left ) {
			trace(ambulance.vehicle.steering);
			if( ambulance.vehicle.steering < 0.3 ) ambulance.vehicle.steering += Time.step;
		} else if( right ) {
			if( ambulance.vehicle.steering > -0.3)  ambulance.vehicle.steering -= Time.step;
		} else {
			if( ambulance.vehicle.steering != 0) {
				var step = Math.abs(ambulance.vehicle.steering) < Time.step ? Math.abs(ambulance.vehicle.steering) : Time.step;
				if (ambulance.vehicle.steering > 0) ambulance.vehicle.steering -= step;
				else ambulance.vehicle.steering += step;
			}
		}
		*/
		
		if( forward ) {
			ambulance.vehicle.forward();
			//ambulance.vehicle.engineForce = ambulance.vehicle.maxEngineForce;
		} else if( backward ) {
			ambulance.vehicle.engineForce = - ambulance.vehicle.maxEngineForce;
		} else if( brake ) {
			ambulance.vehicle.breakingForce = 100;
		} else {
			ambulance.vehicle.engineForce = 0;
			ambulance.vehicle.breakingForce = 20;
		}

		var maxSteering = 0.2;
		if( left ) {
			if( ambulance.vehicle.steering < maxSteering) ambulance.vehicle.steering += Time.step;
		} else if (right) {
			if( ambulance.vehicle.steering > -maxSteering) ambulance.vehicle.steering -= Time.step;
		} else {
			if( ambulance.vehicle.steering != 0) {
				var step = Math.abs(ambulance.vehicle.steering) < Time.step ? Math.abs(ambulance.vehicle.steering) : Time.step;
				if (ambulance.vehicle.steering > 0) ambulance.vehicle.steering -= step;
				else ambulance.vehicle.steering += step;
			}
		}
	
		/*
		//TODO!
		if( Math.abs( gamepad.leftStick.y ) > GAMEPAD_STICK_LOWPASS ) {
			ambulance.vehicle.engineForce = gamepad.leftStick.y * 3000;
			ambulance.vehicle.breakingForce = 0;
		} else {
			ambulance.vehicle.engineForce = 0;
			ambulance.vehicle.breakingForce = 100;
		}
		
		if( Math.abs( gamepad.leftStick.x ) > GAMEPAD_STICK_LOWPASS ) {
			ambulance.vehicle.steering = - gamepad.leftStick.x;// * maxSteering;
		} else {
			/*
			if( ambulance.vehicle.steering != 0 ) {
				var step = Math.abs( ambulance.vehicle.steering ) < Time.step ? Math.abs( ambulance.vehicle.steering ) : Time.step;
				if( ambulance.vehicle.steering > 0 ) ambulance.vehicle.steering -= step;
				else ambulance.vehicle.steering += step;
			}
			* /
		}
		*/

		ambulance.update();

		for( hospital in hospitals ) {
			@:privateAccess hospital.distance = ambulance.object.transform.loc.distanceTo( hospital.object.transform.loc );
		}

		var hospital = hospitals[0];
		var direction = ambulance.object.transform.world.getLoc().sub( hospital.object.transform.world.getLoc() );
		var angleZ = Math.atan( direction.y / direction.x ) + PI2;
		if( direction.x < 0 ) angleZ += Math.PI;
		arrow.transform.loc.set( ambulance.object.transform.loc.x, ambulance.object.transform.loc.y, 3 );
		arrow.transform.setRotation( 0, 0, angleZ );


		if( ambulance.patient == null ) {
			for( target in targets ) {
				target.update();
				if( target.patient.health <= 0 ) {
					trace("Target is dead, mission failed");
					target.destroy();
					targets.remove( target );
				} else {
					var distance = ambulance.object.transform.loc.distanceTo( new Vec4( target.loc.x, target.loc.y, target.loc.z ) );
					if( distance <= 15 ) {
						if( target.trigger.transform.overlap( ambulance.object.transform ) ) {
							ambulance.patient = target.pick();
							targets.remove( target );
							log.print( ' picked up patient' );
						}
					}
				}
			}
		} else {
			for( hospital in hospitals ) {
				//var distance = ambulance.object.transform.loc.distanceTo( hospital.transform.loc );
				if( ambulance.object.transform.overlap( hospital.object.transform ) ) {
					//ambulance.releasePatient( hospital );
					var patient = ambulance.patient;
					ambulance.patient = null;
					hospital.admitPatient( patient );
					log.print( 'patient -> '+hospital.id+'['+hospital.numPatients+']' );
				}
				//if( target.trigger.transform.overlap( ambulance.object.transform ) ) {
			}
		}
		
		if( targets.length < minConcurrentTargets ) {
			//trace("SPaWN new mission");
			//createTarget();
		}
		
		var info = ''; //'FUEL: '+ambulance.fuel; //targets.length+' TARGETS';
		info += hospitals.length+' HOSPITALS\n';
		for( h in hospitals ) info += h.id+'\n';
		if( ambulance.patient != null ) info += 'PATIENT: '+ambulance.patient+'\n';
		hud.text = info;

		/*
		switch ambulance.state {
		case free:
		case mission(m):
		}

		for( mission in missions ) {
			mission.update();
			if( mission.health <= 0 ) {
				trace("Mission failed");
				mission.end();
				missions.remove( mission );
				mission = null;
			} else {
				
				/*
				var direction = ambulance.object.transform.world.getLoc().sub( mission.trigger.transform.world.getLoc() );
				var angleZ = Math.atan( direction.y / direction.x ) + PI2;
				if( direction.x < 0 ) angleZ += Math.PI;
				arrow.transform.loc.set( ambulance.loc.x, ambulance.loc.y, 3 );
				arrow.transform.setRotation( 0, 0, angleZ );
				* /
				
				var distanceToMission = ambulance.distanceTo( mission.loc );
				if( distanceToMission <= 15 ) {
					trace("NEAR MISSION GOAL");
					if( mission.arrived( ambulance.object ) ) {
						trace("ARRIVED AT MISSION");
						//mission.end();
						//missions.remove( mission );
						mission = null;
					}
				}
			}
		}
		
		// --- User input

		if( gamepad.started('y') ) ambulance.honk();

		if( Math.abs( gamepad.leftStick.y ) > GAMEPAD_STICK_LOWPASS ) {
			ambulance.vehicle.engineForce = gamepad.leftStick.y * 3000;
			ambulance.vehicle.breakingForce = 0;
		} else {
			ambulance.vehicle.engineForce = 0;
			ambulance.vehicle.breakingForce = 100;
		}
		
		if( Math.abs( gamepad.leftStick.x ) > GAMEPAD_STICK_LOWPASS ) {
			ambulance.vehicle.steering = - gamepad.leftStick.x;// * maxSteering;
		} else {
			/*
			if( vehicle.vehicleSteering != 0 ) {
				var step = Math.abs( vehicle.vehicleSteering ) < Time.step ? Math.abs( vehicle.vehicleSteering ) : Time.step;
				if( vehicle.vehicleSteering > 0 ) vehicle.vehicleSteering -= step;
				else vehicle.vehicleSteering += step;
			}
			* /
		}

		ambulance.update();
		*/
	}

	
	function createTarget() {
		///TODO random select from a list of mission origin objects in world 
		var v = 20;
		var sx = -v + (v * 2 * Math.random() );
		var sy = -v + (v * 2 * Math.random() );
		sx = 0;
		sy = 10;

		var patient = new Patient( 1.0, 0.5 );
		var target = new Target( new Vec3( sx, sy ), patient);

		return target;
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
