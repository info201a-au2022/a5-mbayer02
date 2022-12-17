library("shiny")
library("dplyr")
library("leaflet")
library("plotly")
library("ggplot2")
library("tidyverse")
library("readr")

data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

ui <- navbarPage("Ferryn Drake Co2 Emissions",
                 tabPanel("Introduction", uiOutput('page1')),
                 tabPanel("Interactive Visualization", uiOutput('page2'))
)
source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
