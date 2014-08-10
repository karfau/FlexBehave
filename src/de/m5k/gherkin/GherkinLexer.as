package de.m5k.gherkin {


import it.sephiroth.scripting.utils.ILexer;
import it.sephiroth.scripting.utils.Token;

public class GherkinLexer implements ILexer {
    private var _sourceName:String;

    private var _input:String;

    private var _lineno:int;
    private var _charno:int;

    private var _regExp:RegExp;
    private var _lineRegExp:RegExp;

    public function GherkinLexer(source_name:String, input:String) {
        _sourceName = source_name;
        _regExp = /\s*((Scenario Outline:?|Scenario\b:?|Feature\b:?|Examples\b:?|Background\b:?|Given\b|Then\b|And\b|When\b|But\b|#|\|)(.*)\s*)?/g;
        _lineRegExp = /([^\r\n]*)([\r\n]|$)/g;

        reset(input);

//        addRule("comment", "#.*[\r\n]+", -1);
//        addRule("newline", "[\r\n]", Tokens.NEWLINE);
//        addRule("tag", "[\r\n]", Tokens.TAG);
//        addRule("feature", "Feature:?[^\r\n]*[^\r\n]", Tokens.FEATURE);
//        addRule("background", "Background:?[^\r\n]*[^\r\n]", Tokens.BACKGROUND);
//        addRule("space", "\\s+", -1);
//        addRule("given", "Given[^\r\n]*[^\r\n]", Tokens.GIVEN);
//        addRule("then", "Then[^\r\n]*[^\r\n]", Tokens.THEN);
//        addRule("and", "And[^\r\n]*[^\r\n]", Tokens.AND);
//        addRule("but", "But[^\r\n]*[^\r\n]", Tokens.BUT);
    }


    public function get input():String {
        return _input;
    }

    public function get lineno():int {
        return _lineno;
    }

    public function get charno():int {
        return _charno;
    }

    public function get columnno():int {
        return 0;
    }

    private var _current:Token;
    public function get current():Token {
        return _current;
    }

    public function get sourceName():String {
        return _sourceName;
    }

    public function reset(input:String):void {
        _input = input;
        _lineno = 0;
        _charno = 0;
        _lineRegExp.lastIndex=0;
    }

    private static const SKIP:int = 0;

    public function next():Token {
        var value:Object = null;

        var tokenType:int = 0;
        do {
            var line:String = nextLine();

            if (line == null) {
                tokenType = Token.EOF;
//            } else if(line == "") {
//               tokenType = SKIP;
            } else {
                _regExp.lastIndex=0;
                var match:Array = _regExp.exec(line);
                if (!match) {
                    trace("ERROR " + _lineno + ":" + line)
                }else{
                    tokenType = getTokenType(match[2]);
                    if( tokenType == Tokens.TEXT){
                        value = line
                    }else if(tokenType == Tokens.TABLE_ROW ){
                        value = parseTableCells(line);
                    }else{
                        value = match[3];
                    }
                }
            }
        } while (tokenType == SKIP); // =skip
        _current = new Token(tokenType, value, sourceName, charno, lineno, columnno);
        return  _current;
    }

    private function parseTableCells(line:String):Vector.<String> {
        var list:Array = line.split(/\s*\|\s*/);
        var cells:Vector.<String> = new Vector.<String>(list.length-2);
        for(var i:int=1;i<list.length-1;i++){
            cells[i-1] = list[i];
        }
        return  cells;
    }

    private static function getTokenType(test:String):int {
        var token:int = Token.EOF;
        switch (test) {
            case "Scenario Outline":
            case "Scenario Outline:":
                token = Tokens.SCENARIO_OUTLINE;
                break;
            case "Scenario:":
            case "Scenario":
                token = Tokens.SCENARIO;
                break;
            case "Feature:":
            case "Feature":
                token = Tokens.FEATURE;
                break;
            case "Examples:":
            case "Examples":
                token = Tokens.EXAMPLES;
                break;
            case "Background:":
            case "Background":
                token = Tokens.BACKGROUND;
                break;
            case "Given":
                token = Tokens.GIVEN;
                break;
            case "Then":
                token = Tokens.THEN;
                break;
            case "And":
                token = Tokens.AND;
                break;
            case "But":
                token = Tokens.BUT;
                break;
            case "When":
                token = Tokens.WHEN;
                break;
            case null:
            case "#":
                token = SKIP;
                break;
            case "|":
                token = Tokens.TABLE_ROW;
                break;
            default :
                token = Tokens.TEXT;
                break;
        }
        return token;
    }

    private function createEOFTocken():Token {
        return new Token(Token.EOF, null, sourceName, charno, lineno, columnno);
    }

    public function nextLine():String {
        if (_charno < 0 || _charno >= input.length) {
            return null;
        }
        var match:* = _lineRegExp.exec(_input);
        _charno=_lineRegExp.lastIndex;
        if(match){
            _lineno++;
            return match[1];
        }else{
            return null;
        }

//        var last:int = _charno;
//        if(last>0) last++;
//        _lineno++;
//
//        _charno = _input.indexOf("\n", last);
//        if (_charno >last) {
//
//            return _input.substring(last, _charno);
//        } else {
//            return _input.substring(last);
//        }

    }
}
}
