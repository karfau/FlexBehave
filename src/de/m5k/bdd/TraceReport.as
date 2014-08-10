/**
 * Created by mklein on 08.07.14.
 */
package de.m5k.bdd {
import de.m5k.gherkin.ASTStep;

public class TraceReport implements IReport {
    public function TraceReport() {
    }

    public function failedStep(line:ASTStep, message:String):void {
        trace("RED: "+line +" \t# "+message);
    }

    public function successStep(line:ASTStep):void {
        trace("grn: "+line );
    }
}
}
