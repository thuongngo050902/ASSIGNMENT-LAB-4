WEB APPLICATION DEVELOPMENT
LAB 4 ASSIGNMENT – JSP + MYSQL CRUD OPERATIONS

Student ID: ITCSIU21160
Student name: Ngô Thị Thương

Link Github: https://github.com/thuongngo050902/ASSIGNMENT-LAB-4

============================================================
1) PROJECT OVERVIEW
============================================================
This project is a Student Management Web Application built with JSP and MySQL (JDBC).
Main features:
- CRUD: List / Add / Edit / Delete students
- Search (Exercise 5): search by student code or full name
- Validation (Exercise 6): required fields, code format, email format, duplicate code handling
- Pagination (Exercise 7): page & size parameters, Next/Prev navigation

============================================================
2) PROJECT STRUCTURE
============================================================
StudentManagement
├── src/
│   └── com/mycompany/studentmanagement/util/
│       └── DBUtil.java
├── web/
│   ├── list_students.jsp
│   ├── add_student.jsp
│   ├── process_add.jsp
│   ├── edit_student.jsp
│   ├── process_edit.jsp
│   └── delete_student.jsp
├── nbproject/
├── pom.xml
└── README.txt

============================================================
3) DATABASE SETUP
============================================================
Database: student_management
Table: students (id, student_code, full_name, email, major, created_at)

Run SQL in MySQL:
- Create database student_management
- Create table students
- Insert sample data (SV001...SV005)

============================================================
4) CONFIGURE DB CONNECTION (IMPORTANT)
============================================================
Edit file:
src/com/mycompany/studentmanagement/util/DBUtil.java

Update these values to match your MySQL:
- USER (example: root)
- PASSWORD (your MySQL password)
- URL (port 3306 and database name student_management)

============================================================
5) HOW TO RUN
============================================================
1. Open project in NetBeans.
2. Ensure MySQL server is running.
3. Add MySQL Connector/J to project libraries (if needed).
4. Clean and Build project.
5. Run on Apache Tomcat.
6. Open in browser:
   http://localhost:8080/StudentManagement/list_students.jsp

============================================================
6) TEST LINKS (FOR SCREENSHOTS)
============================================================
6.1 List Students (READ)
http://localhost:8080/StudentManagement/list_students.jsp

6.2 Add Student (CREATE)
Form:
http://localhost:8080/StudentManagement/add_student.jsp
Handler:
POST -> process_add.jsp

6.3 Edit Student (UPDATE)
http://localhost:8080/StudentManagement/edit_student.jsp?id=1
Handler:
POST -> process_edit.jsp

6.4 Delete Student (DELETE)
Click Delete from list page OR open:
http://localhost:8080/StudentManagement/delete_student.jsp?id=1

6.5 Search Functionality (Exercise 5)
http://localhost:8080/StudentManagement/list_students.jsp?keyword=SV
http://localhost:8080/StudentManagement/list_students.jsp?keyword=SV001

6.6 Validation & Error Handling (Exercise 6)
Open add form and submit invalid input (examples):
- missing Full Name
- invalid email: abc@
- duplicate code: SV001
http://localhost:8080/StudentManagement/add_student.jsp

6.7 Pagination (Exercise 7)
http://localhost:8080/StudentManagement/list_students.jsp?page=1&size=5
http://localhost:8080/StudentManagement/list_students.jsp?page=2&size=5

============================================================
7) SCREENSHOTS TO SUBMIT (5–10 IMAGES)
============================================================
Recommended screenshot list:
1) Main list page
2) Add student form
3) Add success (list updated)
4) Edit student form
5) Search results
6) Validation error
7) Pagination page (if implemented)

============================================================
8) COMPLETED EXERCISES
============================================================
[x] Exercise 5: Search Functionality
[x] Exercise 6: Validation Enhancement
[x] Exercise 7: Pagination
[ ] Bonus 1: CSV Export
[ ] Bonus 2: Sortable Columns

============================================================
9) KNOWN ISSUES
============================================================
- None / (write here if any)

END
