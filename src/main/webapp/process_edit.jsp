<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.studentmanagement.util.DBUtil" %>

<%
    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("id");
    String name = request.getParameter("full_name");
    String email = request.getParameter("email");
    String major = request.getParameter("major");

    int id = -1;
    try {
        id = Integer.parseInt(idParam);
    } catch (Exception e) {
        response.sendRedirect("list_students.jsp?error=Invalid ID");
        return;
    }

    if (name == null || name.trim().isEmpty()) {
        response.sendRedirect("edit_student.jsp?id=" + id + "&error=Required field missing");
        return;
    }

    if (email != null && !email.trim().isEmpty()) {
        if (!email.trim().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            response.sendRedirect("edit_student.jsp?id=" + id + "&error=Invalid email format");
            return;
        }
    } else {
        email = null;
    }

    if (major != null && major.trim().isEmpty()) major = null;

    String sql = "UPDATE students SET full_name=?, email=?, major=? WHERE id=?";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, name.trim());
        ps.setString(2, email);
        ps.setString(3, major);
        ps.setInt(4, id);

        int updated = ps.executeUpdate();
        if (updated == 0) {
            response.sendRedirect("edit_student.jsp?id=" + id + "&error=Student not found");
        } else {
            response.sendRedirect("list_students.jsp?msg=Student updated successfully");
        }
    } catch (Exception e) {
        response.sendRedirect("edit_student.jsp?id=" + id + "&error=" + java.net.URLEncoder.encode("DB error: " + e.getMessage(), "UTF-8"));
    }
%>
