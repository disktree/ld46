
class App {

	public static var NAME = "ld66";
	public static var VERSION = "0.1.0";
	
	public static function quit() {
		kha.System.stop();
	}
	
	/*
	static inline function __init__() {
		#if kha_krom
		Krom.log( '${App.NAME} - v${App.VERSION}' );
		#end
	}
	*/
}
