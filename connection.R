library(DBI)

#set the location where you would like to see the database stored
setwd("/home/abasu/Documents/sqlite-R")
getwd()

customerdb <- dbConnect(RSQLite::SQLite(), "customerdb.sqlite")
dbExecute(customerdb, "DROP table customers")
dbExecute(customerdb, "CREATE TABLE customers (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT, last_name TEXT, email TEXT)")
dbGetQuery(customerdb, "SELECT * FROM customers")

# Insert data into a table
dbExecute(customerdb, 
          "INSERT INTO customers (first_name, last_name, email) 
           VALUES('Ankan', 'Basu', 'basu.ankan@gmail.com')" )

dbExecute(customerdb, "INSERT INTO customers (first_name, last_name, email) 
          VALUES('Sovon', 'Samanta', 'samanta@hotmail.com')")

dbExecute(customerdb,'INSERT INTO customers (first_name, last_name, email) VALUES(
        "Chandan",
        "Addya",
        "chandan@gmail.com"
        )
       ')

dbGetQuery(customerdb, "SELECT * FROM customers")


dbExecute(customerdb, 
          "UPDATE customers SET first_name='UpdatedAnkan' WHERE id=1" )
dbGetQuery(customerdb, "SELECT * FROM customers")

dbExecute(customerdb, 
          "DELETE from customers WHERE id=1" )
dbGetQuery(customerdb, "SELECT * FROM customers")

# Sample database that comes with SQLite --> this is the connection
db <- RSQLite::datasetsDb()

# Display all the tables in the database
dbListTables(db)

# Read a particular table from the database
dbReadTable(db, "CO2")

# Querying table
dbGetQuery(db, "SELECT * FROM CO2 WHERE conc < 100")

#Writing existing table to SQLite database
dbWriteTable(con, "mtcars", mtcars)
dbReadTable(con, "mtcars")

# A zero row data frame just creates a table definition.
dbWriteTable(con, "mtcars2", mtcars[0, ])
dbReadTable(con, "mtcars2")

dbDisconnect(customerdb)

# Init extension
db <- RSQLite::datasetsDb()
RSQLite::initExtension(db)
dbGetQuery(db, "SELECT stdev(mpg) FROM mtcars")
sd(mtcars$mpg)
dbDisconnect(db)

