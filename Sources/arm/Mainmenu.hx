package arm;

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

	var ui : MainmenuUI;
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
		
		Scene.active.camera = Scene.active.getCamera( 'Camera_Mainmenu' );

		ui = new MainmenuUI();

		/*
		#if !dev
		Data.getSound( 'mainmenu_ambient.wav', (s:kha.Sound) -> {
			audio = Audio.play( s, true, false );
			audio.volume = 0.7;
		});
		#end
		*/

		/*
		for( i in 0...SCREEN_RESOLUTION.length ) {
			if( SCREEN_RESOLUTION[i][0] == Config.raw.window_w ) {
				currentScreenResolution = i;
				break;
			}
		}
		trace(currentScreenResolution);
		 */
		 
		Event.add( "play", () -> Scene.setActive( "Game" ) );
		Event.add( "quit", App.quit );
		
		notifyOnUpdate( update );
		notifyOnRender2D( ui.render );
	}

	function update() {
		var gamepad = Input.getGamepad( 0 );
		var keyboard = Input.getKeyboard();
		var mouse = Input.getMouse();
		if( keyboard.started( "escape" ) ) {
			ui.visible = false;
			App.quit();
		} else {
			if( keyboard.started( "space" )
				|| mouse.down()
				|| gamepad.started("a") ) {
				Scene.setActive( 'Game' );
			}
		}
	}
}

private class MainmenuUI extends UI {

	public inline function new( ?visible : Bool ) {
		super( visible );
	}

	override function renderGraphics( g : kha.graphics2.Graphics ) {
		trace("renderGraphics");
		if( ui.window( Id.handle(), 10, 10, 400, 200, false ) ) {
			ui.text( "ANTRUM" );
		}
	}
	
	/*
	function render2D( g : kha.graphics2.Graphics ) {
		g.end();
		if( ui != null ) {
			ui.begin( g );
			
			if( ui.window( Id.handle(), 20, 20, 300, 600, false ) ) {
				if( ui.panel( Id.handle( { selected: true } ), "LUDUM DARE 64" ) ) {
					//var resolution = ui.combo( Id.handle( { position: currentScreenResolution } ), [for(r in SCREEN_RESOLUTION) r[0]+'x'+r[1]], 'RESOLUTION' );
					/*
					var cfg = Config.raw;
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
						* /
						RenderPathCreator.applyConfig();
						Config.save();
					}
					* /
					if( ui.button( 'PLAY' ) ) {
						loadScene( 'Game' );
					}
					if( ui.button( 'QUIT' ) ) {
						App.quit();
					}
				}
			}
			ui.end();
		}
		g.begin( false );
	}
	*/
}
