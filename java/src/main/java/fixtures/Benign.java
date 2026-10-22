package fixtures;

import java.io.InputStream;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;

/** Benign lookalikes: same APIs as Vulnerable.java, used safely. */
public class Benign {

    // FX-BEGIN JV-B01
    public ResultSet findUser(Connection conn, String name) throws Exception {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE name = ?");
        ps.setString(1, name);
        return ps.executeQuery();
    }
    // FX-END JV-B01

    // FX-BEGIN JV-B02
    public Process listReports() throws Exception {
        return Runtime.getRuntime().exec(new String[] {"ls", "-l", "/srv/reports"});
    }
    // FX-END JV-B02

    // FX-BEGIN JV-B03
    public Document parseXml(InputStream in) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        return dbf.newDocumentBuilder().parse(in);
    }
    // FX-END JV-B03

    // FX-BEGIN JV-B04
    public byte[] checksum(byte[] data) throws Exception {
        return MessageDigest.getInstance("SHA-256").digest(data);
    }
    // FX-END JV-B04

    // FX-BEGIN JV-B05
    public String resetToken() {
        SecureRandom r = new SecureRandom();
        return Long.toHexString(r.nextLong());
    }
    // FX-END JV-B05

    // FX-BEGIN JV-B06
    public Connection connect() throws Exception {
        return DriverManager.getConnection("jdbc:postgresql://db/app", "app", System.getenv("DB_PASSWORD"));
    }
    // FX-END JV-B06
}
