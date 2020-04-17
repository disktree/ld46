package ld46.scene;

import zui.Id;
import zui.Themes;
import zui.Zui;

class Boot extends Trait {

	var ui : Zui;
	var timer : TAnim;

	public function new() {
		super();
		notifyOnInit( init );
	}

	function init() {

		trace( "init" );

		Scene.active.camera = Scene.active.getCamera( 'Camera_Boot' );

		UI.create( UI.THEME_BOOT, ui -> this.ui = ui );

		//#if !dev
		Data.getSound( 'boot.wav', (s:kha.Sound) -> {
			var channel = Audio.play( s, false, true );
			channel.volume = 0.7;
		});
		//#end

		timer = Tween.timer( 2, () -> {
			resume();
		});

		notifyOnUpdate( update );
		notifyOnRender2D( render2D );
	}

	function update() {
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();
		if( keyboard.started('*') || mouse.started() ) {
			resume();
		}
	}

	function render2D( g : kha.graphics2.Graphics ) {
		g.end();
		if( ui != null ) {
			ui.begin( g );
			if( ui.window( Id.handle(), 20, 20, 240, 600, false ) ) {
				ui.text("BOOT", Center );
				/*
				if( ui.panel( Id.handle( { selected: true } ), "Info" ) ) {
					ui.indent();
					ui.text("LD46");
					ui.text("DISKTREE.NET");
					if( ui.button( "PLAY" ) ) {
						loadScene( 'Game' );
					}
					ui.unindent();
				}
				*/
			}
			ui.end();
		}
        g.begin( false );
	}

	inline function resume() {
		if( timer != null ) {
			Tween.stop( timer );
			timer = null;
		}
		Scene.setActive( 'Mainmenu' );
	}

}
