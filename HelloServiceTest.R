# File:   HelloServiceTest.R
#
# Simple test of the HelloService object

source("config.R")
#MY_DATABASE <- openConnection("MY_DATABASE")

source("HelloService.R")
HELLO_SERVICE <- HelloService$new(conn=NULL)

HELLO_SERVICE$get_message("Hello", "Dan")
HELLO_SERVICE$get_cached_message()

Sys.sleep(5)

HELLO_SERVICE$get_cached_message()
