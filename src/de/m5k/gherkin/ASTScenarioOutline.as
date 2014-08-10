/**
 * Created by mklein on 10.08.14.
 */
package de.m5k.gherkin {
public class ASTScenarioOutline extends ASTScenario{

    private var _exampleslist:Vector.<ASTExamples>;

    public function ASTScenarioOutline(text:String, steps:Vector.<ASTStep>, astExampleses:Vector.<ASTExamples>) {
        super(text, steps);
        _exampleslist = astExampleses;
    }

    public function addExamples(examples:ASTExamples):void {
        _exampleslist.push(examples);
    }

    public function get examplesList():Vector.<ASTExamples> {
        return _exampleslist;
    }
}
}
