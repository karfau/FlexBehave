/**
 * Created by mklein on 07.07.14.
 */
package de.kleinplanet.as3 {


public class DemoScene {
    public function DemoScene() {
    }

    [Given('the exercise ([^\\s]+)')]
    public function givenExercise(exercise:String):void {
        trace("OKAY: given the exercise", exercise);

    }
    [When('start the practice')]
    public function whenStart():void {
        trace("when OKAY");
    }

    [Then('view input')]
    public function thenInput():void {
        trace("then OKAY");
    }
}
}
