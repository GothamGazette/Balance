package rageo.system.input
{	
	include "../index.as"

	public class Input {
		
		internal static var downs				: Array = new Array()
		internal static var hits				: Array = new Array()
		internal static var _mouseDobleClick	: int
		internal static var _delta				: int = 0
		internal static var _mouseHit			: int
		internal static var stage 				: Stage
		internal static var root 				: Sprite 
		

		public static function start() 
		{
			stage 				= 	Document.stage
			root 				= 	Document.root
			mouseX 				= 	root.mouseX
			mouseY 				= 	root.mouseY		
			
			trace( root, stage )
			
			stage.addEventListener("keyDown", keyDownEvent)
			stage.addEventListener("keyUp", keyUpEvent)
			stage.addEventListener("mouseDown", mouseDownEvent)
			stage.addEventListener("mouseUp", mouseUpEvent)
			stage.addEventListener("mouseWheel", mouseWheelEvent)
			stage.addEventListener("doubleClick", mouseDobleClickEvent)
			
			Cycle.add( update, true )
		}
		
		public static function stop() 
		{
			stage.removeEventListener("keyDown", keyDownEvent)
			stage.removeEventListener("keyUp", keyUpEvent)
			stage.removeEventListener("mouseDown", mouseDownEvent)
			stage.removeEventListener("mouseUp", mouseUpEvent)
			stage.removeEventListener("doubleClick", mouseDobleClickEvent)
			stage.removeEventListener("mouseWheel", mouseWheelEvent)
			
			for (var i:int = 0; i < 255; i++)
			{
				downs[i] = false
				hits[i] = false
			}
			
			Cycle.remove( update )
		}
		
		public static function add( listener:Function, type:String )
		{
			remove ( listener, type )
			Listeners[ type ][ listener ] = true
		}
		
		public static function remove( listener:Function, type:String )
		{	
			delete Listeners[ type ][ listener ]
		}
		
		public static function dispatch( e:Event )
		{
			var type = e.type
			for ( var n in Listeners[ type ] ) { n() }
		}
		
		public static function update() 
		{
			mouseXSpeed 	= 	root.mouseX - mouseX
			mouseYSpeed 	= 	root.mouseY - mouseY
			mouseX 			= 	root.mouseX
			mouseY 			= 	root.mouseY
		}
		
		private static function keyDownEvent(e:KeyboardEvent) 
		{
			if (!downs[e.keyCode]) hits[e.keyCode] = true
			downs[e.keyCode] = true
			dispatch( e )
		}

		private static function keyUpEvent(e:KeyboardEvent) 
		{
			downs[e.keyCode] = false
			hits[e.keyCode] = false
			dispatch( e )
		}
		
		private static function mouseDownEvent(e:MouseEvent) 
		{
			mouseDown = 1
			mouseHit = 1
			dispatch( e )
		}
		
		private static function mouseWheelEvent(e:MouseEvent)
		{
			_delta = e.delta
			dispatch( e )
		}
		
		private static function mouseUpEvent(e:MouseEvent) 
		{
			mouseDown = 0
			mouseHit = 0
			mouseUp = 1
			dispatch( e )
		}
		
		private static function mouseDobleClickEvent(e:MouseEvent)
		{
			_mouseDobleClick = 1
			dispatch( e )
		}
		
		public static function keyDown(keyCode:int):Boolean 
		{
			return downs[keyCode]
		}
		
		public static function keyHit(keyCode:int):Boolean 
		{
			if (hits[keyCode]) 
			{
				hits[keyCode] = false
				return true
			}
			else 
			{
				return false
			}
		}
		
		public static function set mouseHit(value:int)
		{
			_mouseHit = value
		}
		
		public static function get mouseHit():int
		{
			var value:int = _mouseHit
			_mouseHit = 0
			return value
		}
		
		public static function get mouseDobleClick():int
		{
			var value:int = _mouseDobleClick
			_mouseDobleClick = 0
			return value
		}
		
		public static function get delta():int
		{
			var value:int = _delta
			_delta = 0
			return value
		}
		
		public static var mouseX:Number
		public static var mouseY:Number
		public static var mouseXSpeed:Number
		public static var mouseYSpeed:Number
		public static var mouseDown:int = 0
		public static var mouseUp:int = 1
		
		public static const A:uint = 65;
		public static const B:uint = 66;
		public static const C:uint = 67;
		public static const D:uint = 68;
		public static const E:uint = 69;
		public static const F:uint = 70;
		public static const G:uint = 71;
		public static const H:uint = 72;
		public static const I:uint = 73;
		public static const J:uint = 74;
		public static const K:uint = 75;
		public static const L:uint = 76;
		public static const M:uint = 77;
		public static const N:uint = 78;
		public static const O:uint = 79;
		public static const P:uint = 80;
		public static const Q:uint = 81;
		public static const R:uint = 82;
		public static const S:uint = 83;
		public static const T:uint = 84;
		public static const U:uint = 85;
		public static const V:uint = 86;
		public static const W:uint = 87;
		public static const X:uint = 88;
		public static const Y:uint = 89;
		public static const Z:uint = 90;
		
		public static const ALTERNATE:uint = 18;
		public static const BACKQUOTE:uint = 192;
		public static const BACKSLASH:uint = 220;
		public static const BACKSPACE:uint = 8;
		public static const CAPS_LOCK:uint = 20;
		public static const COMMA:uint = 188;
		public static const COMMAND:uint = 19;
		public static const CONTROL:uint = 17;
		public static const DELETE:uint = 46;
		public static const DOWN:uint = 40;
		public static const END:uint = 35;
		public static const ENTER:uint = 13;
		public static const EQUAL:uint = 187;
		public static const ESCAPE:uint = 27;
		public static const F1:uint = 112;
		public static const F10:uint = 121;
		public static const F11:uint = 122;
		public static const F12:uint = 123;
		public static const F13:uint = 124;
		public static const F14:uint = 125;
		public static const F15:uint = 126;
		public static const F2:uint = 113;
		public static const F3:uint = 114;
		public static const F4:uint = 115;
		public static const F5:uint = 116;
		public static const F6:uint = 117;
		public static const F7:uint = 118;
		public static const F8:uint = 119;
		public static const F9:uint = 120;
		public static const HOME:uint = 36;
		public static const INSERT:uint = 45;
		public static const LEFT:uint = 37;
		public static const LEFTBRACKET:uint = 219;
		public static const MINUS:uint = 189;
		public static const NUMBER_0:uint = 48;
		public static const NUMBER_1:uint = 49;
		public static const NUMBER_2:uint = 50;
		public static const NUMBER_3:uint = 51;
		public static const NUMBER_4:uint = 52;
		public static const NUMBER_5:uint = 53;
		public static const NUMBER_6:uint = 54;
		public static const NUMBER_7:uint = 55;
		public static const NUMBER_8:uint = 56;
		public static const NUMBER_9:uint = 57;
		public static const NUMPAD:uint = 21;
		public static const NUMPAD_0:uint = 96;
		public static const NUMPAD_1:uint = 97;
		public static const NUMPAD_2:uint = 98;
		public static const NUMPAD_3:uint = 99;
		public static const NUMPAD_4:uint = 100;
		public static const NUMPAD_5:uint = 101;
		public static const NUMPAD_6:uint = 102;
		public static const NUMPAD_7:uint = 103;
		public static const NUMPAD_8:uint = 104;
		public static const NUMPAD_9:uint = 105;
		public static const NUMPAD_ADD:uint = 107;
		public static const NUMPAD_DECIMAL:uint = 110;
		public static const NUMPAD_DIVIDE:uint = 111;
		public static const NUMPAD_ENTER:uint = 108;
		public static const NUMPAD_MULTIPLY:uint = 106;
		public static const NUMPAD_SUBTRACT:uint = 109;
		public static const PAGE_DOWN:uint = 34;
		public static const PAGE_UP:uint = 33;
		public static const PERIOD:uint = 190;
		public static const QUOTE:uint = 222;
		public static const RIGHT:uint = 39;
		public static const RIGHTBRACKET:uint = 221;
		public static const SEMICOLON:uint = 186;
		public static const SHIFT:uint = 16;
		public static const SLASH:uint = 191;
		public static const SPACE:uint = 32;
		public static const TAB:uint = 9;
		public static const UP:uint = 38;
	}
	
}

import flash.utils.Dictionary

class Listeners 
{
	public static var mouseDown			: Dictionary = new Dictionary()
	public static var mouseUp			: Dictionary = new Dictionary()
	public static var keyDown			: Dictionary = new Dictionary()
	public static var keyUp				: Dictionary = new Dictionary()
	public static var mouseWheel		: Dictionary = new Dictionary()
	public static var mouseMove			: Dictionary = new Dictionary()
}