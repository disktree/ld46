package ld46.scene;

import armory.data.Config;
import armory.renderpath.RenderPathCreator;
import armory.trait.internal.CanvasScript;
import iron.RenderPath;
import zui.*;

class Mainmenu extends Trait {

	static var SCREEN_RESOLUTION = [
		[3840,2160],
		[1920,1080],
		[1280,720],
	];

	//var canvas : CanvasScript;
	var ui : Zui;
	var audio : AudioChannel;
	var currentScreenResolution : Int;

	public function new() {
		super();
		notifyOnInit( init );
		notifyOnRemove( () -> {
			if( audio != null ) {
				audio.stop();
				audio = null;
			}
		} );
	}
	
	function init() {
		
		trace( "init" );

		Scene.active.camera = Scene.active.getCamera( 'Camera_Mainmenu' );

		UI.create( ui -> this.ui = ui );

		Data.getSound( 'mainmenu_ambient.wav', (s:kha.Sound) -> {
			audio = Audio.play( s, true, false );
			audio.volume = 0.7;
		});

		/*
		for( i in 0...SCREEN_RESOLUTION.length ) {
			if( SCREEN_RESOLUTION[i][0] == Config.raw.window_w ) {
				currentScreenResolution = i;
				break;
			}
		}
		trace(currentScreenResolution);
		 */
		 
		Event.add( "play", () -> loadScene( 'Game' ) );
		Event.add( "quit", App.quit );
		
		notifyOnUpdate( update );
		notifyOnRender2D( render2D );
	}

	function update() {

		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();

		if( keyboard.started( "escape" ) ) {
			App.quit();
		}
		if( keyboard.started( "space" ) ) {
			loadScene( 'Game' );
		}
	}

	function render2D( g : kha.graphics2.Graphics ) {
		g.end();
		if( ui != null ) {
			var cfg = Config.raw;
			ui.begin( g );
			if( ui.window( Id.handle(), 20, 20, 300, 600, false ) ) {
				//ui.text("LD46");
				//ui.text("DISKTREE.NET");
				if( ui.panel( Id.handle( { selected: true } ), "SETTINGS" ) ) {
					//var resolution = ui.combo( Id.handle( { position: currentScreenResolution } ), [for(r in SCREEN_RESOLUTION) r[0]+'x'+r[1]], 'RESOLUTION' );
					var bloom = ui.check( Id.handle( { selected: cfg.rp_bloom } ), 'BLOOM' );
					var dynres = ui.check( Id.handle( { selected: cfg.rp_dynres } ), 'DYNAMIC RESOLUTIOM' );
					var motionblur = ui.check( Id.handle( { selected: cfg.rp_motionblur } ), 'MOTIONBLUR' );
					if( ui.button( 'APPLY' ) ) {
						cfg.rp_bloom = bloom;
						cfg.rp_dynres = dynres;
						cfg.rp_motionblur = motionblur;
						/*
						currentScreenResolution = resolution;
						var res = SCREEN_RESOLUTION[resolution];
						cfg.window_w = res[0]; 
						cfg.window_h = res[1];
						*/
						RenderPathCreator.applyConfig();
						Config.save();
					}
				}
			}
			ui.end();
		}
        g.begin( false );
	}

	function loadScene( name : String ) {
		Scene.setActive( name, obj -> {
			//trace( "scene activated:. "+obj );
		} );
	}

}
