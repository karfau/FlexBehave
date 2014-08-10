package it.sephiroth.scripting.utils
{
	public class Token
	{
		public static const EOF: int = -6291983;
		
		private var _value: *;
		private var _type: int;
		private var _charno: int;
		private var _lineno: int;
		private var _columnno: int;
		private var _source_name: String;
		
		public function Token( type: int, value: *, source_name: String, charno: int, lineno: int, columnno: int )
		{
			_type = type;
			_value = value;
			_charno = charno;
			_lineno = lineno;
			_columnno = columnno;
			_source_name = source_name;
		}
		
		public function get value(): *
		{
			return _value;
		}
		
		public function get type(): int
		{
			return _type;
		}
		
		public function get lineno(): int
		{
			return _lineno;
		}
		
		public function get charno(): int
		{
			return _charno;
		}
		
		public function get columnno(): int
		{
			return _columnno;
		}
		
		public function get sourceName(): String
		{
			return _source_name;
		}
		
		public function get positionString(): String
		{
			return ( _source_name + ":" + _lineno + ":" + _columnno );
		}
		
		public function toString(): String
		{
			return "T( " + _type + ", " + _value + ", " + positionString + ")";
		}
	}
}