package rageo.net.encoder 
{
	include "../index.as"
	
	public class JSON
	{
		
	// ----o Public Methods

	static public function deserialize(source:String):* {
		
		source = new String(source) ; // Speed
		var at:Number = 0 ;
        var ch:String = ' ';
		
		var _isDigit:Function ;
		var _isHexDigit:Function ;
		var _white:Function ;
		var _string:Function ;
		var _next:Function ;
		var _array:Function ;
		var _object:Function ;
		var _number:Function ;
		var _word:Function ;
		var _value:Function ;
		var _error:Function ;
		
		_isDigit = function( /*Char*/ c:String ):* {
    		return( ("0" <= c) && (c <= "9") );
    	} ;
			
		_isHexDigit = function( /*Char*/ c:String ):* {
    		return( _isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f")) );
    	} ;
				
        _error = function(m:String):void {
            //throw new JSONError( m, at - 1 , source) ;
            throw new Error(m, at-1);
        } ;
		
        _next = function():* {
            ch = source.charAt(at);
            at += 1;
            return ch;
        } ;
		
        _white = function ():void {
           while (ch) {
                if (ch <= ' ') {
                    _next();
                } else if (ch == '/') {
                    switch (_next()) {
                        case '/':
                            while (_next() && ch != '\n' && ch != '\r') {}
                            break;
                        case '*':
                            _next();
                            for (;;) {
                                if (ch) {
                                    if (ch == '*') {
                                        if (_next() == '/') {
                                            _next();
                                            break;
                                        }
                                    } else {
                                        _next();
                                    }
                                } else {
                                    _error("Unterminated Comment");
                                }
                            }
                            break;
                        default:
                            _error("Syntax Error");
                    }
                } else {
                    break;
                }
            }
        };
		
        _string = function ():* {
            
            var i:* = '' ;
            var s:* = '' ; 
            var t:* ;
            var u:* ;
			var outer:Boolean = false;
			
            if (ch == '"') {
				
				while (_next()) {
                    if (ch == '"') 
                    {
                        _next();
                        return s;
                    }
                    else if (ch == '\\') 
                    {
                        switch (_next()) {
                        case 'b':
                            s += '\b';
                            break;
                        case 'f':
                            s += '\f';
                            break;
                        case 'n':
                            s += '\n';
                            break;
                        case 'r':
                            s += '\r';
                            break;
                        case 't':
                            s += '\t';
                            break;
                        case 'u':
                            u = 0;
                            for (i = 0; i < 4; i += 1) {
                                t = parseInt(_next(), 16);
                                if (!isFinite(t)) {
                                    outer = true;
									break;
                                }
                                u = u * 16 + t;
                            }
							if(outer) {
								outer = false;
								break;
							}
                            s += String.fromCharCode(u);
                            break;
                        default:
                            s += ch;
                        }
                    } else {
                        s += ch;
                    }
                }
            }
            _error("Bad String");
            return null ;
        } ;
		
        _array = function():* {
            var a:Array = [];
            if (ch == '[') {
                _next();
                _white();
                if (ch == ']') {
                    _next();
                    return a;
                }
                while (ch) {
                    a.push(_value());
                    _white();
                    if (ch == ']') {
                        _next();
                        return a;
                    } else if (ch != ',') {
                        break;
                    }
                    _next();
                    _white();
                }
            }
            _error("Bad Array");
            return null ;
        };
		
        _object = function ():* {
            var k:* = {} ;
            var o:* = {} ;
            if (ch == '{') {
                
                _next();
                
                _white();
                
                if (ch == '}') 
                {
                    _next() ;
                    return o ;
                }
                
                while (ch) 
                {
                    k = _string();
                    _white();
                    if (ch != ':') 
                    {
                        break;
                    }
                    _next();
                    o[k] = _value();
                    _white();
                    if (ch == '}') {
                        _next();
                        return o;
                    } else if (ch != ',') {
                        break;
                    }
                    _next();
                    _white();
                }
            }
            _error("Bad Object") ;
        };
		
        _number = function ():* {
            
            var n:* = '' ;
            var v:* ;
			var hex:String = '' ;
			var sign:String = '' ;
			
            if (ch == '-') {
                n = '-';
                sign = n ;
                _next();
            }
            
            if( ch == "0" ) {
        		_next() ;
				if( ( ch == "x") || ( ch == "X") ) {
            		_next();
            		while( _isHexDigit( ch ) ) {
                		hex += ch ;
                		_next();
                	}
            		if( hex == "" ) {   
            			_error("mal formed Hexadecimal") ;
					} else {
						return Number( sign + "0x" + hex ) ;
					}
            	} else {
	            	n += "0" ;
            	}
			}
				
            while ( _isDigit(ch) ) {
                n += ch;
                _next();
            }
            if (ch == '.') {
                n += '.';
                while (_next() && ch >= '0' && ch <= '9') {
                    n += ch;
                }
            }
            v = 1 * n ;
            if (!isFinite(v)) {
                _error("Bad Number");
            } else {
                return v;
            }
            
            return NaN ;
            
        };
		
        _word = function ():* {
            switch (ch) {
                case 't':
                    if (_next() == 'r' && _next() == 'u' && _next() == 'e') {
                        _next();
                        return true;
                    }
                    break;
                case 'f':
                    if (_next() == 'a' && _next() == 'l' && _next() == 's' && _next() == 'e') {
                        _next();
                        return false;
                    }
                    break;
                case 'n':
                    if (_next() == 'u' && _next() == 'l' && _next() == 'l') {
                        _next();
                        return null;
                    }
                    break;
            }
            _error("Syntax Error");
            return null ;
        };
		
        _value = function ():* {
            _white();
            switch (ch) {
                case '{':
                    return _object();
                case '[':
                    return _array();
                case '"':
                    return _string();
                case '-':
                    return _number();
                default:
                    return ch >= '0' && ch <= '9' ? _number() : _word();
            }
        };
		
        return _value() ;
		
    }
	
		static public function serialize(o:*):String {
    
    	    var c:String ; // char
	        var i:Number ;
        	var l:Number ;
			var s:String = '' ;
			var v:* ;
		
	        switch (typeof o) 
    	    {
        	
				case 'object' :
			
					if (o)
					{
						if (o is Array) 
						{
						
							l = o.length ;
						
							for (i = 0 ; i < l ; ++i) 
							{
								v = serialize(o[i]);
								if (s) s += ',' ;
								s += v ;
							}
							return '[' + s + ']';
						
						}
						else if (typeof(o.toString) != 'undefined') 
						{
							
							for (var prop:String in o) 
							{
								v = o[prop];
								if ( (typeof(v) != 'undefined') && (typeof(v) != 'function') ) 
								{
									v = serialize(v);
									if (s) s += ',';
									s += serialize(prop) + ':' + v ;
								}
							}
							return "{" + s + "}";
						}
					}
					return 'null';
			
				case 'number':
				
					return isFinite(o) ? String(o) : 'null' ;
				
				case 'string' :
				
					l = o.length ;
					s = '"';
					for (i = 0 ; i < l ; i += 1) {
						c = o.charAt(i);
						if (c >= ' ') {
							if (c == '\\' || c == '"') 
							{
								s += '\\';
							}
							s += c;
						} 
						else 
						{
							switch (c) 
							{
								
								case '\b':
									s += '\\b';
									break;
								case '\f':
									s += '\\f';
									break;
								case '\n':
									s += '\\n';
									break;
								case '\r':
									s += '\\r';
									break;
								case '\t':
									s += '\\t';
									break;
								default:
									var code:Number = c.charCodeAt() ;
									s += '\\u00' + (Math.floor(code / 16).toString(16)) + ((code % 16).toString(16)) ;
							}
						}
					}
					return s + '"';
				
				case 'boolean':
					return String(o);
				
				default:
					return 'null';
				
        	}
   		}
	}
}