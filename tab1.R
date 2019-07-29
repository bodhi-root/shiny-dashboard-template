# File:   tab1.R
#
# Contains the server and UI logic for TAB1.  This is implemented as a
# function named TAB1_SERVER. This function will create UI outputs
# named TAB1_BODY and TAB1_CONTROLS.
#
# This script depends on HELLO_SERVICE being defined.

TAB1_SERVER <- function(input, output, session) {
  
  # Define a sample data set of people that speak different languages
  
  df_people <- tribble(
    ~PERSON,    ~LANGUAGE,
    "Dan",      "English",
    "Dan",      "German",
    "Pedro",    "Spanish",
    "Pedro",    "English",
    "Helmut",   "German"
  )
  
  df_greetings <- tribble(
    ~LANGUAGE, ~GREETING,
    "English", "Hello",
    "Spanish", "Hola",
    "German",  "Guten Tag"
  )
  
  # Options for people selector (this never changes)
  get_people_options <- function() {
    v_options <- unique(df_people$PERSON)
    v_options <- c("Select" = "", v_options)
    return(v_options)
  }
  
  # Options for languages/greetings
  # Reactively filter available greetings based on person
  reactive_greeting_options <- reactive({
    
    if (any(input$TAB1_PERSON != "")) {
      df_active_people    <- df_people %>% filter(PERSON == input$TAB1_PERSON)
      df_active_greetings <- df_greetings %>% filter(LANGUAGE %in% df_active_people$LANGUAGE)
      
      v_options        <- df_active_greetings$GREETING
      names(v_options) <- df_active_greetings$LANGUAGE
      
      v_options <- c("Select" = "", v_options)
      return(v_options)
    }
    
    return(NULL)
  })
  
  #' Generates the input controls that will be displayed in the dashboard
  #' sidebar.  This will include:
  #' 
  #' TAB1_PERSON
  #' TAB1_GREEETING
  #' 
  output$TAB1_CONTROLS <- renderUI({
    
    people_options   <- get_people_options()
    greeting_options <- reactive_greeting_options()
    
    controls <- list(
      
      selectInput(
        "TAB1_PERSON", 
        "Person:", 
        people_options, 
        selected=input$TAB1_PERSON
      ),
      
      tags$div(
        class=ifelse(is.null(greeting_options), 'hidden', ''),
        selectInput(
          "TAB1_GREETING", 
          "Greeting:", 
          greeting_options, 
          selected=input$TAB1_GREETING
        )
      )
    
    )
    
    return(controls)
  })
  
  output$TAB1_BODY <- renderUI({
    
    controls <- list()
    
    cached_message <- HELLO_SERVICE$get_cached_message()
    
    if (any(input$TAB1_PERSON   != "") &
        any(input$TAB1_GREETING != "")) {
      
      message <- HELLO_SERVICE$get_message(input$TAB1_GREETING, input$TAB1_PERSON)
      print(message)
      
      controls[[1]] <- box(
        title="Greeting", 
        width=12,
        tags$div(message)
      )
    }
    
    controls[[length(controls) + 1]] <- box(
      title="Cached Message",
      width=12,
      tags$div(cached_message)
    )
    
    return(controls)
  })
  
}