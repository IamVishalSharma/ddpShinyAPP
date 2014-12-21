library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("ISLR package illustration"),
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("College","CreditDefault","Auto","Caravan","Hitters","Smarket","Wage","Weekly")), 
      
      numericInput("obs", "Number of observations to view:", 5),
      hr(),
      p(HTML("This Shiny Application gives insights of different data set in the ISLR package!")),
      p(HTML(paste("User need to select the dataset in which he is interested and the rows of the data set."))),
      p(HTML(paste("After the selection second Pane shows the Top rows of data set and Linear Modeling Done on the Data Set"))),
      p(HTML("it also shows one plot relevant to that data set."))
    ),
    
    # Show a summary of the dataset and an HTML table with the 
    # requested number of observations
    mainPanel(
      h4(HTML("Description of DataSet")),
      verbatimTextOutput("desc"),
      p("First N Observations:"),
      tableOutput("view"),
      p("Linear Modeling of  Data Set:"),
      verbatimTextOutput("lm"),
      p("Relevant Plot:"),
      plotOutput("distPlot")
    )
  )
))