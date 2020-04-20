package game;

/*
class Target extends Trait {

	public var loc(default,null) : Vec3;
	public var patient(default,null) : Patient;

	public var distance : Float;

	//public var trigger(default,null) : MeshObject;
	public var pointer(default,null) : MeshObject;

	public function new( patient : Patient ) {
		super();
		this.patient = patient;
		notifyOnAdd( () -> trace("TARGET ADD") );
		notifyOnInit( () -> {
			trace("TARGET INIT");
			Scene.active.spawnObject( "TargetPointer", object, obj -> {
				pointer = cast obj;
				trace( object.transform.loc );
				//pointer.transform.loc.set( .x, loc.y, loc.z + 3 );
				/*
				pointer = cast object;
				pointer.transform.loc.set( loc.x, loc.y, loc.z + 3 );
				//pointer.transform.scale.set( triggerScale, triggerScale, triggerScale );
				pointer.transform.buildMatrix();
				* /
			}); 
		 });
		notifyOnUpdate( update );
		
		/*
		//TODO use the empty bounding box to determine hitbox
		var triggerScale = 1;
		Scene.active.spawnObject( "Spawn_TargetTrigger", null, object -> {
			trigger = cast object;
			trigger.visible = false;
			trigger.transform.loc.set( loc.x, loc.y, loc.z + 3 );
			trigger.transform.scale.set( triggerScale, triggerScale, triggerScale );
			trigger.transform.buildMatrix();
		});
		* /
		Scene.active.spawnObject( "Spawn_TargetPointer", null, object -> {
			pointer = cast object;
			pointer.transform.loc.set( loc.x, loc.y, loc.z + 3 );
			//pointer.transform.scale.set( triggerScale, triggerScale, triggerScale );
			pointer.transform.buildMatrix();
		});
		* /
	}

	function update() {
		if( !patient.update() ) {
			Event.send( 'death' );
		}
	}

	/*
	public function pick() : Patient {
		SoundEffect.playOnce( 'patient_pick' );
		destroy();
		return patient;
	}
	
	public function destroy() {
		pointer.remove();
		trigger.remove();
	}
	* /
} 
*/


class Target {

	public var area(default,null) : Object;
	public var patient(default,null) : Patient;
	//public var trigger(default,null) : MeshObject;
	public var pointer(default,null) : MeshObject;
	public var distance : Float;

	public function new( area : Object, patient : Patient ) {
		
		this.area = area;
		this.patient = patient;

		Scene.active.spawnObject( "TargetPointer", null, object -> {
			pointer = cast object;
			pointer.transform.loc = area.transform.loc;
			//pointer.transform.scale.set( triggerScale, triggerScale, triggerScale );
			pointer.transform.buildMatrix();
		});
		
		/*
		//TODO use the empty bounding box to determine hitbox
		var triggerScale = 1;
		Scene.active.spawnObject( "Spawn_TargetTrigger", null, object -> {
			trigger = cast object;
			trigger.visible = false;
			trigger.transform.loc.set( loc.x, loc.y, loc.z + 3 );
			trigger.transform.scale.set( triggerScale, triggerScale, triggerScale );
			trigger.transform.buildMatrix();
		});
		*/
		/*
		Scene.active.spawnObject( "Spawn_TargetPointer", null, object -> {
			pointer = cast object;
			pointer.transform.loc.set( loc.x, loc.y, loc.z + 3 );
			//pointer.transform.scale.set( triggerScale, triggerScale, triggerScale );
			pointer.transform.buildMatrix();
		});
		*/
	}

	public function update() {
		patient.update();
	}

	public function pick() : Patient {
		SoundEffect.playOnce( 'patient_pick' );
		return destroy().patient;
	}
	
	public function destroy() {
		pointer.remove();
		//trigger.remove();
		return this;
	}
}



/* 
class Target {

	public var loc(default,null) : Vec3;
	public var patient(default,null) : Patient;

	public var distance : Float;

	public var trigger(default,null) : MeshObject;
	public var pointer(default,null) : MeshObject;

	public function new( loc : Vec3, patient : Patient ) {
		
		this.loc = loc;
		this.patient = patient;
		
		/*
		//TODO use the empty bounding box to determine hitbox
		var triggerScale = 1;
		Scene.active.spawnObject( "Spawn_TargetTrigger", null, object -> {
			trigger = cast object;
			trigger.visible = false;
			trigger.transform.loc.set( loc.x, loc.y, loc.z + 3 );
			trigger.transform.scale.set( triggerScale, triggerScale, triggerScale );
			trigger.transform.buildMatrix();
		});
		* /
		Scene.active.spawnObject( "Spawn_TargetPointer", null, object -> {
			pointer = cast object;
			pointer.transform.loc.set( loc.x, loc.y, loc.z + 3 );
			//pointer.transform.scale.set( triggerScale, triggerScale, triggerScale );
			pointer.transform.buildMatrix();
		});
	}

	public function update() {
		patient.update();
	}

	public function pick() : Patient {
		SoundEffect.playOnce( 'patient_pick' );
		destroy();
		return patient;
	}
	
	public function destroy() {
		pointer.remove();
		trigger.remove();
	}
} */