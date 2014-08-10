/**
 * Created by mklein on 07.08.14.
 */
package de.m5k.gherkin {
public class ASTScenario {
    private var _text:String;
    private var _steps:Vector.<ASTStep>;
    private var _tags:Vector.<String>;

    public function ASTScenario(text:String, steps:Vector.<ASTStep>, tags:Vector.<String>=null) {
        _text = text;
        _steps = steps;
        _tags = tags;
    }


    public function set tags(tags:Vector.<String>):void {
        _tags = tags;
    }

    public function get text():String {
        return _text;
    }

    public function get steps():Vector.<ASTStep> {
        return _steps;
    }

    public function get tags():Vector.<String> {
        return _tags;
    }
}
}
