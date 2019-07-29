# File: globals.R
#
# This loads all the packages and shared objects you might use.

# Load packages
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyEffects)

library(stringr)
library(DT)
library(scales)  # for comma()
library(tidyverse)

#library(plotly)

### Data Access ###############################################################
# Open database connections.  Also setup shutdown hooks to disconnect.

# source("config.R")
# MY_DATABASE <- openConnection("MY_DATABASE")
# 
# onStop(function() {
#   dbDisconnect(MY_DATABASE)
# })

### Services ##################################################################
# Setup service objects.  Typically, these will use the database connections
# defined above.

source("HelloService.R")
HELLO_SERVICE <- HelloService$new(conn=NULL)

### Tabs ######################################################################
# Source the files that define the dashboard tabs and server functionality.

source("tab1.R")
source("tab2.R")

