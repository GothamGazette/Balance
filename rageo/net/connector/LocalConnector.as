package gna.system.net
{	
	import flash.display.*
	import flash.events.*
	import flash.net.*
	import flash.system.*
	import flash.ui.*
	import flash.utils.*
	import gna.system.*
	import gna.utils.*
	
	public class Connector
	{
		
		public static var LOCAL_CONNECTION 	: String = "localConnection"
		public static var SHARED_OBJECT 	: String = "sharedObject"
		public static var SOCKET		 	: String = "socket"
		
		public var data 					: Object = {}
		public var uri 						: String
		public var mode 					: String
		public var onResult 				: Function
		public var localConnection 			: LocalConnection
		
		public function Connector( uri:String, onResult:Function , onlyReceive:Boolean=false) 
		{
			this.uri 						=	uri
			this.onResult 					=	onResult
			this.mode 						=	mode
			
		//	if(mode == "localConnection")
		//	{
			localConnection 				=	new LocalConnection()
			localConnection.client 			= 	this
			onlyReceive ? localConnection.connect( uri ) : null
		//	}
		}
		
		public function getConnection( object )
		{
			data[ object.name ] 			=	object.value
			onResult( object )
		}
		
		
		public function connect()
		{
			
		}
		
		public function close()
		{
			
		}
		
		public function send( name:String, value )
		{
		//	if(mode == "localConnection")
		//	{
				localConnection.send( uri, "getConnection",{ name:name, value:value })
		//	}
		}
		
	}
}