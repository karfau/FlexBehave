/**
 * Created by mklein on 07.08.14.
 */
package de.m5k.gherkin {
public class ASTBackground {
    private var _steps:Vector.<ASTStep>;

    public function ASTBackground(text:String) {
        var list:Vector.<int> = new <int>[];
    }

    public function get steps():Vector.<ASTStep> {
        return _steps;
    }

    public function set steps(value:Vector.<ASTStep>):void {
        _steps = value;
    }
}
}
