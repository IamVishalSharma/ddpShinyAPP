library(shiny)
library(datasets)
library(caret)
library(randomForest)
library(ISLR)
library(ggplot2)




# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {

  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "Auto" = Auto,
           "Caravan" = Caravan,
           "College" = College,
           "CreditDefault" = Default,
           "Hitters" = Hitters,
           "Smarket" = Smarket,
           "Wage" = Wage,
           "Weekly" = Weekly           
           )
  })
  
  output$desc <- renderPrint({
    dataset <- datasetInput()
    if (input$dataset == "Auto")
    { print("Gas mileage, horsepower, and other information for 392 vehicles.") }
    if (input$dataset == "Caravan")
    { print("The data contains 5822 real customer records,containing sociodemographic data") }
    if (input$dataset == "College")
    {print("Statistics for a large number of US Colleges from the 1995 issue of US News and World Report.
")}
    if (input$dataset == "CreditDefault")
    {print("A simulated data set containing information on ten thousand customers. The aim here is to predict
which customers will default on their credit card debt")}
    if (input$dataset == "Hitters")
    {print("Major League Baseball Data from the 1986 and 1987 seasons")}
    if (input$dataset == "Smarket")
    {print("Daily percentage returns for the S&P 500 stock index between 2001 and 2005")}
    if (input$dataset == "Wage")
    {print("Wage and other data for a group of 3000 workers in the Mid-Atlantic region")}
    if (input$dataset == "Weekly")
    {print("Weekly percentage returns for the S&P 500 stock index between 1990 and 2010.
")}
 
    
      
  })

  output$lm <- renderPrint({
    dataset <- datasetInput()
    if (input$dataset == "Auto")
    { data <- NULL }
    if (input$dataset == "Caravan")
    { data <- NULL }
    if (input$dataset == "College")
    {data <- lm(Apps~Private+Accept,data=College)}
    if (input$dataset == "CreditDefault")
    {data <- glm(default~student+balance+income,family="binomial",data=Default)}
    if (input$dataset == "Hitters")
    {data <- lm(Salary~AtBat+Hits,data=Hitters)}
    if (input$dataset == "Smarket")
    {data <- lm(Today~Lag1+Lag2,data=Smarket)}
    if (input$dataset == "Wage")
    {data <- lm(wage~year+age,data=Wage)}
    if (input$dataset == "Weekly")
    {data <- lm(Today~Lag1+Lag2,data=Weekly)}
    
    data  
  })
  
  
  output$distPlot <- renderPlot({  

    # draw the histogram with the specified number of bins
    
    if (input$dataset == "Auto")
    { hist(Auto$mpg, breaks = 10, col = 'green', border = 'black') }
    if (input$dataset == "Caravan")
    { plot(Caravan$Purchase) }
    if (input$dataset == "College")
    {hist(College$Apps, breaks = 10, col = 'green', border = 'black')}
    if (input$dataset == "CreditDefault")
    {plot(Default$student)}
    if (input$dataset == "Hitters")
    {hist(Hitters$Salary, breaks = 10, col = 'green', border = 'black')}
    if (input$dataset == "Smarket")
    {hist(Smarket$Today, breaks = 10, col = 'green', border = 'black')}
    if (input$dataset == "Wage")
    {hist(Wage$wage, breaks = 10, col = 'green', border = 'black')}
    if (input$dataset == "Weekly")
    {hist(Weekly$Today, breaks = 10, col = 'green', border = 'black')}
    
 
  })
  
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
})