package DAO;

import java.sql.*;
import java.util.*;
import connection.DBConnection;
import models.Booking;

public class BookingDAO {

    // Book a service
    public static boolean bookService(Booking booking) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO bookings (user_id, service_id) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, booking.getUser_id());
            ps.setInt(2, booking.getService_id());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Get all bookings made by a user
    public static List<Booking> getUserBookings(int userId) {
        List<Booking> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM bookings WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBooking_id(rs.getInt("booking_id"));
                booking.setUser_id(rs.getInt("user_id"));
                booking.setService_id(rs.getInt("service_id"));
                booking.setBooking_date(rs.getTimestamp("booking_date"));
                list.add(booking);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
     // Delete a booking by ID
    public static boolean deleteBooking(int bookingId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM bookings WHERE booking_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookingId);

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
