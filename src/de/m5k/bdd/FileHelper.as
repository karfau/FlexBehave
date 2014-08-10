/**
 * Created by mklein on 08.07.14.
 */
package de.m5k.bdd {
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class FileHelper {

    public static function loadFile(url:String):String {
        var file:File = new File(url);
        var stream:FileStream = new FileStream();
        stream.open(file, FileMode.READ);
        var str:String = stream.readUTFBytes(stream.bytesAvailable);
        stream.close();
        return str;
    }
}
}
