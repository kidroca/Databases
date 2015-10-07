# Database Systems -- Overview

### What database models do you know?
* ##### Hierarchical 
    > In this model each entity has only one parent but can have several children . At the top of hierarchy there is only one entity which is called Root.

* ##### Network
    > In the network model, entities are organised in a graph,in which some entities can be accessed through sveral path

* ##### Relational 
    > In this model, data is organised in two-dimesional tables called relations. The tables or relation are related to each other.

### Which are the main functions performed by a Relational Database Management System (RDBMS)?

* ##### CRUD -- Create, Read, Update, Delete 
    > Sometimes called SCRUD with an "S" for Search, these are the four basic functions of presistent storage 

### Define what is "table" in database terms.

> In Relational database, a table is a collection of data elements    organised in terms of rows and columns. A table is also considered as convenient representation of relations. But a table can have duplicate tuples while a true relation cannot have duplicate tuples. Table is the most simplest form of data storage.

### Explain the difference between a primary and a foreign key.

* ##### Primary Key 
    > Primary key is a column of the table that uniquely identifies its rows usually this is the first column of the table and is named **ID**. A Primary key must be unique and can consist of multiple fields 

* ##### Foreign Key
    > The foreign key is an identifier of a record located in another table (usually its primary key)

* ##### The Difference
    > Primary keys identify the current table records, foreign keys are used to form a relationships to other tables

### Explain the different kinds of relationships between tables in relational databases.

* ##### One to One 
    > A single record in a table corresponds to a single record in the other table. This type of relationship is rarely seen in real world. 

* ##### One to Many
    > It reflects business rule that one entity is associated with many number of same entity. "A student can enroll in one school, but a school can have many students"

* ##### Many to Many
    > Records in the first table have many correspon-ding records in the second one and vice versa. "A student can enroll in many courses, and a course can have many students"

### When is a certain database schema normalized?

* ##### Normalization
    > Normalization is a process or set of guidelines used to optimally design a database to reduce redundant data.

* ##### The Normal Forms 
    > The database community has developed a series of guidelines for ensuring that databases are normalized. These are referred to as normal forms

* ##### Normalized Database 
    > A database is considered normalized when it meets all the requirements up to and including 3rd Normal Form 

* ##### Advantages of normalized database
    * Greater overall database organization
    * Reduction of redundant data
    * Data consistency within the database
    * A much more flexible database design
    * A better handle on database security

### What are database integrity constraints and when are they used?

* ##### Integrity Constraints
    > They ensure data integrity in the database tables by enforcing data rules which cannot be violated.

* ##### Primary Key Constraint
    > Ensures that the primary key of a table has unique value for each table row

* ##### Unique Key Constraint
    > Ensures that all values in a certain column (or a group of columns) are unique

* ##### Foreign Key Constraint
    > Ensures that the value in given column is a key from another table

* ##### Check Constraint
    > Ensures that values in a certain column meet some predefined condition

### Point out the pros and cons of using indexes in a database.

* ##### Advantages 
    * Faster lookup for results by using index structures such as B-Trees or Hash Indexes to get data faster.
    * Very useful for larger databases

* ##### Disadvantages
    * Potentially slower writes as data have to be written to table and also to indexes. This may cause the system to restructure the index structure(Hash Index, B-Tree etc), which can be very computationally expensive.
    * Takes up more disk space

### What's the main purpose of the SQL language?

> The SQL Language (Structured Query Language) is designed to manipulate and retrieve data stored in a Relational Database System

### What are transactions used for?

**Transactions** are a sequence of database operations which are executed as a single unit:
* Either all of them execute successfully
* Or none of them is executed at all

   **Example**
   > A certain JavaScript Exam application accepts a list of "playlables" and preforms an operation for each then stores the result, if at any step an error is detected the result must be discraded 

### What is a NoSQL database?
> A **NoSQL** database is a non-relation database that uses Schema-free document storage, still supports CRUD, indexing, querying, concurency and transactions  

### Give few examples of NoSQL databases and their pros and cons.
* **Redis** - Ultra-fast in-memory data structures server
* **MongoDB** - Mature and powerful JSON-document database
* **CouchDB** - JSON-based document database with REST API
* **Cassandra** - Distributed wide-column database
