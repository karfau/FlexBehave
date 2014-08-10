package it.sephiroth.scripting.utils {
public interface ILexer {
    function get input():String;
    function get lineno():int;
    function get charno():int;
    function get columnno():int;
    function get current():Token;
    function get sourceName():String;
    function reset(input:String):void;
    function next():Token;
}
}