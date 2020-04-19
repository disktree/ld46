package arm;

import game.Patient;

@:keep
class Hospital extends Trait {

	@prop
	public var id : String = "";

	@prop
	public var capacity : Int = 1000;

	public var numPatients(get,never) : Int;
	inline function get_numPatients() return patients.length;

	public var distance(default,null) : Float;

	var patients : Array<Patient> = [];
	var trigger : MeshObject;

	public function new() {
		super();
		notifyOnInit( init );
		notifyOnUpdate( update );
	}

	function init() {
	}

	function update() {
	}

	public function admitPatient( patient : Patient ) {
		patients.push( patient );
		SoundEffect.playOnce( 'patient_release' );
	}
}
