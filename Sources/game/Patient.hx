package game;

using armory.object.TransformExtension;

class Patient {

	public var health : Float;
	public var sickness : Float;

	public function new( health : Float, sickness : Float ) {
		this.health = health;
		this.sickness = sickness;
	}

	public function update() {
		var delta = Time.delta;
		//TODO
		var v = delta * (sickness/1000);
		health -= v;
	}
}
