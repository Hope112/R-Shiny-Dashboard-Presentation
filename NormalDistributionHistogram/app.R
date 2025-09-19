#Load packages
library(shiny)

#UI
ui <- fluidPage( # Creates a responsive page that adapts to the browser width
  titlePanel("Histogram for Normal Distribution"), #Adds title bar at the top of the app
  sidebarLayout( #Split the page into sidebar and main area
    sidebarPanel( #Creates a sidebar panel for inputs
      sliderInput("n",    "Sample size (n)", min = 10,  max = 5000, value = 500, step = 10),
      sliderInput("mean", "Mean",            min = -5,  max = 5,    value = 0,   step = 0.1),
      sliderInput("sd",   "SD",              min = 0.1, max = 5,    value = 1,   step = 0.1),
      sliderInput("bins", "Bins",            min = 5,   max = 100,  value = 30,  step = 1)
    ),
    mainPanel( #Creates a main panel for displaying outputs
      plotOutput("histPlot", height = "420px") #Creates a space to display the plot output
    )
  )
)

#Server
server <- function(input, output) { #Starts the server function that contains the app logic (input, output)
                                    #input holds the values of the widgets in the UI
                                    #output is where you assign things to be displayed in the UI
  
  #Reactive expression to generate the data and reruns whenever inputs change
  data <- reactive({
    rnorm(input$n, mean = input$mean, sd = input$sd) #Generates the random normal data
  })
  
  output$histPlot <- renderPlot({ #Renders the plot output when the reactive expression changes
    hist(data(), #Draws histogram of current data
         breaks = input$bins,
         col = "gold", border = "white",
         main = "Histogram of rnorm()",
         xlab = "Value")
  })
}

shinyApp(ui, server) #Launches the app using the ui and server defined
