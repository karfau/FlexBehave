/**
 * Created by mklein on 07.08.14.
 */
package de.m5k.gherkin {
public class ASTFeature {
    private var _tags:Vector.<String>;
    private var _scenarios:Vector.<ASTScenario>;
    private var _background:ASTBackground;
    private var _description:String;
    public function ASTFeature(arg:*) {
    }

    public function get scenarios():Vector.<ASTScenario> {
        return _scenarios;
    }

    public function set scenarios(value:Vector.<ASTScenario>):void {
        _scenarios = value;
    }

    public function get tags():Vector.<String> {
        return _tags;
    }

    public function set tags(value:Vector.<String>):void {
        _tags = value;
    }

    public function get background():ASTBackground {
        return _background;
    }

    public function set background(value:ASTBackground):void {
        _background = value;
    }

    public function get description():String {
        return _description;
    }

    public function set description(value:String):void {
        _description = value;
    }
}
}
