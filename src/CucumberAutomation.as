/**
 * Created by mklein on 07.07.14.
 */
package {

import de.m5k.automation.AutomationManager;
import de.m5k.bdd.TestRunner;

import flash.display.DisplayObject;
import flash.utils.describeType;

import mx.automation.Automation;

//-keep-as3-metadata+=When,Then,Given

[Mixin]
public class CucumberAutomation {

    private static const TEST:String =
            "#test\n" +
            "Given the exercise TEST.AT1\n" +
            "When we start the practice\n" +
            "Then we view input\n";


    public static function init(systemManager:DisplayObject):void {
//			Automation.errorShown = true;
        if (!Automation.initialized) {
            mx.automation.AutomationManager.init(systemManager);
        }
        Automation.automationManager = new de.m5k.automation.AutomationManager(systemManager);
        //Automation.automationDebugTracer.traceMessage("AutomationIncludes", "init()", "AUTOMATION INITIALIZED");

        // For ApacheFlex there are no licenscing restrictions for FlashBuilder.
        Automation.restrictionNeeded = false;
//
//        var cucumber:CucumberTestRunner = new CucumberTestRunner();
//        cucumber.addScene(new DemoScene());
//
//        cucumber.runFeatureTest(TEST);

    }

//
//    private static function addSceneClass(demoScene:Object):void {
//        var xDesc:XML = describeType(demoScene.constructor);
//        trace("class", xDesc);
//        var xMetas:XMLList = xDesc.factory.metadata;
//
//        trace("class", xMetas);
//    }
}
}
