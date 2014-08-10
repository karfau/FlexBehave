package it.sephiroth.scripting.utils
{
	public class RegexLexerContext
	{
		public var lineno: int;
		public var charno: int;
		public var columnno: int;
		public var name: String;
		public var match: String;
		public var skip: Boolean;
		public var token: Token;
		public var subpatterns: Array;
	}
}