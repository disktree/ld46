package ld46.game;

import iron.object.Object;
import iron.object.CameraObject;
import iron.object.Transform;
import iron.system.Time;
import armory.trait.physics.PhysicsWorld;

class Ambulance {

	#if arm_azerty
	static inline var keyUp = 'z';
	static inline var keyDown = 's';
	static inline var keyLeft = 'q';
	static inline var keyRight = 'd';
	static inline var keyStrafeUp = 'e';
	static inline var keyStrafeDown = 'a';
	#else
	static inline var keyUp = 'w';
	static inline var keyDown = 's';
	static inline var keyLeft = 'a';
	static inline var keyRight = 'd';
	static inline var keyStrafeUp = 'e';
	static inline var keyStrafeDown = 'q';
	#end

	static inline var GAMEPAD_STICK_LOWPASS = 0.05;
	static inline var GAMEPAD_TURRET_LOWPASS = 0.2;
	static inline var GAMEPAD_GUN_LOWPASS = 0.2;

	public var object(default,null) : MeshObject;

	public var loc(get,never) : Vec4;
	inline function get_loc() return object.transform.loc;

	//public function mission : Mission; // current active mission

	var vehicle : Vehicle;
	var maxSteering = 0.4;
 	
	public function new( object : MeshObject ) {
		this.object = object;
		vehicle = new Vehicle( object );
		//trace(object.raw.dimensions);
	}

	public function update() {

		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();

		if( Math.abs( gamepad.leftStick.y ) > GAMEPAD_STICK_LOWPASS ) {
			vehicle.engineForce = gamepad.leftStick.y * 3000;
			vehicle.breakingForce = 0;
		} else {
			vehicle.engineForce = 0;
			vehicle.breakingForce = 100;
		}

		if( Math.abs( gamepad.leftStick.x ) > GAMEPAD_STICK_LOWPASS ) {
			vehicle.vehicleSteering = - gamepad.leftStick.x * maxSteering;
		} else {
			/*
			if( vehicle.vehicleSteering != 0 ) {
				var step = Math.abs( vehicle.vehicleSteering ) < Time.step ? Math.abs( vehicle.vehicleSteering ) : Time.step;
				if( vehicle.vehicleSteering > 0 ) vehicle.vehicleSteering -= step;
				else vehicle.vehicleSteering += step;
			}
			*/
		}

		/*
		var forward = keyboard.down(keyUp);
		var backward = keyboard.down(keyDown);
		var left = keyboard.down(keyLeft);
		var right = keyboard.down(keyRight);
		var brake = keyboard.down("space");
		
		if (forward) {
			vehicle.engineForce = vehicle.maxEngineForce;
		}
		else if (backward) {
			vehicle.engineForce = - vehicle.maxEngineForce;
		}
		else if (brake) {
			vehicle.breakingForce = 100;
		}
		else {
			vehicle.engineForce = 0;
			vehicle.breakingForce = 20;
		}
		*/
		
		//trace(vehicle.engineForce);
		
		vehicle.update();
	}

	public inline function distanceTo( p : { x : Float, y : Float } ) : Float {
		return object.transform.loc.distanceTo( new Vec4( p.x, p.y ) );
	}
	
}
