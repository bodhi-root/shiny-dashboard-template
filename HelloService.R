# File:   HelloService.R
#
# Contains a sample service object.

library(R6)
library(dplyr)

HelloService <- R6Class(
  "HelloService",
  
  private = list(
    conn = NULL,  # database connection
    cached_text = NULL
  ),
  
  public = list(
    
    #' Initializes the object with a database connection
    initialize = function(conn) {
      private$conn <- conn
    }
  )
)

#' Returns a 'hello' message for the given name
#' 
HelloService$set("public", "get_message", function(greeting, name) {
  sprintf("%s, %s!", greeting, name)
})

#' Returns a hello message with the timestamp of when it was created.
#' This value is cached so that it is only created once
#' 
HelloService$set("public", "get_cached_message", function() {
  if (is.null(private$cached_text)) {
    private$cached_text <- sprintf("Hello!  This message was created at %s", Sys.time())
  }
  
  private$cached_text
})


