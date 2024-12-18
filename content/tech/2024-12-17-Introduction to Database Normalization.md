---
title: "Introduction to Database Normalization"
date: 2024-12-18T13:59:24+08:00
draft: true
tags: ["database"]
categories: ["Tech"]
---

# Introduction to Database Normalization: 1NF, 2NF, 3NF, and Beyond

Database normalization is a crucial concept in database design that aims to reduce data redundancy and ensure data integrity. The goal is to structure data in a way that makes it easier to manage and update, while maintaining its consistency. In this post, we'll explore the most commonly used normal forms: **1NF**, **2NF**, and **3NF**, and briefly mention other advanced normal forms (xxNF).

## What is Normalization?

Normalization refers to the process of organizing data in a relational database into tables so that the relationships between the data are logical and efficient. This involves splitting large tables into smaller, related tables and defining relationships between them.

The benefits of normalization include:
- Eliminating data redundancy
- Improving data integrity
- Ensuring consistent and efficient database updates

## 1st Normal Form (1NF)

A table is in **1st Normal Form (1NF)** if it meets the following criteria:
- It has only atomic (indivisible) values in each column.
- Each record (row) in the table is unique.
- Each column contains only one value (no repeating groups or arrays).

### Example of 1NF:

**Non-1NF Table:**

| Student_ID | Name  | Subjects          |
|------------|-------|-------------------|
| 1          | Alice | Math, Physics     |
| 2          | Bob   | Chemistry, Math   |

**1NF Table:**

| Student_ID | Name  | Subject  |
|------------|-------|----------|
| 1          | Alice | Math     |
| 1          | Alice | Physics  |
| 2          | Bob   | Chemistry|
| 2          | Bob   | Math     |

In this example, the `Subjects` column originally contained multiple values. In 1NF, we separate the values into individual rows, ensuring that each column has a single, atomic value.

## 2nd Normal Form (2NF)

A table is in **2nd Normal Form (2NF)** if:
- It is in **1NF**.
- All non-key attributes are fully dependent on the primary key (no partial dependency).

### Example of 2NF:

**Non-2NF Table:**

| Student_ID | Course_ID | Student_Name | Instructor  |
|------------|-----------|--------------|-------------|
| 1          | 101       | Alice        | Dr. Smith   |
| 1          | 102       | Alice        | Dr. Lee     |
| 2          | 101       | Bob          | Dr. Smith   |

**2NF Table:**

**Students_Courses Table:**

| Student_ID | Course_ID |
|------------|-----------|
| 1          | 101       |
| 1          | 102       |
| 2          | 101       |

**Courses_Instructors Table:**

| Course_ID | Student_Name  |
|-----------|-------------|
| 101       | Dr. Smith   |
| 102       | Dr. Lee     |

**Students Table:**

| Student_ID | Student_Name |
|------------|--------------|
| 1          | Alice        |
| 2          | Bob          |

In this case, the combination of `Student_ID` and `Course_ID` could serve as a **candidate key** for the Students_Courses table. A candidate key is any attribute, or combination of attributes, that can uniquely identify each row in a table. In this example, the combination of `Student_ID` and `Course_ID` ensures uniqueness because a student can enroll in multiple courses, but each combination of student and course will be distinct.

Although we haven't explicitly set `Student_ID` + `Course_ID` as the **primary key** in this table, it can be inferred as such since the combination of these two columns uniquely identifies each row.

In the 2NF example, `Student_Name` is dependent only on `Student_ID`, and `Instructor` is dependent only on `Course_ID`. To eliminate the partial dependency between `Student_Name` and `Student_ID`, as well as between `Instructor` and `Course_ID`, we can create new tables `Courses_Instructors` and `Students` to store instructor and student details separately.

## 3rd Normal Form (3NF)

A table is in **3rd Normal Form (3NF)** if:
- It is in **2NF**.
- It has no transitive dependencies (i.e., non-key attributes should not depend on other non-key attributes).

### Example of 3NF:

**Non-3NF Table:**

| Student_ID | Course_ID | Instructor | Instructor_Office |
|------------|-----------|------------|-------------------|
| 1          | 101       | Dr. Smith  | Room 201          |
| 1          | 102       | Dr. Lee    | Room 202          |
| 2          | 101       | Dr. Smith  | Room 201          |

**3NF Table:**

**Students_Courses Table:**

| Student_ID | Course_ID |
|------------|-----------|
| 1          | 101       |
| 1          | 102       |
| 2          | 101       |

**Courses_Instructors Table:**

| Course_ID | Instructor |
|-----------|------------|
| 101       | Dr. Smith  |
| 102       | Dr. Lee    |

**Instructors Table:**

| Instructor | Office     |
|------------|------------|
| Dr. Smith  | Room 201   |
| Dr. Lee    | Room 202   |

In the 3NF example, we eliminated the transitive dependency between `Instructor` and `Instructor_Office` by creating a new table (`Instructors`) to store instructor office information separately.

## Other Normal Forms (xxNF)

While **1NF**, **2NF**, and **3NF** are the most commonly used, there are other advanced normal forms for specific use cases, such as:

- **Boyce-Codd Normal Form (BCNF)**: A stricter version of 3NF where every determinant is a candidate key.
- **4th Normal Form (4NF)**: Deals with multi-valued dependencies.
- **5th Normal Form (5NF)**: Eliminates join dependencies.
- **6th Normal Form (6NF)**: Often used for temporal databases to handle time-based data.

These advanced normal forms are used in more specialized scenarios but are less common in day-to-day database design.

## Conclusion

Database normalization is a foundational technique for designing efficient, consistent, and scalable relational databases. By understanding and applying normal forms like **1NF**, **2NF**, and **3NF**, you can avoid common pitfalls such as redundancy and data anomalies. While the more advanced normal forms (xxNF) can be useful in specific cases, they are typically less necessary in everyday database design.

For more detailed information, check out the [Wikipedia page on Database Normalization](https://en.wikipedia.org/wiki/Database_normalization).

