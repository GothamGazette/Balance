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
	
	public class Remoting extends Proxy {
		
		public var connection		: NetConnection = new NetConnection()
		public var uri				: String
		public var service			: String
		public var onResult			: Function
		public var onError			: Function

		public function Remoting( uri:String, service:String, onResult:Function, onError:Function=null ) 
		{
			this.uri 					= 	uri
			this.service				= 	service
			this.onResult				=	onResult
			this.onError				=	onError
			
			connection.client 			= 	this
			connection.objectEncoding 	= 	ObjectEncoding.AMF0
				
			connection.addEventListener( IOErrorEvent.IO_ERROR, internalError )
			connection.addEventListener( SecurityErrorEvent.SECURITY_ERROR , internalError )

			connection.connect( uri )
		}
		

		/*-------------------------------------------------------------
		
		EVENTS // 
		
		--------------------------------------------------------------*/

		public function internalResult( response = null ) 
		{
			onResult( response )
		}
		
		public function internalError( e:Event ) 
		{
			trace( "Error", e )
			onError( e ) 
		}
		
		public function call(methodName:String, arguments:Array):void 
		{
			var responder:Responder 	= 	new Responder( internalResult, internalError )
			var operationPath:String 	= 	service + "." + methodName.toString()
			var callArgs:Array 			= 	new Array(operationPath, responder)
			
			connection.call.apply( null, callArgs.concat(arguments) )
		}
		
		flash_proxy override function callProperty(methodName:*, ...args):* 
		{
			try 
			{
				call(methodName, args)
			}
			catch(error:Error){}
			
			return null
		}

	}
}
