package fixtures;

import java.io.File;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;

/** Known-vulnerable benchmark cases. All secrets are synthetic. */
public class Vulnerable {

    // FX-BEGIN JV-V01
    public ResultSet findUser(Connection conn, String name) throws Exception {
        Statement stmt = conn.createStatement();
        return stmt.executeQuery("SELECT * FROM users WHERE name = '" + name + "'");
    }
    // FX-END JV-V01

    // FX-BEGIN JV-V02
    public Process ping(String host) throws Exception {
        return Runtime.getRuntime().exec("ping -c 1 " + host);
    }
    // FX-END JV-V02

    // FX-BEGIN JV-V03
    public Document parseXml(InputStream in) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        return dbf.newDocumentBuilder().parse(in);
    }
    // FX-END JV-V03

    // FX-BEGIN JV-V04
    public Object readState(InputStream in) throws Exception {
        ObjectInputStream ois = new ObjectInputStream(in);
        return ois.readObject();
    }
    // FX-END JV-V04

    // FX-BEGIN JV-V05
    public byte[] hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("MD5");
        return md.digest(password.getBytes("UTF-8"));
    }
    // FX-END JV-V05

    // FX-BEGIN JV-V06
    public String resetToken() {
        Random r = new Random();
        return Long.toHexString(r.nextLong());
    }
    // FX-END JV-V06

    // FX-BEGIN JV-V07
    public Connection connect() throws Exception {
        return DriverManager.getConnection("jdbc:postgresql://db/app", "app", "synthetic-JV-0000-not-real");
    }
    // FX-END JV-V07

    // FX-BEGIN JV-V08
    public File userFile(String name) {
        return new File("/srv/data/" + name);
    }
    // FX-END JV-V08
}
