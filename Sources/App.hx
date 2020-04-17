
@:keep
class App {

	public static inline var NAME = "ld66";
	public static inline var VERSION = "0.1.0";
	
	///public static var music(default,null) = new Music();
	
	public static function quit() {
		kha.System.stop();
	}
	
	static inline function __init__() {
		#if kha_krom
		Krom.log( '${App.NAME} - v${App.VERSION}' );
		#end
	}
}
