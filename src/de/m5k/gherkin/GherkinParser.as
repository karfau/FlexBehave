package de.m5k.gherkin {
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import it.sephiroth.scripting.utils.ILexer;
import it.sephiroth.scripting.utils.Token;

public class GherkinParser extends BaseParser {

    private var _token:Token;
    private var _lexer:ILexer;


    public static function parse(input:File):ASTFeature {

        var inputString:String;
        var stream:FileStream = new FileStream();
        stream.open(input, FileMode.READ);
        inputString = stream.readUTFBytes(stream.bytesAvailable);
        stream.close();

        var lexer:GherkinLexer = new GherkinLexer(input.name, inputString);
        var parser:GherkinParser = new GherkinParser();
        parser.lexer = lexer;
        parser.set_yydebug(true);
        parser.yyparse();
//				trace("result: " + val_peek(0));
        var result:ASTFeature = parser.val_peek(0);

        return result;
    }

    public function set lexer(lexer:ILexer):void {
        _lexer = lexer;
    }

    override public function yylex():int {
        var value:Token = _lexer.next();

        if (value == null || value.type == Token.EOF) {
            return 0;
        }

        set_yylval(value.value);

        _token = value;

        return value.type;
    }

    override public function yyerror(msg:String):void {
        if (_token == null) {
            throw new Error(msg+ "Unknown location of input [" + _lexer.input + "]");
        } else {
            throw new Error(msg +" "+_token.positionString+ " "+_token.type);
        }
    }


}
}
