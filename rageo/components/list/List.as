/*------------------------------------------------------------------------------------------------------------------


    LIST

	
--------------------------------------------------------------------------------------------------------------------*/

package geeon.components{
	
	include "../index.as"

	public class List extends MCWrapper {
		
		public var horizontal	: Boolean	= false;
		public var columns			
		public var item
		public var list			: Array;
		public var data			: Object 	= {}
		public var margin		: Number 	= 5;
		public var marginX		: Number 	= 5;
		public var marginY		: Number 	= 5;
		public var linkage

		/*-------------------------------------------------------------
	
		CONSTRUCTOR // 
		
		--------------------------------------------------------------*/

		public function List(p){
			
			super(p);
			list			= 	[]
			horizontal 		=	Utils.or(params.horizontal, false)
			columns 		=	Utils.or(params.columns, 1)
			linkage			= 	Utils.or(params.linkage, Button)
			
			margin			= 	Utils.or(params.margin, 5)
			marginX			= 	Utils.or(params.marginX, margin)
			marginY			= 	Utils.or(params.marginY, margin)
		
		}
		
		/*-------------------------------------------------------------
	
		FILL // 
		
		--------------------------------------------------------------*/
		
		public function fill(d){

			data = d
			
			for (var n in list) {
				Thread.clean(list[n])
				Thread.dispose(list[n])
			}
			
			list = []

			for (n = 0; n<data.length; n++) {
				var item = new linkage(data[n])
				target.addChild(item)
				list.push(item)
			}

			data.length ? arrange() : null
		}
		
		
		public function arrange(){
			
			var col = columns == "auto" ? Math.ceil(Math.sqrt(data.length)) : columns;
			Utils.toColumns(list, marginX, marginY, col, horizontal)

		}
		
		
		
	}
}

