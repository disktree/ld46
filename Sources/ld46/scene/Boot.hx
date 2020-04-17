package ld46.scene;

import App;
import kha.Image;
import zui.Id;
import zui.Themes;
import zui.Zui;

class Boot extends Trait {

	var ui : Zui;
	//var img : Image;
	var timer : TAnim;

	public function new() {
		super();
		notifyOnInit( init );
	}

	function init() {

		trace( "init" );

		//Scene.active.camera = Scene.active.getCamera( 'Camera_Boot' );

		//UI.create( UI.THEME_BOOT, ui -> this.ui = ui );

		//Data.getImage( 'boot.jpg', img -> this.img = img );

		/*
		//#if !dev
		Data.getSound( 'boot.wav', (s:kha.Sound) -> {
			var channel = Audio.play( s, false, true );
			channel.volume = 0.7;
		});
		//#end
		*/
		
		notifyOnUpdate( update );
		//notifyOnRender2D( render2D );
		
		timer = Tween.timer( 3, () -> {
			resume();
		});
	}

	function update() {
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();
		if( keyboard.started('space') || mouse.started() ) {
			resume();
		}
	}

	/*
	function render2D( g : kha.graphics2.Graphics ) {
		g.end();
		if( ui != null ) {
			ui.begin( g );
			if( ui.window( Id.handle(), 0, 0, 1920, 1080, false ) ) {
				//ui.text("BOOT", Center );
				/*
				if( img != null ) {
					//ui.image( img, 0xffffffff );
				}
				* /
			}
			ui.end();
		}
        g.begin( false );
	}
	*/

	inline function resume() {
		if( timer != null ) {
			Tween.stop( timer );
			timer = null;
		}
		Scene.setActive( 'Mainmenu' );
	}

}
