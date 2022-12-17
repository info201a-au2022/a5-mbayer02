
country_highest_coal_co2_capita <- data %>%
  filter(year == max(year, na.rm = TRUE)) %>%
  filter(coal_co2_per_capita == max(coal_co2_per_capita, na.rm = TRUE)) %>%
  pull(country, coal_co2_per_capita)


ui <- fluidPage(
  tabsetPanel(
    tabPanel("Introduction",
             h2("CO2 Emissions"),
             p("This Shiny application allows you to explore data about CO2 
               emissions from various countries. The data includes measures of 
               CO2 emissions per GDP, per capita, and total emissions. The data 
               is available for various years, starting from 1960."),
             p("In this introductory page, we will present some summary
               statistics about the CO2 emissions data. Specifically, we will 
               look at the average value of the variables across all countries 
               in the current year, the countries with the highest and lowest 
               values of the variables, and how the variables have changed over 
               the last 10 years."),
             h3("Summary Statistics"),
             verbatimTextOutput("summary"),
             h3("Highest and Lowest Values"),
             verbatimTextOutput("highlow"),
             h3("Change Over Time"),
             plotlyOutput("change")
    ),
    tabPanel("Interactive Visualization",
             h2("CO2 Emissions Visualization"),
             p("In this page, you can explore the CO2 emissions data using 
               interactive visualizations. Use the input widgets to select the 
               variable and the presentation of the data, and the chart will
               update accordingly."),
             selectInput("variable", "Variable:", 
                         c("Emissions per GDP" = "co2_per_gdp", 
                           "Emissions per Capita" = "co2_per_capita", 
                           "Total Emissions" = "co2_emissions")),
             selectInput("year", "Year:", unique(co2$Year)),
             plotlyOutput("plot"),
             p("The chart shows the CO2 emissions for different countries, 
               with the selected variable on the y-axis and the countries on 
               the x-axis. You can hover over the bars to see the exact values
               for each country. As you can see, the CO2 emissions vary 
               significantly across countries and over time, depending on
               the economic development and energy consumption patterns of 
               the countries.")
    )
  )
)

#
server <- function(input, output) {

  output$summary <- renderPrint({
    co2_summary <- co2 %>%
      filter(Year == max(Year)) %>%
      summarise_all(mean) %>%
      round(2)
    co2_summary
  })
  
  # Find the countries with the highest and lowest values of the selected variable
  output$highlow <- renderPrint({
    co2_highlow <- co2 %>%
      filter(Year == max(Year)) %>%
      arrange(!!sym(input$variable)) %>%
      select(Country, !!sym())

            
        
        