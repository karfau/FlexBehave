package it.sephiroth.scripting.utils {

public class RegexLexer implements ILexer {
    private static var eating:int = 0;

    private var _charno:int;
    private var _lineno:int;
    private var _columnno:int;
    private var _input:String;
    private var _current:Token;
    private var _source_name:String;

    private var _rx:Vector.<RegExp>;
    private var _rules:Array;

    public function RegexLexer(source_name:String, input:String) {
        _lineno = 1;
        _charno = 0;
        _columnno = 1;
        _rules = new Array();

        _input = input;
        _source_name = source_name;
    }

    public function toString():String {
        var out:String = "RegexLexer:";
        out += "\nlineno      : " + _lineno;
        out += "\ncharno      : " + _charno;
        out += "\ncolumnno    : " + _columnno;
//			out += "\nrules       : " + _rules.toString();

        out += "\ninput       : " + _input;
        out += "\nsource_name : " + _source_name;
        return out;
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
        return _columnno;
    }

    public function get current():Token {
        return _current;
    }

    public function get sourceName():String {
        return _source_name;
    }

    public function addRule(name:String, pattern:String, type:int, callback:Function = null):void {
        var index:int;
        var subpatterns:int;
        var rule:LexerMatchRule;
        var last_rule:LexerMatchRule;

        if (_rules.length > 0) {
            last_rule = _rules[ ( _rules.length - 1) ];
            index = ( last_rule.index + last_rule.subpatterns + 1 );
        } else {
            index = 1;
        }

        subpatterns = countSubpatterns(pattern);

        rule = new LexerMatchRule();

        rule.type = type;
        rule.name = name;
        rule.index = index;
        rule.pattern = pattern;
        rule.subpatterns = subpatterns;
        rule.callback = callback;
        if (!(_rules.length % 30))
            rule.index = 1;

//			trace("rule index of " + rule.name + ": " + rule.index + "  subpattern: " + subpatterns);
        _rules.push(rule);
    }

    public function reset(input:String):void {
        _lineno = 1;
        _charno = 0;
        _columnno = 1;
        _input = input;
        _current = null;
        _rx = null;
    }

    public function next():Token {
        var token:Token;
        var match:Array = new Array;
        var matched:Object;
        var mi:int = -1;

//			trace(this);

        if (!_rx) {
            buildRegExp();
        }

        var m:RegExp;
        for each (m in _rx) {
            if (m.lastIndex >= _input.length) {
                token = new Token(Token.EOF, "$", _source_name, _charno, _lineno, _columnno);
                return token;
            }
        }

//				trace("lastIndex=" + _match_rx1.lastIndex + " " + (_match_rx2?_match_rx2.lastIndex:""));

        for each (m in _rx) {
            match.push(m.exec(_input));
        }


//				trace("lastIndex=" + _match_rx1.lastIndex + " " + (match2?_match_rx2.lastIndex:""));

        var nomatch:Boolean = true;
        for each (matched in match) {
            if (match && !match[ '_' ]) {
                nomatch = false;
                break;
            }
        }
        if (nomatch) {
            throw new Error("Unexpected character: " + _input.charAt(_charno) + " at " + _source_name + ":" + _lineno + ":" + _columnno);
        }

        for each(rule in _rules) {
            var i:int;
            var value:String;
            var subpatterns:Array;
            var rule:LexerMatchRule;
            var context:RegexLexerContext;

//				trace(rule.name + " :" + match1[ rule.name ] + ":");
            mi = 0;
            for each (matched in match) {
                if (matched [ rule.name ])
                    break;
                mi++;
            }

            // The rule was NOT hit.
            if (mi >= _rx.length)
                continue;

            for each (m in _rx)
                m.lastIndex = _rx[mi].lastIndex;


            if (match[mi][ rule.index ] == null) {
                throw new Error("Internal error: inconsistent match!");
            }

            value = match[mi][ rule.name ];
//						trace("RegexLexer: " + _input + ": " + rule.name + " " + value);
            subpatterns = new Array();

            for (i = 1; i <= rule.subpatterns; ++i) {
//					trace("subpattern.push: " + match[mi][ ( rule.index + i ) ] );
                subpatterns.push(match[mi][ ( rule.index + i ) ]);
            }

            token = new Token(rule.type, value, _source_name, _charno, _lineno, _columnno);

            if (rule.callback != null) {
                context = new RegexLexerContext();

                context.name = rule.name;
                context.lineno = _lineno;
                context.charno = _charno;
                context.columnno = _columnno;
                context.match = value;
                context.token = token;
                context.subpatterns = subpatterns;

                rule.callback(context);

                _charno += value.length;
                _columnno += value.length;

                if (_lineno != context.lineno) {
                    _columnno = 1;
                    _lineno = context.lineno;
                }

                token = context.token;

                if (context.skip || eating > 0) {
                    token = next();
                }
            }
            else {
                _charno += value.length;
                _columnno += value.length;
            }
            break;
        }

        if (!token) {
            throw new Error("Unexpected character: " + _input.charAt(match[0].index) + " at " + _source_name + ":" + _lineno + ":" + _columnno);
        }

        return token;
    }

    private function buildRegExp():void {
        var pattern:String;
        var rule:LexerMatchRule;
        var count:int;

        _rx = new Vector.<RegExp>;
        pattern = "";
        count = 0;

        for each(rule in _rules) {
            pattern += "(?P<" + rule.name + ">" + rule.pattern + ")|";
            count++;

            // For unknown reasons, the RegExp only groks 32 alternatives
            if (!(count % 30) || count == _rules.length) {
                _rx.push(new RegExp(pattern + "(?P<_>.)", "g"));
                pattern = "";
            }
        }
    }

    private function countSubpatterns(pattern:String):int {
        pattern = pattern.replace("\\(", "#");
        return ( pattern.split("(").length - 1 );
    }

    public static function SKIP(context:RegexLexerContext):void {
        context.token = null;
        context.skip = true;
    }

    public static function START_EAT(context:RegexLexerContext):void {
        ++eating;
        context.token;
    }

    public static function STOP_EAT(context:RegexLexerContext):void {
        --eating;

        context.token = null;
        context.skip = true;
    }

    public static function NL(context:RegexLexerContext):void {
        context.token = null;
        context.skip = true;
        context.lineno += 1;
    }
}
}

class LexerMatchRule {
    public var type:int;
    public var index:int;
    public var name:String;
    public var subpatterns:int;
    public var pattern:String;
    public var callback:Function;
}
