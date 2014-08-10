/**
 * Created by mklein on 10.08.14.
 */
package de.m5k.gherkin {



public class ASTTable {
    private var _header:Vector.<String>;
    private var _columns:Vector.<Vector.<String>>;

    public function ASTTable(header:Vector.<String>) {
        _header = header;
        _columns = new Vector.<Vector.<String>>();
    }

    public function addRow(row:Vector.<String>):void{
        if(row.length != _header.length){
            throw new Error("");
        }
        _columns.push(row);
    }
}
}
