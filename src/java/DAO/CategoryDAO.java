package DAO;

import java.sql.*;
import java.util.*;
import models.Category;
import connection.DBConnection;

public class CategoryDAO {

    public static List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM category";  // ✅ Correct table name

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setCategory_id(rs.getInt("category_id")); // Make sure this field exists
                category.setCategory(rs.getString("category"));     // Ensure this is the actual column name
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }
}
