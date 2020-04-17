package ld46.scene;

class Boot extends Trait {

	var timer : TAnim;

	public function new() {
		super();
		notifyOnInit( () -> {
			
			//#if !dev
			Data.getSound( 'boot.wav', (s:kha.Sound) -> {
				var channel = Audio.play( s, false, true );
				channel.volume = 0.7;
			});
			//#end

			timer = Tween.timer( 1, () -> {
				resume();
			});

			notifyOnUpdate( () -> {
				var keyboard = Input.getKeyboard();
				var mouse = Input.getMouse();
				if( keyboard.started('*') || mouse.started() ) {
					resume();
				}
			} );
		} );
	}

	function init() {

		Data.getSound( 'boot.wav', (s:kha.Sound) -> {
			var channel = Audio.play( s, false, true );
			channel.volume = 0.7;
		});

		timer = Tween.timer( 2, () -> {
			resume();
		});

		///var cameraObject = scene.getCamera( 'BootCamera' );
		//trace(cameraObject);
		//trace("PLAY MUSIC");
		//App.music.play("Machine-QuiteRumble");
		//App.music.play("boot");
	}

	function update() {
		/*
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();
		if( keyboard.started( "enter" ) || keyboard.started( "space" )
			|| mouse.started() ) {
				resume();
			}
			*/
	}

	inline function resume() {
		if( timer != null ) {
			Tween.stop( timer );
			timer = null;
		}
		//App.music.stop();
		//App.music.play("Machine-QuiteRumble");
		//App.music.play("Bass-Deep 05");
		//trace("resume");
		//trace(App.music.volume);
		//App.music.volume = 0.05;
		///trace(App.music.volume);
		/*
		App.music.stop( () -> {
			Scene.setActive( 'Menu' );
		});
		*/
		Scene.setActive( 'Mainmenu' );
	}

}
