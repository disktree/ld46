package game;

class Ambulance {

	public var object(default,null) : Object;
	public var type(default,null) : String;
	public var vehicle(default,null) : Vehicle;
	public var fuel(default,null) = 1.0;
	public var capacity(default,null) = 1;
	public var patient : Patient;

	//var arrow : MeshObject;
	var horn : SoundEffect;

	public function new( object : Object, type : String ) {
		this.object = object;
		this.type = type;
		vehicle = new Vehicle( object, 'Wheel_${type}_' );
		SoundEffect.load( 'horn', s -> horn = s );
	}

	public function update() {
		fuel -= Time.delta / 1000;
		if( fuel > 0 ) {
			vehicle.update();
		}
	}
	
	public inline function honk() {
		horn.play();
	}
	
}
