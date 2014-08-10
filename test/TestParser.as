/**
 * Created by mklein on 08.08.14.
 */
package {
import de.m5k.gherkin.ASTFeature;
import de.m5k.gherkin.GherkinParser;

import flash.filesystem.File;

import org.flexunit.Assert;

public class TestParser {
    [Test]
    public function parser() {
        var feature:ASTFeature = GherkinParser.parse(new File("app:/calculator.feature"));
        Assert.assertNotNull(feature);
        Assert.assertNotNull(feature.background);
        Assert.assertNull(feature.description);
        Assert.assertEquals(2, feature.scenarios.length);
        Assert.assertEquals(" addition", feature.scenarios[0].text);
        Assert.assertEquals(6, feature.scenarios[0].steps.length);
    }
}
}
