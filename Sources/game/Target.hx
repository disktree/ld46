package game;

using armory.object.TransformExtension;

class Target {

	public var loc(default,null) : Vec3;
	public var patient(default,null) : Patient;

	public var distance(default,null) : Float;

	public var trigger(default,null) : MeshObject;
	public var pointer(default,null) : MeshObject;

	public function new( loc : Vec3, patient : Patient ) {
		
		this.loc = loc;
		this.patient = patient;
		
		var triggerScale = 1;
		Scene.active.spawnObject( "Spawn_TargetTrigger", null, object -> {
			trigger = cast object;
			trigger.visible = false;
			trigger.transform.loc.set( loc.x, loc.y, loc.z + 3 );
			trigger.transform.scale.set( triggerScale, triggerScale, triggerScale );
			trigger.transform.buildMatrix();
		});
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
}
