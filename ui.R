library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  titlePanel("Singapore Election Results 2015"),
  
  sidebarLayout(
    sidebarPanel(
    checkboxGroupInput("checkGroup",
                       label = h3("Click on the checkbox to display the choices"),
                       choices = list("PAP2015" = 1,"Opp2015" = 2,"Predict"= 3,"GE2011"  = 4),
                       selected = 1
                       )),
  
    mainPanel(
      tabsetPanel(type = "tabs",
           tabPanel("Plot",
            p("The Singapore General Election was held on 11 Sept 2015. General elections are held
               once every 4 - 5 years according to the Westminster System."),
            p("The following graphs below shows the performance of the ruling party (PAP) vs the results of the
               Opposition parties (Opp). There is a plot of PAP performance in 2011 (GE2011) and also a plot
               of the predicted results by book makers(Predicted) for the 2015 elections."),
            p("Use the SideBar Panel to select which plots you want to see"),
             plotOutput('results')),

           tabPanel("Linear Regression",
            p("The Plot showed the scatterplot of the percentage wins by the PAP against the percentage of the media
               exposure in terms of blogs and media posts. This percentage is calculated as a percentage for each
               Electoral Division"),
            p("The green line shows the linear regression line. There is a correlation between the votes received by the PAP vs the percentage of media chatter about them"),
            p("The horizontal red line represents the 50% popular votes. The 2 divisions below the red line also received the
               lowest percentage of blog share by PAP"),
               plotOutput('regression')),

           tabPanel("Logistic Regression",
            p("The Plot showed the logarithmic Regression of Win/Lose by the PAP versus the percentage of Blogs
               obtained."),
            p("The Logistic Regression gives a good prediction of electoral wins againsts the percentage
               of Blog Posts"),
            p("The Number in the plot shows the row from which the Electoral Division can be retrieved in the table below."),
              plotOutput("Wins"),           
              tableOutput("table"))
          )

  ))
))
