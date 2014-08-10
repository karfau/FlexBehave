/**
 * Created by mklein on 08.07.14.
 */
package de.m5k.bdd {
import de.m5k.gherkin.ASTStep;

public interface IReport {

    function failedStep(line:ASTStep, message:String):void;

    function successStep(line:ASTStep):void;
}
}
