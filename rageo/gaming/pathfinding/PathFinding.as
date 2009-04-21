
package rageo.gaming.pathfinding
{	
	include "../index.as"
	
	public class PathFinding 
	{	
		public var nodes:Array = new Array()
		public var path:Array = new Array()
		
		private var startNode:PathNode
		private var endNode:PathNode
		
		private var list:Array = new Array()
		private var listIndex:int = 0
		
		public function mapping( endNode:PathNode )
		{
			this.endNode = endNode
			
			var t:int = getTimer()
			
			reset()
			
			endNode.level = 1
			
			list.push( endNode )
			
			do { step()	} while ( list.length )
			
			trace( "mapping:" + (getTimer() - t) )
		}
		
		private function step()
		{
			listIndex++
			
			var count:int = list.length
			var l:Array
			
			for ( var n:int = 0; n < count; n++ ) 
			{	
				l = list[n].childs
				
				for each ( var i:PathNode in l ) 
				{
					if ( i.level == 0 ) { i.level = listIndex; list.push( i ) }
				}
			}
			
			list.splice( 0, count )
		}
		
		public function reset()
		{
			for each ( var n:PathNode in nodes ) if ( n.level > 0 ) n.level = 0
			listIndex = 1		
			list.splice( 0 )
		}
		
		public function getPath( startNode:PathNode ):Array
		{
			var t:int = getTimer()
			
			this.startNode = startNode
			
			path.splice( 0 )
			
			if ( startNode.level <= 0 ) return path 
			
			var nextNode:PathNode = startNode
			
			path.push( startNode )
			
			while( nextNode != endNode )
			{
				nextNode = selectNode( nextNode )
				
				path.push( nextNode )				
			}
			
			trace( "path:" + (getTimer() - t) )
			
			return path
		}
		
		private function selectNode( n:PathNode ):PathNode
		{
			var less:PathNode = n
			
			for each ( var p:PathNode in n.childs ) if ( p.level <= less.level && p.level > 0 ) less = p
			
			return less
		}
		
		public static function createGrid( rows:int, cols:int, x:Number, y:Number, width:Number, height:Number ):PathFinding
		{
			var p:PathFinding = new PathFinding()
			
			var sizex:Number = width / cols
			var sizey:Number = height / rows
			
			for ( var v:int = 0; v < rows; v++ )
			{
				for ( var h:int = 0; h < cols; h++ )
				{
					p.nodes.push( new PathNode( h * sizex + x, v * sizey + y, 0 ) )
				}
			}
			
			var nodes:Array = p.nodes
			var n:PathNode
			
			for ( v = 0; v < rows; v++ )
			{
				for ( h = 0; h < cols; h++ )
				{
					n = nodes[ v * cols + h ]
					
					if ( h > 0 )
					{
						//if ( v > 0 ) n.addChild( nodes[ (v-1) * cols + (h-1) ] )
						//if ( v < rows-1 ) n.addChild( nodes[ (v+1) * cols + (h-1) ] )
						n.addChild( nodes[ (v) * cols + (h-1) ] )
					}
					
					if ( v > 0 ) n.addChild( nodes[ (v-1) * cols + (h) ] )
					if ( v < rows-1 ) n.addChild( nodes[ (v + 1) * cols + (h) ] )
					
					if ( h < cols-1 )
					{
						//if ( v > 0 ) n.addChild( nodes[ (v-1) * cols + (h+1) ] )
						//if ( v < rows-1 ) n.addChild( nodes[ (v+1) * cols + (h+1) ] )
						n.addChild( nodes[ (v) * cols + (h+1) ] )
					}
				}
			}
			
			return p
		}
		
	}
}

import rageo.math.*

class PathNode extends Vector3
{		
	public var level:Number = 0
	
	public var childs:Array = new Array()
	
	public function PathNode( x:Number = 0, y:Number = 0, z:Number = 0)
	{
		super( x, y, z )
	}
	
	public function addChild( n:PathNode )
	{
		childs.push( n )
	}
}	