package game;

using armory.object.TransformExtension;

class Patient {

	static var INC = 0;

	public final id : Int;
	public var health : Float;
	public var sickness : Float;

	public function new( health : Float, sickness : Float ) {
		this.id = INC++;
		this.health = health;
		this.sickness = sickness;
	}

	public function update() : Bool {
		//TODO
		var delta = Time.delta;
		var v = delta * (sickness/1000);
		health -= v;
		if( health < 0 ) health = 0;
		return health > 0;
	}
}
