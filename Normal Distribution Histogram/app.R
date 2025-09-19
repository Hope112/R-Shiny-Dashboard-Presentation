library(shiny)

ui <- fluidPage(
  titlePanel("Histogram for Normal Distribution"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n",    "Sample size (n)", min = 10,  max = 5000, value = 500, step = 10),
      sliderInput("mean", "Mean",            min = -5,  max = 5,    value = 0,   step = 0.1),
      sliderInput("sd",   "SD",              min = 0.1, max = 5,    value = 1,   step = 0.1),
      sliderInput("bins", "Bins",            min = 5,   max = 100,  value = 30,  step = 1)
    ),
    mainPanel(
      plotOutput("histPlot", height = "420px")
    )
  )
)

server <- function(input, output, session) {
  data <- reactive({
    rnorm(input$n, mean = input$mean, sd = input$sd)
  })
  
  output$histPlot <- renderPlot({
    hist(data(),
         breaks = input$bins,
         col = "gold", border = "white",
         main = "Histogram of rnorm()",
         xlab = "Value")
  })
}

shinyApp(ui, server)
