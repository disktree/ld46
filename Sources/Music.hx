
import iron.system.Audio;
import kha.Sound;
import kha.audio1.AudioChannel;

/**
 	Simple music player
*/
class Music {

	public var id(default,null) : String;

	var channel : AudioChannel;

	public function new() {}

	public function play( id : String, volume = 0.7 ) {

		if( id == this.id ) {
			return;
		}

		this.id = id;

		if( channel != null ) {
			var ch = channel;
			Tween.to({
				target: ch,
				props: { volume: 0.0 },
				duration: 1,
				ease: iron.system.Tween.Ease.Linear,
				done: () -> {
					trace("done");
					ch.stop();
					ch = null;
				}
			});
		}

		var file = '$id.wav';
		Data.getSound( file, function(s:kha.Sound) {
			channel = Audio.play( s, true, true );
			channel.volume = 0.0;
			var fadeIn = Tween.to({
				target: channel,
				props: { volume: volume },
				duration: 1,
				ease: iron.system.Tween.Ease.Linear,
				done: () -> {
					//trace("done");
				}
				//tick: () -> trace("tick "+channel.volume),
			});
		});
	}

	public function stop( ?callback : Void->Void ) {
		if( channel == null ) {
			if( callback != null ) callback();
		} else {
			id = null;
			if( channel.finished ) {
				//channel = null;
				if( callback != null ) callback();
			} else {
				/*
				channel.stop();
				//channel = null;
				if( callback != null ) callback();
				*/

				trace("FADEOUT");
				
				Tween.to({
					target: channel,
					props: { volume: 0.0 },
					duration: 0.5,
					ease: iron.system.Tween.Ease.Linear,
					done: () -> {
						//trace("done");
						channel.stop();
						channel = null;
						id = null;
						if( callback != null ) callback();
					}
				});
				
			}
		}
	}

}
