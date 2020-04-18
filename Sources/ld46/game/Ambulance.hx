package ld46.game;

import iron.Trait;
import iron.object.Object;
import iron.object.CameraObject;
import iron.object.Transform;
import iron.system.Time;
import armory.trait.physics.PhysicsWorld;

class Ambulance extends Trait {

	static inline var GAMEPAD_STICK_LOWPASS = 0.05;
	static inline var GAMEPAD_TURRET_LOWPASS = 0.2;
	static inline var GAMEPAD_GUN_LOWPASS = 0.2;

	var vehicle : Vehicle;
	var maxSteering = 0.4;
 	
	public function new() {
		super();
		//notifyOnInit( init );
		notifyOnAdd( () -> {
			vehicle = new Vehicle( object );
		});
		notifyOnUpdate( update );
	}

	function init() {
	}

	function update() {

		var gamepad = Input.getGamepad( 0 );

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

		//trace(vehicle.engineForce);
		
		vehicle.update();
	}
	
}
