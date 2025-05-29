package DAO;

import java.sql.*;
import java.util.*;
import models.User;
import models.Provider;
import connection.DBConnection;
import models.Service;

public class ProviderDAO {

    // Add a new provider
    public int registerProvider(Provider p) {
        int n = 0;
        try {
            Connection con = null;
            PreparedStatement ps = null;
            con = DBConnection.getConnection();
            String sql = "INSERT INTO Providers (name, email, password, phone, aadhar) VALUES (?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, p.getName());
            ps.setString(2, p.getEmail());
            ps.setString(3, p.getPassword());
            ps.setString(4, p.getPhone());
            ps.setString(5, p.getAadhar());

            n = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }
        return n;
    }

    // Login provider
    public boolean Providerlogin(String email, String password) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM providers WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update provider profile
    public static boolean updateProvider(Provider p) {
        try {
            Connection con = null;
            con = DBConnection.getConnection();
            String sql = "UPDATE providers SET name = ?, password = ?, phone = ?, aadhar = ? WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, p.getName());
            ps.setString(2, p.getPassword());
            ps.setString(3, p.getPhone());
            ps.setString(4, p.getAadhar());
            ps.setString(5, p.getEmail());

            if (ps.executeUpdate() > 0) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete provider account
    public static boolean deleteProvider(int provider_id) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM providers WHERE provider_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, provider_id);

            if (ps.executeUpdate() > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Provider getProviderByEmailAndPassword(String email, String password) {
        Provider provider = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM providers WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Provider(
                        rs.getInt("provider_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("aadhar")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return provider;
    }

    // Get provider by ID
    public static Provider getProviderById(int providerId) {
        String sql = "SELECT * FROM providers WHERE provider_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, providerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Provider(
                        rs.getInt("provider_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("aadhar")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all providers (optional, admin feature)
    public static List<Provider> getAllProviders() {
        List<Provider> providers = new ArrayList<>();
        String query = "SELECT * FROM providers";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {
            
            while (rs.next()) {
                Provider provider = new Provider(
                    rs.getInt("provider_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("phone"),
                    rs.getString("aadhar")
                );
                providers.add(provider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return providers;
    }
    
    public static int getTotalProviders() {
    int count = 0;
    try (Connection con = DBConnection.getConnection();
         Statement stmt = con.createStatement();
         ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM providers")) {
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}


}
