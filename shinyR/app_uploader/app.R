library(shiny)
library(ggplot2)

# Define UI for app that reads CSV and creates plots
ui <- fluidPage(
  titlePanel("CSV Data Visualization"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose CSV File",
                accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
      uiOutput("column_selector_a"),
      uiOutput("column_selector_b")
    ),
    
    mainPanel(
      plotOutput("histogram_a"),
      plotOutput("histogram_b"),
      plotOutput("scatter_plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Read the CSV file
  data <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  # Generate column selectors
  output$column_selector_a <- renderUI({
    req(data())
    selectInput("column_a", "Select Column A:", choices = names(data()))
  })
  
  output$column_selector_b <- renderUI({
    req(data())
    selectInput("column_b", "Select Column B:", choices = names(data()))
  })
  
  # Histogram of Column A
  output$histogram_a <- renderPlot({
    req(input$column_a)
    ggplot(data(), aes_string(x = input$column_a)) +
      geom_histogram(fill = "#75AADB", color = "white") +
      labs(title = paste("Histogram of", input$column_a),
           x = input$column_a, y = "Count")
  })
  
  # Histogram of Column B
  output$histogram_b <- renderPlot({
    req(input$column_b)
    ggplot(data(), aes_string(x = input$column_b)) +
      geom_histogram(fill = "#75AADB", color = "white") +
      labs(title = paste("Histogram of", input$column_b),
           x = input$column_b, y = "Count")
  })
  
  # Scatter plot of Column A vs Column B
  output$scatter_plot <- renderPlot({
    req(input$column_a, input$column_b)
    ggplot(data(), aes_string(x = input$column_a, y = input$column_b)) +
      geom_point(color = "#75AADB") +
      labs(title = paste(input$column_a, "vs", input$column_b),
           x = input$column_a, y = input$column_b)
  })
}

# Create Shiny app
shinyApp(ui = ui, server = server)