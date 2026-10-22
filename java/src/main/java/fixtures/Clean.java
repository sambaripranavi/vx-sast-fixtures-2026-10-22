// FX-BEGIN JV-C01
package fixtures;

/** Clean control: no security-relevant behaviour. */
public class Clean {
    public int add(int a, int b) {
        return a + b;
    }

    public String greet(String name) {
        return "Hello, " + name;
    }
}
// FX-END JV-C01
