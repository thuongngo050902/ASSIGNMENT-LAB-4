<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Student</title>
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

<h2>Add Student</h2>

<%
    String err = request.getParameter("error");
    if (err != null && !err.trim().isEmpty()) {
%>
    <div class="message"><%= err %></div>
<%
    }
%>

<form action="process_add.jsp" method="POST" onsubmit="return disableBtn(this)">
    <label>Student Code *</label>
    <input type="text" name="student_code" placeholder="SV001" required>

    <label>Full Name *</label>
    <input type="text" name="full_name" required>

    <label>Email</label>
    <input type="email" name="email">

    <label>Major</label>
    <input type="text" name="major">

    <div class="row">
        <button type="submit">Create</button>
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
