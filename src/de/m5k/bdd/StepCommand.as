/**
 * Created by mklein on 07.07.14.
 */
package de.m5k.bdd {

public class StepCommand {
    private var _target:Object;
    private var _method:String;
    private var _type:String;
    private var _pattern:RegExp;
    private var _parameterCount:int;


    public function get type():String {
        return _type;
    }

    public function StepCommand(target:Object, name:String, type:String, pattern:String, parameterCount:int) {
        _target = target;
        _method = name;
        _type = type;
        _pattern = new RegExp(pattern);
        _parameterCount = parameterCount;
    }

    public function test(cmd:String):Boolean {
        return _pattern.test(cmd);
    }

    public function run(cmd:String):void {
        _pattern.lastIndex =0;
        var match:Object = _pattern.exec(cmd);
        if (match == null) {
            throw new Error("pattern does not match. " + cmd + " " + _pattern.source);
        }

        match.shift();
        if (match.length != _parameterCount) {
            throw new Error("invalid parameter count " + match.length + " != " + _parameterCount);

        }
        _target[_method].apply(_target, match);
    }
}
}
