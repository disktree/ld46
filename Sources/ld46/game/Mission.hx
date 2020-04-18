package ld46.game;

using armory.object.TransformExtension;

class Mission {

	public var loc(default,null) : Vec3;
	public var health(default,null) : Float;
	public var sickness(default,null) : Float;
	public var trigger(default,null) : MeshObject;

	public function new( loc : Vec3, health : Float, sickness : Float ) {
		
		this.loc = loc;
		this.health = health;
		this.sickness = sickness;
		
		//TODO may lead to problems
		Scene.active.spawnObject( "Trigger", null, function(object:iron.object.Object) {
			trigger = cast object;
			trigger.transform.loc.set( loc.x, loc.y, loc.z );
			trigger.transform.buildMatrix();
		});
	}

	public function update() {
		var delta = Time.delta;
		//TODO
		var v = delta * (sickness/1000);
		health -= v;
	}

	// Check if given object overlaps with the trigger
	public inline function arrived( obj : Object ) : Bool {
		return trigger.transform.overlap( obj.transform );
	}

	public function end() {
		trigger.remove();
		trigger = null;
	}

	/*
	public static function create() {
		Scene.active.spawnObject( "Trigger", null, function(object:iron.object.Object) {
			//object.transform.loc.set( mission.loc.x, mission.loc.y, 0 );
			//object.transform.buildMatrix();
		});
	}
	*/
}
