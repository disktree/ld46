package ld46.game;

typedef Patient = {
	var location : Vec3;
	var start : Float;
	var duration : Float;
}

class Sickness {

	var data : Array<Patient>;

	public function new( data : Array<Patient> ) {
		this.data = data;
	}

	public function update( time : Float ) {
		//…
	}

}
