package {
import de.m5k.gherkin.GherkinLexer;
import de.m5k.gherkin.Tokens;

import it.sephiroth.scripting.utils.Token;

import org.flexunit.Assert;

public class TestLexer {
    static const input:String =
            "Feature: calculator\n"+
            "  Scenario: addition\n"+
            "\n"+
            "    Given a simple calculator\n"+
            "    When 7 was pressed\n"+
            "    And + was pressed\n"+
            "    And 3 was pressed\n"+
            "    And result was pressed\n"+
            "    Then we got 10\n\n";

    [Test]
    public function testEOF() {
        var lexer:GherkinLexer = new GherkinLexer("calculator.feature", input);
        for(var i:int=1000;i>0;i--){

            var token:Token = lexer.next();
            Assert.assertNotNull(token);
            if(token.type == Token.EOF){
                return;
            }
        }
        Assert.fail("eof not reached");

    }

    [Test]
    public function testLineTokenizer() {
        var lexer:GherkinLexer = new GherkinLexer("calculator.feature", input);
        Assert.assertEquals("Feature: calculator", lexer.nextLine());
        Assert.assertEquals(1, lexer.lineno);
        Assert.assertEquals("  Scenario: addition", lexer.nextLine());
        Assert.assertEquals(2, lexer.lineno);
        Assert.assertEquals("", lexer.nextLine());
        Assert.assertEquals(3, lexer.lineno);
        Assert.assertEquals("    Given a simple calculator", lexer.nextLine());
        Assert.assertEquals(4, lexer.lineno);
        Assert.assertEquals("    When 7 was pressed", lexer.nextLine());
        Assert.assertEquals("    And + was pressed", lexer.nextLine());
        Assert.assertEquals("    And 3 was pressed", lexer.nextLine());
        Assert.assertEquals("    And result was pressed", lexer.nextLine());
        Assert.assertEquals("    Then we got 10", lexer.nextLine());
        Assert.assertEquals("", lexer.nextLine());

        Assert.assertNull(lexer.nextLine());


    }

    [Test]
    public function testTokenTypes() {
        var lexer:GherkinLexer = new GherkinLexer("calculator.feature", input);

        var token:Token;
        token = lexer.next();
        Assert.assertEquals(token.lineno+":FEATURE ", Tokens.FEATURE, token.type);
        token = lexer.next();
        Assert.assertEquals(token.lineno+":SCENARIO ", Tokens.SCENARIO, token.type);


    }



}
}
