package game;

/*
enum State {
	free;
	//mission( m : Mission );
}
*/

class Ambulance {

	//public var state(default,null) : State = free;
	public var object(default,null) : Object;
	public var vehicle(default,null) : Vehicle;
	//public var manned(default,null) = true;
	public var fuel(default,null) = 1.0;
	
	public var capacity(default,null) = 1;

	public var patient : Patient;


	//public var loc(get,never) : Vec4;
	//inline function get_loc() return object.transform.loc;

	//public function mission : Mission; // current active mission

	//var arrow : MeshObject;
	var horn : SoundEffect;

	public function new( object : Object ) {
		this.object = object;
		vehicle = new Vehicle( object );
		SoundEffect.load( 'horn', s -> horn = s );
		/*
		Scene.active.spawnObject( "TargetPointer", this.object, obj -> {
			arrow = cast obj;
			//pointer.transform.loc.set( loc.x, loc.y, loc.z + 3 );
			//pointer.transform.scale.set( triggerScale, triggerScale, triggerScale );
			//pointer.transform.buildMatrix();
		});
		*/
	}

	public function update() {
		fuel -= Time.delta / 1000;
		if( fuel > 0 ) {
			vehicle.update();
		}
	}
	
	/*
	public inline function distanceTo( p : { x : Float, y : Float } ) : Float {
		return object.transform.loc.distanceTo( new Vec4( p.x, p.y ) );
	}
	*/
	
	public inline function honk() {
		horn.play();
	}
	
}
