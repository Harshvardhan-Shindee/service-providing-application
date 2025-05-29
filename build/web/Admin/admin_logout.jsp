<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Session ko invalidate karo
    session.invalidate();

    // Login page ya home page pe redirect karo
    response.sendRedirect(request.getContextPath() + "/index.jsp");
%>
