package ld46.game;

import iron.Trait;
import iron.object.Object;
import iron.object.CameraObject;
import iron.object.Transform;
import iron.system.Time;
import armory.trait.physics.PhysicsWorld;

class Vehicle {

	var wheel0Name: String = "Wheel0";
	var wheel1Name: String = "Wheel1";
	var wheel2Name: String = "Wheel2";
	var wheel3Name: String = "Wheel3";

	var target : Object;
	var physics: PhysicsWorld;
	var transform: Transform;
	var camera: CameraObject;

	var wheels: Array<Object> = [];
	var vehicle: bullet.Bt.RaycastVehicle = null;
	var chassis: bullet.Bt.RigidBody;

	var chassisMass = 1200; /////600.0;
	var wheelFriction = 1000;
	var suspensionStiffness = 20.0;
	var suspensionDamping = 2.3;
	var suspensionCompression = 4.4;
	var suspensionRestLength = 0.3;
	var rollInfluence = 0.1;
	
	public var engineForce = 0.0;
	public var breakingForce = 0.0;
	public var vehicleSteering = 0.0;

	public var maxEngineForce = 3000.0;
	public var maxBreakingForce = 500.0;

	public function new( target : Object ) {

		this.target = target;

		physics = armory.trait.physics.PhysicsWorld.active;
		transform = target.transform;

		wheels = [];
		wheels[0] = target.getChild( wheel0Name );
		wheels[1] = target.getChild( wheel1Name );
		wheels[2] = target.getChild( wheel2Name );
		wheels[3] = target.getChild( wheel3Name );

		var chassisShape = new bullet.Bt.BoxShape( new bullet.Bt.Vector3( transform.dim.x/2, transform.dim.y/2, transform.dim.z/2 ) );
		var compound = new bullet.Bt.CompoundShape();
		var localTrans = new bullet.Bt.Transform();
		localTrans.setIdentity();
		localTrans.setOrigin( new bullet.Bt.Vector3( 0, 0, 1 ) );
		compound.addChildShape( localTrans, chassisShape );
		chassis = createRigidBody( chassisMass, compound );
	
		var tuning = new bullet.Bt.VehicleTuning();
		var vehicleRayCaster = new bullet.Bt.DefaultVehicleRaycaster( physics.world );
		vehicle = new bullet.Bt.RaycastVehicle( tuning, chassis, vehicleRayCaster );

		// Never deactivate the vehicle
		chassis.setActivationState( bullet.Bt.CollisionObject.DISABLE_DEACTIVATION );

		// Choose coordinate system
		var rightIndex = 0; 
		var upIndex = 2; 
		var forwardIndex = 1;
		vehicle.setCoordinateSystem( rightIndex, upIndex, forwardIndex );

		var wheelDirectionCS0 = new bullet.Bt.Vector3( 0, 0, -1 );
		//var wheelDirectionCS0 = new bullet.Bt.Vector3( 0, 0, 0 );
		var wheelAxleCS = new bullet.Bt.Vector3( 1, 0, 0 );
		//var wheelAxleCS = new bullet.Bt.Vector3( 0, 0, 0 );

		for( i in 0...wheels.length ) {
			var vehicleWheel = new Wheel( i, wheels[i].transform, target.transform );
			vehicle.addWheel(
				vehicleWheel.getConnectionPoint(),
				wheelDirectionCS0,
				wheelAxleCS,
				suspensionRestLength,
				vehicleWheel.wheelRadius,
				tuning,
				vehicleWheel.isFrontWheel
			);
		}

		for( i in 0...vehicle.getNumWheels() ) {
			var wheel = vehicle.getWheelInfo( i );
			wheel.m_suspensionStiffness = suspensionStiffness;
			wheel.m_wheelsDampingRelaxation = suspensionDamping;
			wheel.m_wheelsDampingCompression = suspensionCompression;
			wheel.m_frictionSlip = wheelFriction;
			wheel.m_rollInfluence = rollInfluence;
		}

		physics.world.addAction( vehicle );
	}

	public function update() {

		vehicle.applyEngineForce( engineForce, 2 );
		vehicle.setBrake( breakingForce, 2 );
		vehicle.applyEngineForce( engineForce, 3 );
		vehicle.setBrake( breakingForce, 3 );

		vehicle.setSteeringValue( vehicleSteering, 0 );
		vehicle.setSteeringValue( vehicleSteering, 1 );

		for( i in 0...vehicle.getNumWheels() ) {
			
			// Synchronize the wheels with the chassis worldtransform
			vehicle.updateWheelTransform( i, false );
			
			// Update wheels transforms
			var trans = vehicle.getWheelTransformWS( i );
			var p = trans.getOrigin();
			var q = trans.getRotation();
			//wheels[i].transform.localOnly = true;
			wheels[i].transform.localOnly = true;
			wheels[i].transform.loc.set( p.x(), p.y(), p.z() );
			wheels[i].transform.rot.set( q.x(), q.y(), q.z(), q.w() );
			wheels[i].transform.dirty = true;
		}

		var trans = chassis.getWorldTransform();
		var p = trans.getOrigin();
		var q = trans.getRotation();
		var transform = target.transform;
		transform.loc.set( p.x(), p.y(), p.z() );
		transform.rot.set( q.x(), q.y(), q.z(), q.w() );
		var up = transform.world.up();
		transform.loc.add( up );
		transform.dirty = true;
	}

	function createRigidBody( mass : Float, shape : bullet.Bt.CompoundShape ) : bullet.Bt.RigidBody {
		
		var localInertia = new bullet.Bt.Vector3( 0, 0, 0 );
		shape.calculateLocalInertia( mass, localInertia );

		var centerOfMassOffset = new bullet.Bt.Transform();
		centerOfMassOffset.setIdentity();

		var startTransform = new bullet.Bt.Transform();
		startTransform.setIdentity();
		startTransform.setOrigin( new bullet.Bt.Vector3( transform.loc.x, transform.loc.y, transform.loc.z ) );
		startTransform.setRotation( new bullet.Bt.Quaternion( transform.rot.x, transform.rot.y, transform.rot.z, transform.rot.w ) );

		var myMotionState = new bullet.Bt.DefaultMotionState( startTransform, centerOfMassOffset );
		var cInfo = new bullet.Bt.RigidBodyConstructionInfo( mass, myMotionState, shape, localInertia );
		var body = new bullet.Bt.RigidBody( cInfo );
		body.setLinearVelocity( new bullet.Bt.Vector3( 0, 0, 0 ) );
		body.setAngularVelocity( new bullet.Bt.Vector3( 0, 0, 0 ) );
		
		physics.world.addRigidBody( body );

		return body;
	}
}

class Wheel {

	public var isFrontWheel: Bool;
	public var wheelRadius: Float;
	public var wheelWidth: Float;

	var locX: Float;
	var locY: Float;
	var locZ: Float;

	public function new(id: Int, transform: Transform, vehicleTransform: Transform) {
		wheelRadius = transform.dim.z / 2;
		wheelWidth = transform.dim.x > transform.dim.y ? transform.dim.y : transform.dim.x;

		locX = transform.loc.x;
		locY = transform.loc.y;
		locZ = vehicleTransform.dim.z / 2 + transform.loc.z;
	}

	public function getConnectionPoint(): bullet.Bt.Vector3 {
		return new bullet.Bt.Vector3(locX, locY, locZ);
	}
}
