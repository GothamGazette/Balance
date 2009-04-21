package rageo.util
{	
	include "../index.as"
	
	public class XMLUtil 
	{		
		
		
		public static function toObject( xml )
		{
			var xmlDoc:XMLDocument 	= 	new XMLDocument ()
			xmlDoc.ignoreWhite 		= 	true
			xmlDoc.parseXML( xml )
			return parseNode( xmlDoc.firstChild, [] )
		}

		private static function parseNode( node, object ):Object
		{
			ArrayUtil.extract( node.attributes, object )
			if ( node.firstChild && node.firstChild.nodeType == 3 ) {
				var text = node.firstChild.nodeValue
				MathUtil.isNumber( text ) ? text = Number( text ) : null
				ArrayUtil.length( node.attributes ) ? object.value = text : object = text
			}else{
				var nodes = node.childNodes
				for ( var n = 0; n<nodes.length; n++ ) {
					object[  nodes[n].nodeName == "item" ? object.length : nodes[n].nodeName  ] = parseNode( nodes[n], [] )
				}
			}
			return object
		}
		
		public static var validNodes 	: String
		public static var xml 			: String
		public static var validChars 	: String = "ABCDEFGHIJKLMÑNOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz0123456789_!;"
		
		public static function toXML(obj:Object, filter:String = null) 
		{
			validNodes 		= 	""
			xml 			=	""
			return 		"<data>" + objtoXML( obj, filter ) + "</data>"
		}

		private static function objtoXML( obj, filter){
		
			for (var tag in obj) {
				
				var node			=	obj[ tag ]
				if ( typeof(node)  != "function" && !( filter != null && filter.indexOf(tag) == -1 ) ){
					
					var tagName		=	tag is int ? "item" : tag
					xml 			+= 	"<"+tagName+">" 

					if (typeof (node) == "object") {
						
						objtoXML( node, filter )	
						
					}	else {
						
						var cdata 			= 	!(node is Number)	
						if (cdata){
							cdata			=	validNodes.indexOf( node ) == -1
							var n:int 		= 	0
							while (cdata && n <= node.length){
								cdata		=	validChars.indexOf( node.charAt(n) ) == -1
								n++
							}
							xml += "<![CDATA[" + node + "]]>"
							
						}	else {
							
							validNodes += node
							xml += node
							
						}
					}
					
					xml += "</"+tagName+">"
					
				}
			}
		}
		
		
	}
	
}