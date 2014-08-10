/**
 * Created by mklein on 10.08.14.
 */
package de.m5k.gherkin {
public class ASTExamples {
    private var _tables:ASTTable;
    private var _text:String;

    public function ASTExamples(text:String, tables:ASTTable) {
        _text = text;
        _tables = tables;
    }


    public function get tables():ASTTable {
        return _tables;
    }

    public function get text():String {
        return _text;
    }
}
}
