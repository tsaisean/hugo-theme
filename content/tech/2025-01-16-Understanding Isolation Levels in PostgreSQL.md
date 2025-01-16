---
layout:     post 
title:      "Understanding Isolation Levels in PostgreSQL"
subtitle:   ""
description: ""
date:       2025-01-15 12:00:00
image: "https://img.zhaohuabing.com/post-bg-2015.jpg"
tags:
    - Go
URL: ""
categories: [ "Tech" ]
ShowToc: true
---


Isolation levels are an essential concept in database management systems, ensuring data consistency and integrity during concurrent transactions. PostgreSQL, known for its robustness and compliance with the SQL standard, implements isolation levels using Multiversion Concurrency Control (MVCC). In this blog, we will explore the four standard isolation levels, their characteristics, and practical examples in PostgreSQL.

## What Are Isolation Levels?

Isolation levels define the degree to which the operations in one transaction are isolated from those in other concurrent transactions. They help manage phenomena such as:

- **Dirty Reads:** Reading uncommitted changes from another transaction.
- **Non-Repeatable Reads:** Data retrieved in a transaction changes due to another transaction's updates.
- **Phantom Reads:** New rows matching a query condition appear due to another transaction's insertions.

## The Four Isolation Levels

PostgreSQL supports the following isolation levels:

1. **Read Uncommitted:**
    - Allows transactions to read uncommitted changes from others.
    - Not implemented in PostgreSQL; it behaves like "Read Committed."

2. **Read Committed (Default):**
    - Ensures a transaction sees only committed changes.
    - Each query in the transaction gets a fresh snapshot of the database.

3. **Repeatable Read:**
    - Guarantees consistency within a transaction—data read at the start remains unchanged throughout.
    - Prevents dirty and non-repeatable reads and <mark>PG disallows phantom reads</mark>.

    You can try it with any DB tools, here I'm using DataGrip for testing.
    ``` sql
    // Original records:
    // Bob 24
    // Kevin 36
    ```

    ``` sql
    // In Tab 1
    BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; // <- Excute this line
    SELECT * FROM student;
    ```

    ``` sql
    // In Tab 2
     INSERT INTO student (name, age) VALUES ('Sean', '18');
    
    // Records now:
    // Bob 24
    // Kevin 36
    // Sean 18
    ```

    ``` sql
    // Go back to Tab 1
    BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
    SELECT * FROM student; // <- Excute this line

    // Records seen by this session:
    // Bob 24
    // Kevin 36
    // Sine ("Sean", 18) is commited after this isolation so it's not being read.
    ```


4. **Serializable:**
    - Emulates serial transaction execution, ensuring full isolation.
    - Prevents all phenomena, including phantom reads.



## Choosing the Right Isolation Level

- Use Read Committed for most applications where real-time data consistency isn’t critical.
- Opt for Repeatable Read in scenarios requiring consistent snapshots, such as report generation.
- Choose Serializable for high-stakes transactions demanding strict consistency, at the cost of performance.

Red: [postgresql - Transaction Isolation](https://www.postgresql.org/docs/current/transaction-iso.html)