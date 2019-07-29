# File:   app.R
#
# Main script for the Shiny app.  This application follows the layout used by 
# the shinydashboardPlus example application:
#
#   https://github.com/RinteRface/shinydashboardPlus/tree/master/inst/examples
#
# The 'ui' and 'server' functions are defined here.  However, a 'globals.R' 
# script is invoked first and is responsible for loading packages and
# sourcing other scripts.  The dashboard uses a tabbed theme with links down
# the left sidebar.  The content for each tab is contained in other files with
# the goal of having one file (or sometimes folder) per tab.

source("globals.R")

ui <- dashboardPagePlus(
  header = dashboardHeaderPlus(
    title = "My Dashboard"  
  ),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id="sidebarmenu",
      
      menuItem(
        text = "Sample Tab 1", 
        tabName = "TAB1",
        icon = icon("chart-bar")
      ),
      conditionalPanel(
        "input.sidebarmenu === 'TAB1'",
        uiOutput("TAB1_CONTROLS")
      ),
      
      menuItem(
        text = "Sample Tab 2", 
        tabName = "TAB2",
        icon = icon("chart-bar")
      )
      
    )
  ),
  body = dashboardBody(
    
    # condense dataTable display
    tags$head(tags$style(HTML('
      table.dataTable thead th, 
      table.dataTable thead td {
        padding: 0px 2px !important;
      }

      table.dataTable tbody th,
      table.dataTable tbody td {
        padding: 0 2px !important;
      }
    '))),
    
    # use a bit of shinyEffects
    setShadow(class = "dropdown-menu"),
    setShadow(class = "box"),
    
    # All tabs
    tabItems(
      tabItem(
        tabName = "TAB1",
        box(
          title = "Tab 1 Title",
          width = NULL,
          uiOutput("TAB1_BODY")
        )
      ),
      tabItem(
        tabName = "TAB2",
        box(
          title = "Tab 2 Title",
          width = NULL,
          uiOutput("TAB2_BODY")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  TAB1_SERVER(input, output, session)
  TAB2_SERVER(input, output, session)
}

shinyApp(ui, server)
