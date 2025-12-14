<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.studentmanagement.util.DBUtil" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <style>
        body { font-family: Arial; margin: 24px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background: #f3f3f3; text-align: left; }
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .message { padding: 10px; margin: 10px 0; border-radius: 6px; }
        .success { background: #e7f7ee; border: 1px solid #bfe6cf; }
        .error { background: #fde8e8; border: 1px solid #f5b5b5; }
        .delete-link { color: red; }
        .actions a { margin-right: 10px; }
        .search { margin: 10px 0 18px; }
        input[type="text"] { padding: 6px; width: 260px; }
        button { padding: 6px 12px; }
    </style>
</head>
<body>

<div class="topbar">
    <h2>Student Management</h2>
    <a href="add_student.jsp">+ Add Student</a>
</div>

<%
    String msg = request.getParameter("msg");
    String err = request.getParameter("error");
    if (msg != null && !msg.trim().isEmpty()) {
%>
    <div class="message success">✓ <%= msg %></div>
<% } %>
<%
    if (err != null && !err.trim().isEmpty()) {
%>
    <div class="message error">✗ <%= err %></div>
<% } %>

<!-- SEARCH (homework) -->
<form class="search" action="list_students.jsp" method="GET">
    <input type="text" name="keyword" placeholder="Search by name or code..."
           value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
    <button type="submit">Search</button>
    <a href="list_students.jsp">Clear</a>
</form>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Student Code</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Major</th>
        <th>Created At</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
<%
    String keyword = request.getParameter("keyword");
    String sql;
    boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());

    if (hasKeyword) {
        sql = "SELECT * FROM students WHERE full_name LIKE ? OR student_code LIKE ? ORDER BY id DESC";
    } else {
        sql = "SELECT * FROM students ORDER BY id DESC";
    }

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        if (hasKeyword) {
            ps.setString(1, "%" + keyword.trim() + "%");
            ps.setString(2, "%" + keyword.trim() + "%");
        }

        try (ResultSet rs = ps.executeQuery()) {
            boolean hasAny = false;
            while (rs.next()) {
                hasAny = true;
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("student_code") %></td>
            <td><%= rs.getString("full_name") %></td>
            <td><%= rs.getString("email") != null ? rs.getString("email") : "" %></td>
            <td><%= rs.getString("major") != null ? rs.getString("major") : "" %></td>
            <td><%= rs.getTimestamp("created_at") %></td>
            <td class="actions">
                <a href="edit_student.jsp?id=<%= rs.getInt("id") %>">Edit</a>
                <a class="delete-link"
                   href="delete_student.jsp?id=<%= rs.getInt("id") %>"
                   onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
            </td>
        </tr>
<%
            }
            if (!hasAny) {
%>
        <tr><td colspan="7">No students found.</td></tr>
<%
            }
        }
    } catch (Exception e) {
%>
        <tr>
            <td colspan="7">
                <div class="message error">✗ DB error: <%= e.getMessage() %></div>
            </td>
        </tr>
<%
    }
%>
    </tbody>
</table>

<script>
    setTimeout(function() {
        document.querySelectorAll('.message').forEach(function(msg) {
            msg.style.display = 'none';
        });
    }, 3000);
</script>

</body>
</html>
