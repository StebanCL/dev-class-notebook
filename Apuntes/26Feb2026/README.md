
# 📊 MySQL SQL Notes: Mastering JOINs

This document serves as a quick-reference guide for connecting tables (Courses, Enrollments, and Students) and understanding what to expect from each operation.

---

## 🏗️ Query Structure (Mandatory Order)

In MySQL, the order of clauses is **not optional**. You must follow this hierarchy to avoid syntax errors:

```sql
SELECT 
    t1.column_a, -- Highlighted column from Table 1
    t2.column_b  -- Highlighted column from Table 2
FROM left_table AS t1
[JOIN TYPE] right_table AS t2 
    ON t1.primary_key = t2.foreign_key
LIMIT 0, 25;
🔄 JOIN Types and Column Behavior
1. INNER JOIN (The Intersection)
Result: It only returns rows where there is an exact match in both tables.

Data Behavior: If a student is not enrolled in any course, their entire row disappears from the result.

Use Case: Creating lists of "Active Students" who have grades.

SQL
SELECT e.name, i.final_grade
FROM students AS e
INNER JOIN enrollments AS i 
    ON e.student_id = i.student_id;
2. LEFT JOIN (Left Priority)
Result: It keeps all rows from the first table mentioned (FROM).

Data Behavior: If there is no matching data in the right table, the highlighted column will display NULL.

Use Case: Seeing every student in the database, even those who haven't picked a course yet.

SQL
SELECT e.name, i.final_grade
FROM students AS e
LEFT JOIN enrollments AS i 
    ON e.student_id = i.student_id;
-- Result: [Name | Grade or NULL]
3. RIGHT JOIN (Right Priority)
Result: It keeps all rows from the table mentioned after the JOIN keyword.

Data Behavior: If an enrollment exists but the student was deleted or doesn't exist in the left table, the student's name will show as NULL.

Use Case: Auditing "orphaned" enrollments that lack a valid student.

SQL
SELECT e.name, i.final_grade
FROM students AS e
RIGHT JOIN enrollments AS i 
    ON e.student_id = i.student_id;
-- Result: [Name or NULL | Grade]
🔑 Key Concepts to Remember
🏷️ Using Aliases (AS)
An alias is a temporary "nickname" for a table.

Syntax: table AS t or simply table t.

Rule: Once you define an alias (e.g., AS e), you must use it in the SELECT and ON clauses. MySQL will "forget" the original table name for that specific query.

🌉 The Bridge (ON)
This is the logical link. It almost always connects:

PK (Primary Key): The unique ID in the "Master" table (e.g., students.student_id).

FK (Foreign Key): The ID that "traveled" to the other table (e.g., enrollments.student_id).

Never connect unrelated IDs (e.g., student_id = enrollment_id).

🔗 Multi-Table Queries (3+ tables)
To add more tables, simply chain more JOIN + ON blocks.
Rule: Number of Joins = Number of Tables - 1.

SQL
SELECT e.name, c.course_name, i.final_grade
FROM students e
INNER JOIN enrollments i ON e.student_id = i.student_id
INNER JOIN courses c ON i.course_id = c.course_id;
Learning Tip: In Left/Right Joins, NULL is a helpful signal—it indicates a missing relationship between records.


## 🔍 Filtering Results (The WHERE Clause)

The `WHERE` clause always comes **after** all your JOINs are declared.

| Goal | SQL Syntax |
| :--- | :--- |
| **Filter by Value** | `WHERE i.nota_final > 8` |
| **Filter by Text** | `WHERE c.nombre_curso = 'Math'` |
| **Find Missing Data**| `WHERE i.id_student IS NULL` |
| **Multiple Rules** | `WHERE i.nota_final > 7 AND e.nombre LIKE 'A%'` |

1. Filtering with INNER JOIN
If you only want to see students who are "passing" (e.g., a grade higher than 7), you add WHERE at the very end of your query.

SQL
SELECT e.nombre, c.nombre_curso, i.nota_final
FROM estudiantes e
INNER JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
INNER JOIN cursos c ON i.id_curso = c.id_curso
WHERE i.nota_final >= 7; 
-- Only rows meeting this condition will be displayed.
2. The "Power Move": Finding NULLs with LEFT JOIN
This is one of the most common tasks for a Database Administrator. How do you find students who haven't signed up for any classes?

You use a LEFT JOIN and then filter for the NULL values.

SQL
SELECT e.nombre, i.id_inscripcion
FROM estudiantes e
LEFT JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
WHERE i.id_inscripcion IS NULL;
-- This result highlights only the "inactive" students.