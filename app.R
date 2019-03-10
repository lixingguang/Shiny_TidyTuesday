#TidyTuesday
#Female earnings
#Shiny, first try

#Load libraries
library(tidyverse)
library(ggplot2)
library(dplyr)
library(gganimate)
library(extrafont)
library(readr)
library(shiny)
library(rsconnect)

rsconnect::setAccountInfo(name='silaarts', token='FE61546276A2C6BCDD069063C1F3FE54', secret='UARxg01EcfXWCn9MeRQfKnmxkELNeIi52YsWM4F6')

#Read file
female <- read.csv("https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-03-05/employed_gender.csv", stringsAsFactors = TRUE, header = TRUE)

#Subset of file
female2 <- subset(female, year %in% c(1970, 1980, 1990, 2000, 2010))

#Make data.matrix
names(female2)[1] <- ""
female2 <-data.matrix(female2)

#Make variabele year -> rownames
female3 <- female2[,-1]
rownames(female3) <- female2[,1]

#Ui
ui <- fluidPage(
    titlePanel('TidyTuesday:
               Employment through the years for females and males'),
    sidebarLayout(
      sidebarPanel(
      selectInput("region", "Type of employment by gender",
                  choices=colnames(female3)),
      hr(),
      helpText("Employment from 1970 to 2010, 
               Source: Bureau of Labor")),
  mainPanel(
    plotOutput("EmployeePlot")
  )
)
)

#Server
server <- function(input, output) {
  
#Fill in the spot we created for the barplot
output$EmployeePlot <- renderPlot ({
  palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
            "#FF7F00", "#FFFF33"))
    
#Barplot
barplot(female3[,input$region], 
            main="",
            col = "darkmagenta", border = "black",
            ylab="% employed",
            xlab="year")
  })
}

#Run it
shinyApp(ui, server)








