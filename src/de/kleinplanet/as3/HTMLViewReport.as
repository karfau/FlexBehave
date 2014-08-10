/**
 * Created by mklein on 08.07.14.
 */
package de.kleinplanet.as3 {

import de.m5k.bdd.IReport;
import de.m5k.gherkin.ASTStep;

import flash.text.engine.FontPosture;

import flashx.textLayout.elements.DivElement;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.SpanElement;
import flashx.textLayout.elements.TextFlow;

import spark.components.TextArea;

public class HTMLViewReport implements IReport {
    private var _textArea:TextArea;
    private const RED:String = "#FF3000";
    private const BLUE:String = "#0000FF";

    private var _textFlow:TextFlow;

    public function HTMLViewReport(textArea:TextArea) {
        _textArea = textArea;
        _textArea.textFlow = _textFlow  = new TextFlow();
        //_textFlow.flowComposer = new StandardFlowComposer();
        //var firstController:ContainerController = new ContainerController(_textArea, 200, 200 );
        //_textFlow.flowComposer.addController(firstController);
    }

    public function failedStep(line:ASTStep, message:String):void {
        addLine(RED, line+" # "+message);
    }

    private var _text:String = "";

    private function addLine(color:String, line:String):void {
        _text += "<font color='"+color+"'>"+line+"</font><br/>";
        //var firstContainer:Sprite = new Sprite();


        // create a DivElement that sets some formatting attributes
        var div:DivElement = new DivElement();
        div.fontSize = 14;
        div.color = color;
        div.fontStyle = FontPosture.NORMAL;
        div.textIndent = 15;

        // create two paragraphs that inherit formatting from the DivElement
        var paragraph1:ParagraphElement = new ParagraphElement();
        var p1Span1:SpanElement = new SpanElement();
        p1Span1.text = line;
//        var p1Span2:SpanElement = new SpanElement();
//        p1Span2.text = "The quick red fox jumped over the lazy brown dog.";
//        // specify lineThrough for this span only
//        p1Span2.lineThrough = true;
        paragraph1.addChild(p1Span1);
//        paragraph1.addChild(p1Span2);
//        var paragraph2:ParagraphElement = new ParagraphElement();
//        var p2Span1:SpanElement = new SpanElement();
//        p2Span1.text = "Peter Piper picked a peck of pickle peppers.";
//        paragraph2.addChild(p2Span1);
//
//        // add the two paragraphs to the DivElement
        div.addChild(paragraph1);
//        div.addChild(p1Span1);
        //div.text

        // add the DivElement to the TextFlow, add a composer, and update the controller
        // to display the text flow
        _textFlow.addChild(div);
        _textFlow.flowComposer.updateAllControllers();

    }

    public function successStep(line:ASTStep):void {
        addLine(BLUE, line.toString());
    }
}
}
