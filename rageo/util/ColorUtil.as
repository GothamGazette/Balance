package rageo.util
{	
	include "../index.as"
	
	public class ColorUtil {
		
		public static function rgb2Hex(r:int, g:int, b:int):int 
		{
			return r << 16 ^ g << 8 ^ b
		}
		
		/**
		 * Convierte un color hexagesimal en r. g. b.
		 * @param	hex Color.
		 * @return Devuelve un objeto con las propiedades r, g, y b.
		 */
		public static function hex2Rgb(hex:int):Object
		{
			return { r:(hex & 0xff0000) >> 16, g:(hex & 0x00ff00) >> 8, b:hex & 0x0000ff}
		}		
	}	
}