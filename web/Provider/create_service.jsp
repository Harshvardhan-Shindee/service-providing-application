<%@ page import="DAO.ServiceDAO, DAO.CategoryDAO" %>
<%@ page import="models.Service, models.Category, models.Provider" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%
    Provider provider = (Provider) session.getAttribute("provider");
    if (provider == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/plogin/providerlogin.jsp");
        return;
    }

    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        Service service = new Service();
        service.setCategory(category);
        service.setDescription(description);
        service.setPrice(price);
        service.setProvider_id(provider.getProvider_id());

        if (ServiceDAO.addService(service)) {
            out.println("<script>alert('Service added successfully!');</script>");
        } else {
            out.println("<script>alert('Failed to add service.');</script>");
        }
    }

    // Load categories
    List<Category> categories = CategoryDAO.getAllCategories();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New Service</title>
    <style>
        .form-container {
            max-width: 500px;
            margin: 40px auto;
            padding: 30px;
            background: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }

        .form-container label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        .form-container input,
        .form-container textarea,
        .form-container select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .form-container button {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<jsp:include page="headerp.jsp" />

<div class="form-container">
    <h2>Create New Service</h2>

    <form method="post">
        <label>Service Category</label>
        <select name="category" required>
            <option value="">-- Select Category --</option>
            <% if (categories != null && !categories.isEmpty()) {
                for (Category cat : categories) { %>
                    <option value="<%= cat.getCategory() %>"><%= cat.getCategory() %></option>
            <%  } 
               } else { %>
                    <option disabled>No categories available</option>
            <% } %>
        </select>

        <label>Description</label>
        <textarea name="description" rows="4" required></textarea>

        <label>Price (INR)</label>
        <input type="number" name="price" step="0.01" required>

        <button type="submit">Add Service</button>
    </form>
</div>

</body>
</html>
