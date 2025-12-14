<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.studentmanagement.util.DBUtil" %>

<%
    String idParam = request.getParameter("id");
    int id = -1;

    try {
        id = Integer.parseInt(idParam);
    } catch (Exception e) {
        response.sendRedirect("list_students.jsp?error=Invalid ID");
        return;
    }

    String sql = "DELETE FROM students WHERE id = ?";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, id);
        int deleted = ps.executeUpdate();

        if (deleted == 0) {
            response.sendRedirect("list_students.jsp?error=Student not found");
        } else {
            response.sendRedirect("list_students.jsp?msg=Student deleted successfully");
        }
    } catch (Exception e) {
        response.sendRedirect("list_students.jsp?error=" + java.net.URLEncoder.encode("DB error: " + e.getMessage(), "UTF-8"));
    }
%>
