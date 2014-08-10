/**
 * Created by mklein on 08.07.14.
 */
package de.m5k.bdd {
import de.m5k.gherkin.ASTStep;

public class ReportCollection implements IReport {
    private var list:Vector.<IReport> = new <IReport>[];
    public function ReportCollection() {
    }

    public function failedStep(line:ASTStep, message:String):void {
        for each (var report:IReport in list) {
            report.failedStep(line, message);
        }
    }

    public function addReporter(reporter:IReport):void {
        list.push(reporter);
    }

    public function successStep(line:ASTStep):void {
        for each (var report:IReport in list) {
            report.successStep(line);
        }
    }
}
}
