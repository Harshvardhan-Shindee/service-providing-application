package DAO;

import java.sql.*;
import java.util.*;
import models.WorkRequest;
import connection.DBConnection;

public class WorkRequestDAO {

    // Create a new work request
    public static boolean createRequest(WorkRequest wr) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO work_requests(user_id, provider_id, service_id, status) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, wr.getUser_id());
            ps.setInt(2, wr.getProvider_id());
            ps.setInt(3, wr.getService_id());
            ps.setString(4, wr.getStatus());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Get all pending requests for a provider
    public static List<WorkRequest> getPendingWorksByService(int providerId, int serviceId) {
        List<WorkRequest> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM work_requests WHERE provider_id=? AND service_id=? AND status='Pending'";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, providerId);
            ps.setInt(2, serviceId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WorkRequest w = new WorkRequest();
                w.setRequest_id(rs.getInt("request_id"));
                w.setProvider_id(rs.getInt("provider_id"));
                w.setService_id(rs.getInt("service_id"));
                w.setUser_id(rs.getInt("user_id"));
                w.setStatus(rs.getString("status"));
                list.add(w);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<WorkRequest> getPendingWorks(int providerId) {
        List<WorkRequest> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM work_requests WHERE provider_id = ? AND status = 'Pending'";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, providerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WorkRequest wr = new WorkRequest();
                wr.setRequest_id(rs.getInt("request_id"));
                wr.setUser_id(rs.getInt("user_id"));
                wr.setProvider_id(rs.getInt("provider_id"));
                wr.setService_id(rs.getInt("service_id"));
                wr.setStatus(rs.getString("status"));
                wr.setRequest_date(rs.getTimestamp("request_date"));

                list.add(wr);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Mark a work request as completed
    public static boolean markAsCompleted(int requestId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE work_requests SET status='Completed' WHERE request_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, requestId);

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Get all completed work for a provider
    public static List<WorkRequest> getCompletedWorks(int providerId) {
        List<WorkRequest> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM work_requests WHERE provider_id=? AND status='Completed'";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, providerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WorkRequest wr = new WorkRequest();
                wr.setRequest_id(rs.getInt("request_id"));
                wr.setUser_id(rs.getInt("user_id"));
                wr.setProvider_id(rs.getInt("provider_id"));
                wr.setService_id(rs.getInt("service_id"));
                wr.setStatus(rs.getString("status"));
                wr.setRequest_date(rs.getTimestamp("request_date"));
                list.add(wr);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static double getTotalEarnings(int provider_id) {
        double total = 0.0;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT SUM(s.price) AS total_earning "
                    + "FROM work_requests wr "
                    + "JOIN services s ON wr.service_id = s.service_id "
                    + "WHERE wr.provider_id = ? AND wr.status = 'Completed'";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, provider_id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total_earning");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Get all work requests by user
    public static List<WorkRequest> getUserRequests(int userId) {
        List<WorkRequest> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM work_requests WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WorkRequest wr = new WorkRequest();
                wr.setRequest_id(rs.getInt("request_id"));
                wr.setService_id(rs.getInt("service_id"));
                wr.setUser_id(rs.getInt("user_id"));
                wr.setProvider_id(rs.getInt("provider_id"));
                wr.setStatus(rs.getString("status"));
                list.add(wr);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cancel a work request (only if still pending)
    public static boolean cancelRequest(int requestId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM work_requests WHERE request_id=? AND status='Pending'";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, requestId);

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    //for admin pannel
    public static int getTotalPendingWorks() {
        int count = 0;
        try (Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM work_requests WHERE status = 'pending'")) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public static int getTotalCompletedWorks() {
        int count = 0;
        try (Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM work_requests WHERE status = 'completed'")) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public static List<WorkRequest> getPendingWorkByUser(int userId) {
        List<WorkRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM work_requests WHERE user_id = ? AND status = 'pending'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WorkRequest wr = new WorkRequest();
                wr.setRequest_id(rs.getInt("request_id"));
                wr.setService_id(rs.getInt("service_id"));
                wr.setUser_id(rs.getInt("user_id"));
                wr.setProvider_id(rs.getInt("provider_id"));
                wr.setStatus(rs.getString("status"));
                list.add(wr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Get pending work by provider
public static List<WorkRequest> getPendingWorkByProvider(int provider_id) {
    List<WorkRequest> list = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT * FROM work_requests WHERE provider_id=? AND status='pending'")) {

        ps.setInt(1, provider_id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            WorkRequest wr = new WorkRequest();
                wr.setRequest_id(rs.getInt("request_id"));
                wr.setService_id(rs.getInt("service_id"));
                wr.setUser_id(rs.getInt("user_id"));
                wr.setProvider_id(rs.getInt("provider_id"));
                wr.setStatus(rs.getString("status"));
                list.add(wr);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    // Get completed work by provider
    public static List<WorkRequest> getCompletedWorkByProvider(int provider_id) {
        List<WorkRequest> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM work_requests WHERE provider_id=? AND status='completed'")) {

            ps.setInt(1, provider_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WorkRequest wr = new WorkRequest();
                wr.setRequest_id(rs.getInt("request_id"));
                wr.setService_id(rs.getInt("service_id"));
                wr.setUser_id(rs.getInt("user_id"));
                wr.setProvider_id(rs.getInt("provider_id"));
                wr.setStatus(rs.getString("status"));
                list.add(wr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
     // Get all pending works
    public static List<WorkRequest> getAllPendingWorks() {
        List<WorkRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM work_requests WHERE status = 'pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                WorkRequest wr = new WorkRequest();
                wr.setRequest_id(rs.getInt("request_id"));
                wr.setService_id(rs.getInt("service_id"));
                wr.setUser_id(rs.getInt("user_id"));
                wr.setProvider_id(rs.getInt("provider_id"));
                wr.setStatus(rs.getString("status"));
                wr.setRequest_date(rs.getTimestamp("request_date"));
                list.add(wr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get all completed works
    public static List<WorkRequest> getAllCompletedWorks() {
        List<WorkRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM work_requests WHERE status = 'completed'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                WorkRequest wr = new WorkRequest();
                wr.setRequest_id(rs.getInt("request_id"));
                wr.setService_id(rs.getInt("service_id"));
                wr.setUser_id(rs.getInt("user_id"));
                wr.setProvider_id(rs.getInt("provider_id"));
                wr.setStatus(rs.getString("status"));
                wr.setRequest_date(rs.getTimestamp("request_date"));
                list.add(wr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}
