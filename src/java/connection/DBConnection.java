

package connection;

import java.sql.*;
public class DBConnection {
    static{                                                            //static block
        try{
           Class.forName("com.mysql.cj.jdbc.Driver");
           System.out.println("connection");
        }
        catch(Exception e){
            System.out.println(e);
        }
    }
    public static Connection getConnection(){                          //static class
        Connection con=null;
        try{
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pronest","root","root");
            
            return con;
        }
        catch(Exception e){
            System.out.println(e);
        }
        return con;
    }
}
