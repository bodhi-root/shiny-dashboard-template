# File:   config.R
#
# Config script for initializing database connections or anything that might
# change between dev, test, and prod environments.  The goal of this script
# is to provide a single function:
#
#   conn <- openConnection("NAMED_CONNECTION")
#
# How that function is defined is up to you.

openConnection <- function(name) {
  if (name == "MY_DATABASE") {
    
    library(odbc)
    
    conn <- DBI::dbConnect(
      odbc::odbc(),
      Driver   = "SQL Server",  # (may differ based on ODBC setup)
      Server   = "",            # Host name (DNS or IP) of database server
      Database = "",            # Database name
      UID      = "",            # User ID
      PWD      = "",            # Password
      Port     = 1433)          # 1433 is default SQL Server port
    
    return(conn)
  }
  
  stop(sprintf("Unknown database connection: '%s'", name))
}
