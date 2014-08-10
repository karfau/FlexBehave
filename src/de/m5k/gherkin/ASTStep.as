/**
 * Created by mklein on 07.08.14.
 */
package de.m5k.gherkin {
public class ASTStep {
    private var _keyword:String;

    private var _text:String;

    public function ASTStep(keyword:String, text:String) {
        _keyword = keyword;
        _text = text;
    }

    public function get keyword():String {
        return _keyword;
    }

    public function get text():String {
        return _text;
    }

    public function toString():String {
        return "  "+String(_keyword) + " " + String(_text);
    }
}
}
