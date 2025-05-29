package DAO;

import java.sql.*;
import java.util.*;
import models.Service;
import DAO.CategoryDAO;
import connection.DBConnection;

public class ServiceDAO {

    // Add a new service
    public static boolean addService(Service s) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO services(category, description, price, provider_id) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, s.getCategory());
            ps.setString(2, s.getDescription());
            ps.setDouble(3, s.getPrice());
            ps.setInt(4, s.getProvider_id());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Get all services
    public static List<Service> getAllServices() {
        List<Service> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM services";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setService_id(rs.getInt("service_id"));
                service.setCategory(rs.getString("category"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getDouble("price"));
                service.setProvider_id(rs.getInt("provider_id"));
                list.add(service);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get service by ID
    public static Service getServiceById(int serviceId) {
        Service service = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM services WHERE service_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                service = new Service();
                service.setService_id(rs.getInt("service_id"));
                service.setCategory(rs.getString("Category"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getDouble("price"));
                service.setProvider_id(rs.getInt("provider_id"));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return service;
    }

    // Get all services by a specific provider
    public static List<Service> getServicesByProvider(int providerId) {
        List<Service> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM services WHERE provider_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, providerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setService_id(rs.getInt("service_id"));
                service.setCategory(rs.getString("category"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getDouble("price"));
                service.setProvider_id(rs.getInt("provider_id"));
                list.add(service);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete service by ID (also delete related work requests)
    public static boolean deleteService(int serviceId) {
        boolean status = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            // Step 1: Delete related bookings first (since there's a foreign key constraint)
            String deleteBookings = "DELETE FROM bookings WHERE service_id=?";
            ps = con.prepareStatement(deleteBookings);
            ps.setInt(1, serviceId);
            ps.executeUpdate();
            ps.close(); // Close after execution

            // Step 2: Delete related work requests
            String deleteWorkRequests = "DELETE FROM work_requests WHERE service_id=?";
            ps = con.prepareStatement(deleteWorkRequests);
            ps.setInt(1, serviceId);
            ps.executeUpdate();
            ps.close(); // Close after execution

            // Step 3: Delete the service
            String deleteService = "DELETE FROM services WHERE service_id=?";
            ps = con.prepareStatement(deleteService);
            ps.setInt(1, serviceId);
            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
            }
        }

        return status;
    }

    public static List<Service> getServicesByCategory(String category) {
        List<Service> services = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT s.*, p.name AS provider_name FROM services s JOIN providers p ON s.provider_id = p.provider_id WHERE s.category = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, category);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Service service = new Service(); // default constructor
                service.setService_id(rs.getInt("service_id"));
                service.setProvider_id(rs.getInt("provider_id"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getDouble("price"));
                service.setCategory(rs.getString("category"));
                service.setProviderName(rs.getString("provider_name"));
//            service.setLocation(rs.getString("location"));

                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException e) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }

        return services;
    }

    public static int getServiceCountByProvider(int providerId) {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM services WHERE provider_id = ?")) {
            stmt.setInt(1, providerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

}
