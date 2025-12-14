<%@ page contentType="text/csv; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mycompany.studentmanagement.util.DBUtil" %>

<%
    request.setCharacterEncoding("UTF-8");

    String keyword = request.getParameter("keyword");
    boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());
    if (hasKeyword) keyword = keyword.trim();

    // Sort params with whitelist (same as list)
    String sortBy = request.getParameter("sort");
    String order = request.getParameter("order");
    if (sortBy == null || sortBy.trim().isEmpty()) sortBy = "id";
    if (order == null || order.trim().isEmpty()) order = "desc";

    sortBy = sortBy.trim();
    order = order.trim().toLowerCase(Locale.ROOT);

    Set<String> allowedSort = new HashSet<>(Arrays.asList(
        "id", "student_code", "full_name", "email", "major", "created_at"
    ));
    if (!allowedSort.contains(sortBy)) sortBy = "id";
    if (!("asc".equals(order) || "desc".equals(order))) order = "desc";

    String whereClause = hasKeyword ? " WHERE full_name LIKE ? OR student_code LIKE ? " : "";
    String sql =
        "SELECT * FROM students" +
        whereClause +
        " ORDER BY " + sortBy + " " + order;

    // Force download
    response.setHeader("Content-Disposition", "attachment; filename=\"students.csv\"");

    // CSV header
    out.println("id,student_code,full_name,email,major,created_at");

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        if (hasKeyword) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                // Basic CSV escaping for commas/quotes
                String id = String.valueOf(rs.getInt("id"));
                String code = rs.getString("student_code");
                String name = rs.getString("full_name");
                String email = rs.getString("email");
                String major = rs.getString("major");
                String created = String.valueOf(rs.getTimestamp("created_at"));

                out.println(csv(id) + "," + csv(code) + "," + csv(name) + "," + csv(email) + "," + csv(major) + "," + csv(created));
            }
        }
    } catch (Exception e) {
        // If error, output as comment line in csv
        out.println("# ERROR: " + e.getMessage());
    }

%>

<%! 
    private String csv(String s) {
        if (s == null) return "";
        String v = s.replace("\"", "\"\"");
        if (v.contains(",") || v.contains("\"") || v.contains("\n")) {
            return "\"" + v + "\"";
        }
        return v;
    }
%>
