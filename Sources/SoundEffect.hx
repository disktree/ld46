
import iron.system.Audio;
import kha.audio1.AudioChannel;

class SoundEffect {

	public var name(default,null) : String;

	//public var finished(get,null) : Bool;
	//inline function get_finished() return (channel == null || channel.finished);

	var sound : kha.Sound;
	var channel : AudioChannel;

	function new( name : String, sound : kha.Sound ) {
		this.name = name;
		this.sound = sound;
	}

	public function play( volume = 1.0, loop = false ) {
		if( channel == null || channel.finished ) {
			channel = Audio.play( sound, loop, true );
			channel.volume = volume;
		}
		return this;
	}
	
	public function stop() {
		if( channel != null ) {
			channel.stop();
		}
	}

	public static inline function load( name : String, callback : SoundEffect->Void ) {
		Data.getSound( '$name.wav', s -> callback( new SoundEffect( name, s ) ) );
	}
	
	public static inline function playOnce( name : String, ?volume : Float ) {
		load( name, s -> s.play( volume ) );
	}

}
