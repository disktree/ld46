
import iron.system.Audio;
import kha.audio1.AudioChannel;

class SoundEffect {

	public var name(default,null) : String;

	var sound : kha.Sound;
	var channel : AudioChannel;

	function new( name : String, sound : kha.Sound ) {
		this.name = name;
		this.sound = sound;
	}

	public function play( volume = 1.0 ) {
		channel = Audio.play( sound, false, true );
		channel.volume = volume;
	}
	
	public function stop() {
		if( channel !!= null ) {
			channel.stop();
		}
	}

	public static function load( name : String, callback : SoundEffect->Void ) {
		Data.getSound( '$name.wav', (s:kha.Sound) -> {
			callback( new SoundEffect( name, s ) );
		});
	}

}
