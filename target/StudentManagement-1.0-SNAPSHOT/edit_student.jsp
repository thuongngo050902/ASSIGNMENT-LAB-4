<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.studentmanagement.util.DBUtil" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        label { display:block; margin: 10px 0 6px; }
        input { width: 360px; padding: 8px; }
        .row { margin-top: 14px; }
        button { padding: 8px 14px; }
        .message { padding: 10px; margin: 10px 0; border-radius: 6px; background: #fff5f5; border: 1px solid #feb2b2; }
    </style>
</head>
<body>

<h2>Edit Student</h2>

<%
    String err = request.getParameter("error");
    if (err != null && !err.trim().isEmpty()) {
%>
    <div class="message"><%= err %></div>
<%
    }

    String idParam = request.getParameter("id");
    int id = -1;
    try {
        id = Integer.parseInt(idParam);
    } catch (Exception ex) {
%>
    <div class="message">Invalid ID</div>
</body></html>
<%
        return;
    }

    String code = null, name = null, email = null, major = null;

    String sql = "SELECT * FROM students WHERE id = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (!rs.next()) {
%>
    <div class="message">Student not found</div>
</body></html>
<%
                return;
            }
            code = rs.getString("student_code");
            name = rs.getString("full_name");
            email = rs.getString("email");
            major = rs.getString("major");
        }
    } catch (Exception e) {
%>
    <div class="message">DB error: <%= e.getMessage() %></div>
</body></html>
<%
        return;
    }
%>

<form action="process_edit.jsp" method="POST" onsubmit="return disableBtn(this)">
    <input type="hidden" name="id" value="<%= id %>">

    <label>Student Code *</label>
    <input type="text" name="student_code" value="<%= code %>" readonly>

    <label>Full Name *</label>
    <input type="text" name="full_name" value="<%= name %>" required>

    <label>Email</label>
    <input type="email" name="email" value="<%= email != null ? email : "" %>">

    <label>Major</label>
    <input type="text" name="major" value="<%= major != null ? major : "" %>">

    <div class="row">
        <button type="submit">Update</button>
        <a href="list_students.jsp" style="margin-left:12px;">Cancel</a>
    </div>
</form>

<script>
function disableBtn(form) {
    const btn = form.querySelector('button[type="submit"]');
    btn.disabled = true;
    btn.textContent = 'Processing...';
    return true;
}
</script>

</body>
</html>
