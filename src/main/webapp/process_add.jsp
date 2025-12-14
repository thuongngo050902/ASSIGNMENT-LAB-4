<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.studentmanagement.util.DBUtil" %>

<%
    request.setCharacterEncoding("UTF-8");

    String code = request.getParameter("student_code");
    String name = request.getParameter("full_name");
    String email = request.getParameter("email");
    String major = request.getParameter("major");

    // Validate required
    if (code == null || code.trim().isEmpty() || name == null || name.trim().isEmpty()) {
        response.sendRedirect("add_student.jsp?error=Required fields missing");
        return;
    }

    // Optional: pattern check SV001 format
    if (!code.trim().matches("[A-Z]{2}[0-9]{3,}")) {
        response.sendRedirect("add_student.jsp?error=Invalid student code format (ex: SV001)");
        return;
    }

    // Email validation (optional)
    if (email != null && !email.trim().isEmpty()) {
        if (!email.trim().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            response.sendRedirect("add_student.jsp?error=Invalid email format");
            return;
        }
    } else {
        email = null;
    }

    if (major != null && major.trim().isEmpty()) major = null;

    String sql = "INSERT INTO students(student_code, full_name, email, major) VALUES(?, ?, ?, ?)";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, code.trim());
        ps.setString(2, name.trim());
        ps.setString(3, email);
        ps.setString(4, major);

        ps.executeUpdate();
        response.sendRedirect("list_students.jsp?msg=Student created successfully");
    } catch (SQLIntegrityConstraintViolationException dup) {
        response.sendRedirect("add_student.jsp?error=Student code already exists");
    } catch (Exception e) {
        response.sendRedirect("add_student.jsp?error=" + java.net.URLEncoder.encode("DB error: " + e.getMessage(), "UTF-8"));
    }
%>
