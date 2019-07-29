# File:   tab2.R
#
# Contains the server and UI logic for tab 2.  This is implemented as a
# function named TAB2_SERVER. This function will create a UI output
# named TAB2_BODY.

TAB2_SERVER <- function(input, output, session) {
  
  get_sample_data <- function() {
    tribble(
      ~NAME, ~VALUE,
      "Row 1", "Value 1",
      "Row 2", "Value 2"
    )
  }
  
  output$TAB2_BODY <- renderUI({
    
    df_data <- get_sample_data()
    
    # dt_data <- datatable(
    #   df_data, 
    #   rownames = F,
    #   selection = "none",
    #   #escape = F,  # don't escape the '&nbsp;' we put in for spacing
    #   fillContainer = F,
    #   options = list(
    #     paging = T,
    #     ordering = F,
    #     searching = T
    #     #scrollX = T,
    #     #columnDefs = list(
    #     #  list(className = 'dt-right', targets = 1:(ncol(df_data)-1))  # right-align all but column 0
    #     #)
    #   )
    # )
    
    dt_data <- renderTable(df_data)
    
    ui <- box(
      title="Sample Table", 
      width=12,
      downloadButton("TAB2_DOWNLOAD_HANDLER", "Download", style="margin-bottom: 8px;"),
      dt_data
    )
    
    return(ui)
  })
  
  output$TAB2_DOWNLOAD_HANDLER <- downloadHandler(
    filename = "sample.csv",    # NOTE: this works in actual browsers but not the RStudio preview browser
    content = function(file) {
      df_data <- get_sample_data()
      write.csv(df_data, file, row.names = FALSE)
    }
  )
  
}