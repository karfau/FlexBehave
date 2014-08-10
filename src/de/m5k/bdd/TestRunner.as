/**
 * Created by mklein on 08.07.14.
 */
package de.m5k.bdd {
import de.m5k.gherkin.ASTFeature;
import de.m5k.gherkin.ASTScenario;
import de.m5k.gherkin.ASTStep;

import flash.utils.describeType;

public class TestRunner {
    private var tasks:Vector.<StepCommand> = new Vector.<StepCommand>();
    private var report:ReportCollection = new ReportCollection();

    public function TestRunner() {
    }

    public function runFeatureTest(test:ASTFeature):void {
        for each (var scenario:ASTScenario in test.scenarios) {
            for each (var step:ASTStep in scenario.steps) {
                try {
                    findCommand(step).run(step.text);
                    report.successStep(step);
                } catch (e:Error) {
                    report.failedStep(step, e.message);
                }
            }
        }

    }

    private function findCommand(line:ASTStep):StepCommand {
        for each (var command:StepCommand in tasks) {
            if (command.test(line.text)) {
                return command
            }
        }
        throw new Error("undefined test line: " + line);
    }

    public function addScene(demoScene:Object):void {
        var xDesc:XML = describeType(demoScene);
        //trace(xDesc);
        for each (var method:XML in xDesc.method) {

            var parameters:int = method.parameter.length();
            for each (var metadata:XML in method.metadata) {
                var metaName:String = metadata.@name;
                if (metaName == 'Given' || metaName == 'When' || metaName == 'Then') {
                    var pattern:XMLList = metadata.arg.@value;
                    if (pattern.length() != 1) {
                        throw Error('unsupported test case ' + metadata)
                    }
                    tasks.push(new StepCommand(demoScene, method.@name, metaName, pattern[0], parameters));
                }
            }
        }
    }

    public static function instance():TestRunner {
        return new TestRunner();
    }

    public function addReporter(reporter:IReport):void {
        report.addReporter(reporter);
    }
}
}
