/*------------------------------------------------------------------------------------------------------------------


    HIT TEST
	

--------------------------------------------------------------------------------------------------------------------*/

package rageo.math.collision {

	include "../index.as"
	
	public class HitTest {
		
		
		
		/*-------------------------------------------------------------
	
		MOUSE

		--------------------------------------------------------------*/
		
		public static function mouse(target){
			
			return target.hitTestPoint(target.stage.mouseX, target.stage.mouseY, true)
			
		}
		
		
		/*-------------------------------------------------------------
	
		INNER BOUNDS

		--------------------------------------------------------------
		
		public static function innerBounds ( a:Bounds, b:Bounds , s:SpriteParticle=null){
			
			var v 		= 		new Bounds()
			
			b.left 		?		v.left		=	Utils.constrain( b.left 	-  a.left ) 	: null
			b.right 	?		v.right		=	Utils.constrain( a.right 	-  b.right ) 	: null  
			b.top 		?		v.top		=	Utils.constrain( b.top 		-  a.top ) 		: null 
			b.bottom 	?		v.bottom	=	Utils.constrain( a.bottom 	-  b.bottom ) 	: null
			
			v.hit 		= 		v.left || v.right || v.top || v.bottom

			
			if ( s  && v.hit ){
				
				v.left 	|| v.right	?	(s.velocity.x = 0, s.x = s.transform.x += v.left - v.right ) : null
				v.top 	|| v.bottom	?	(s.velocity.y = 0, s.y = s.transform.y += v.top - v.bottom ) : null

			}

			return v

		}
		
		-------------------------------------------------------------
	
		OUTER BOUNDS

		--------------------------------------------------------------
		
		public static function outerBounds ( a:Bounds, b:Bounds , s:SpriteParticle=null){
			
			var v 		= 	new Vector()
			
			if (a.right >= b.left 	&& 	a.left <= b.right && a.top <= b.bottom  && a.bottom >= b.top){
				
				v.hit 			=	true
				
				var left		=	Utils.constrain( b.right - a.left ) 
				var right		=	Utils.constrain( a.right - b.left )
				var top			=	Utils.constrain( b.bottom - a.top )
				var bottom		=	Utils.constrain( a.bottom - b.top ) 
				
				v.x				=	left < right	?	left : -right
				v.y				=	top < bottom	?	top : -bottom
				
				if (s){
					Utils.positive (v.x) < Utils.positive (v.y) ? (s.velocity.x = 0, s.x = s.transform.x +=  v.x ) : (s.velocity.y = 0, s.y = s.transform.y +=  v.y )
				}
				
			}

			return v

		}
		
		
		-------------------------------------------------------------
	
		RADIUS 2D

		--------------------------------------------------------------
		
		public static function radius2D(a, b, y="y,", x="x", rad=100, full=false){

			var hipo = Utils.hipotenusa(a, b, y, x);
			hipo.hit = hipo.h<rad
			
			return hipo;
		}

		-------------------------------------------------------------
	
		AVOIDANCE

		--------------------------------------------------------------
		
		public static function avoidance(A,B){
		
			var h=square(A,B)
			
			if (h.hit){
				
				// avoidance
				var offx=A.point.x>B.point.x?A.bounds.left-B.bounds.right : A.bounds.right-B.bounds.left
				var offz=A.point.z>B.point.z?A.bounds.back-B.bounds.front : A.bounds.front-B.bounds.back
				
				if (Math.abs(offx)>Math.abs(offz)){
					A.point.z-=offz/2;
					B.point.z+=offz/2;
				}else{
					A.point.x-=offx/2;
					B.point.x+=offx/2;
				}
				A.render();
				B.render();
			}
		}
		*/
	}
}


	