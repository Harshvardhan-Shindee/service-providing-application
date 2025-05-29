<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Session ko invalidate karo
    session.invalidate();
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Login page ya home page pe redirect karo
    response.sendRedirect(request.getContextPath() + "/index.jsp");
%>
