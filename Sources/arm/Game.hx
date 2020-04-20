package arm;

import armory.trait.internal.CanvasScript;
import game.*;
import iron.system.Storage;
import zui.*;

import App.GAMEPAD_STICK_LOWPASS;

using armory.object.TransformExtension;

typedef State = {
	time : Float

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
	//var cameraIdle : CameraObject;
	
	var ambulance : Ambulance;
	var hospitals : Array<Hospital>;
	var arrow : MeshObject;

	var targets : Array<Target>;
	var targetSpawnAreas : Array<Object>;
	var minConcurrentTargets = 3;

	var hud : HUD;
	var ambientSound : SoundEffect;
	
	public function new() {
		super();
		notifyOnInit( init );
		Event.send('mode_test');
	}
	
	function init() {
		
		trace( "init" );

		//var state = loadState();
		var scene = Scene.active;

		//cameraPlay = scene.getCamera( 'Camera_play' );
		cameraPlay = scene.getCamera( 'Camera_top' );
		//cameraIdle = scene.getCamera( 'Camera_idle' );Std.int( targetSpawnAreas.length*Math.random())
		scene.camera = cameraPlay;
		
		var ambulanceType = "jeep";
		var ambulanceObject = scene.getMesh( 'Ambulance_$ambulanceType' );
		var startLoc = scene.getEmpty( 'StartLoc' );
		ambulanceObject.transform.loc = startLoc.transform.loc;
		ambulanceObject.transform.buildMatrix();
		ambulance = new Ambulance( ambulanceObject, ambulanceType );
		
		trace(scene.getGroup( 'Hospitals' ).length);
		hospitals = [];
		for( h in scene.getGroup( 'Hospitals' ) ) {
			var t = h.getTrait( Hospital );
			if( t == null ) {
				trace('WARNING: mesh in hospital group is missing hospital trait');
			} else {
				hospitals.push( t );
			}
		}
		//if( hospitals.length == 0 ) throw 'no hospital found' else trace( hospitals.length+' hospitals found' );
		if( hospitals.length == 0 ) trace( 'no hospital found') else trace( hospitals.length+' hospitals found' );

		targetSpawnAreas = scene.getGroup( 'TargetSpawnAreas' );
		//trace( targetSpawnAreas.length+' target spawn areas' );
		targetSpawnAreas = shuffle( targetSpawnAreas );

		arrow = scene.getMesh('DirectionArrow');
		//trace( arrow.materials[0].raw );

		hud = new HUD( "ANTRUM" );
		
		SoundEffect.load( 'traffic', s -> ambientSound = s.play( 0.15, true ) );
		//SoundEffect.load( 'mainmenu_ambient', s -> ambientSound = s.play( 0.2, true ) );
		
		targets = [];
		for(i in 0...minConcurrentTargets) spawnTarget();

		//Uniforms.externalVec3Links.push( vec3Link );

		//Event.send('color_white');

		notifyOnUpdate( update );
		notifyOnRender2D( (g:kha.graphics2.Graphics) -> {
			hud.render( g );
			//log.render( g );
		} );
		notifyOnRemove( () -> {
			saveState();
			if( ambientSound != null ) ambientSound.stop();
		} );
	}

	/*
	function vec3Link( object : Object, mat : MaterialData, link : String) : Vec4 {
		if( link == "RGB" ) {
			trace("REGB!!");
			var t = Time.time();
			return new Vec4(Math.sin(t) * 0.5 + 0.5, Math.cos(t) * 0.5 + 0.5, Math.sin(t + 0.5) * 0.5 + 0.5);
		}
		return null;
	}
	*/

	function update() {

		time += Time.delta;
		//var sec = Std.int( time );
		//var ms = Std.int( (time - sec) * 100);

		var scene = Scene.active;
		var vehicle = ambulance.vehicle;
		
		if( scene.camera == cameraPlay ) {
			var camera = scene.camera;
			var loc = ambulance.object.transform.world.getLoc();
			scene.camera.transform.loc.x = loc.x;
			scene.camera.transform.loc.y = loc.y;
			scene.camera.transform.buildMatrix();
		}
		
		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();
		
		if( keyboard.started( "escape" ) ) {
			Scene.setActive( "Mainmenu" );
			return;
		}

	/* 	if( keyboard.down('1') ) {
			Scene.active.camera = cameraPlay;
		} else if( keyboard.down('2') ) {
			Scene.active.camera = cameraIdle;
		} */

		if( keyboard.started( "h" ) || gamepad.started('y') ) ambulance.honk();
		

		var forward = keyboard.down(keyUp);
		var backward = keyboard.down(keyDown);
		var left = keyboard.down(keyLeft);
		var right = keyboard.down(keyRight);
		var brake = keyboard.down("space");

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
			if( ambulance.vehicle.steering < 0.3 ) ambulance.vehicle.steering += Time.step;
		} else if( right ) {
			if( ambulance.vehicle.steering > -0.3)  ambulance.vehicle.steering -= Time.step;
		} else {
			/*
			if( ambulance.vehicle.steering != 0) {
				var step = Math.abs(ambulance.vehicle.steering) < Time.step ? Math.abs(ambulance.vehicle.steering) : Time.step;
				if (ambulance.vehicle.steering > 0) ambulance.vehicle.steering -= step;
				else ambulance.vehicle.steering += step;
			}
			/
		}
		*/
		
		/*
		if( forward ) {
			ambulance.vehicle.forward();
			//ambulance.vehicle.engineForce = ambulance.vehicle.maxEngineForce;
		} else if( backward ) {
			ambulance.vehicle.engineForce = - ambulance.vehicle.maxEngineForce;
		} else if( brake ) {
			ambulance.vehicle.breakingForce = 100;
		} else {
			ambulance.vehicle.engineForce = 0;
			ambulance.vehicle.breakingForce = 50;
		}

		var maxSteering = 0.3;
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
		*/
		
		//TODO!
		if( Math.abs( gamepad.leftStick.y ) > GAMEPAD_STICK_LOWPASS ) {
			vehicle.engineForce = gamepad.leftStick.y * (vehicle.maxEngineForce);
			vehicle.breakingForce = 0;
		} else {
			vehicle.engineForce = 0;
			vehicle.breakingForce = gamepad.leftStick.y * vehicle.maxBreakingForce;
		}
		if( Math.abs( gamepad.leftStick.x ) > GAMEPAD_STICK_LOWPASS ) {
			var maxSteering = 0.25; //TODO
			vehicle.steering = - gamepad.leftStick.x * maxSteering;
		} else {
			if( vehicle.steering != 0 ) {
				var step = Math.abs( vehicle.steering ) < Time.step ? Math.abs( vehicle.steering ) : Time.step;
				if( vehicle.steering > 0 ) vehicle.steering -= step;
				else vehicle.steering += step;
			}
		}

		ambulance.update();
		
		/////////////////////////////////////////////////////
		
		function updateArrow( loc : Vec4 ) {
			arrow.visible = true;
			var dir = ambulance.object.transform.world.getLoc().sub( loc );
			var angleZ = Math.atan( dir.y / dir.x ) + PI2;
			if( dir.x < 0 ) angleZ += Math.PI;
			arrow.transform.loc.set( ambulance.object.transform.loc.x, ambulance.object.transform.loc.y, 0.4 );
			arrow.transform.setRotation( 0, 0, angleZ );
			arrow.transform.buildMatrix();
			// todo mode color
		}
		
		for( hospital in hospitals ) {
			@:privateAccess hospital.distance = ambulance.object.transform.loc.distanceTo( hospital.object.transform.loc );
		} 
		sortByDistance( hospitals );
		
		for( target in targets ) {
			target.update();
			target.distance = ambulance.object.transform.world.getLoc().distanceTo( target.area.transform.loc );
			if( target.patient.health <= 0 ) {
				trace("Target is dead, mission failed");
				targets.remove( target.destroy() );
			}
		}
		sortByDistance( targets );
		
		if( ambulance.patient != null ) {
			var hospital = hospitals[0];
			if( hospital == null ) {
				//?
			} else {
				updateArrow( hospital.object.transform.loc );
				if( ambulance.object.transform.overlap( hospital.object.transform ) ) {
					hospital.admitPatient( ambulance.patient );
					ambulance.patient = null;
					//Event.send('color_blue');
				}
			}
		} else {
			if( targets.length > 0 ) {
				if( ambulance.object.transform.overlap( targets[0].area.transform ) ) {
					ambulance.patient = targets[0].pick();
					trace( 'picked up patient' );
					Event.send('color_red');
					var t = targets.shift();
					//targets.push( t ); //TODO randomize
				} else {
					//#E0BB0B
					updateArrow( targets[0].area.transform.loc );
					///Event.send('color_blue');
				}
			}
		}
		
		if( targets.length < minConcurrentTargets ) {
			//Event.send('color_white');
			trace( "Spawn new target ("+targets.length+")" );
			//Tween.timer( 5, spawnTarget );
			spawnTarget();
		}

		var info = new Array<String>();
		if( ambulance.patient == null ) {
			info.push( 'NO PATIENT ON BOARD' );
			info.push( targets.length+ ' TARGETS' );
		} else {
			var patient = ambulance.patient;
			info.push( 'PATIENT '+patient.id+'– HEALTH:'+patient.health+' SICKNESS:'+patient.sickness );
		}
		info.push( 'FUEL: '+Std.int( ambulance.fuel * 100)  );
		hud.text = info.join('\n');
		/*
		var info = 'FUEL: '+Std.int(ambulance.fuel*100)+'\n';
		if( ambulance.patient != null ) {
			info += 'PATION ON BOARD: '+ambulance.patient;
		}
		info += targets.length+' targets';
		for( t in targets ) {
			info += 'TARGET '+Std.int(t.distance)+'\n';
			//info += 'TARGET '+(t.patient.id+1)+': '+Std.int(t.patient.health*100)+'/'+Std.int(t.patient.sickness*100)+'\n';
		}
		//trace(info);
		hud.text = info;
		*/
	}

	function spawnTarget() {

		trace( 'spawnTarget '+targets.length );
		
		var health = 1 - (Math.random()*0.3);
		var sickness = 0.25 + Math.random() * 0.75;
		var patient = new Patient( health, sickness );

		var area = targetSpawnAreas.shift();
		targetSpawnAreas.insert( Std.int((targetSpawnAreas.length-1)*Math.random()), area );
		
		//TODO
		///var area = targetSpawnAreas[Std.int((targetSpawnAreas.length-1)*Math.random())];
		//var area = targetSpawnAreas[Std.int((targetSpawnAreas.length-1)*Math.random())];
		//var area = targetSpawnAreas[0];
		var target = new Target( area, patient );
		//area.addTrait( target );
		
		/*
		var loc = area.transform.loc;
		var dim = area.transform.dim;
		// var px = loc.x + (dim.x * 2 * Math.random() - (dim.x/2));
		// var py = loc.y + (dim.y * 2 * Math.random() - (dim.y/2));
		var px = loc.x;
		var py = loc.y;
		//trace(px+":"+py);
		*/
		
		//var loc = new Vec3( -10+20*Math.random(), 10+Math.random()*40, 0 );
		
		//var target = new Target( loc, patient );
		targets.push( target );
		
		//numTargetsSpawned++;
	}

	function sortByDistance<T:{distance:Float}>( items : Array<T> ) {
		items.sort( (a,b) -> return (a.distance > b.distance) ? 1 : (a.distance < b.distance ) ? -1 : 0 );
	}
	
	function saveState() {
		
		var data = {
			time: time
		};
		/*
		var count = Storage.data.count;
		count = (count == null) ? 0 : count+1;
		Storage.data = { count: count };
		Storage.save();
		*/

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

	static function shuffle<T>( a : Array<T> ) : Array<T> {
		var x : T, j : Int, i = a.length;
		while( i > 0 ) {
			j = Math.floor( Math.random() * i );
			x = a[i-1];
			a[i-1] = a[j];
			a[j] = x;
			i--;
		}
		return a;
	}
	
}
