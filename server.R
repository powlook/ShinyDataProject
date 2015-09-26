library(shiny)
library(ggplot2)

## Read results into R 
election <- read.csv("Election Results.csv",sep=";",header=TRUE,stringsAsFactors = FALSE)

shinyServer(
  function(input, output) {
##    value <- reactive({as.character(input$checkGroup)})
    output$results <- renderPlot({
      p <-  ggplot() +
        labs(title = "Singapore Election Results 2015") +
        theme(legend.title=element_blank()) +
        theme(axis.text.x=element_text(angle=60,hjust=1)) +
        xlab("Electoral Division") +
        ylab("Percentage")
     if (length(grep("1",input$checkGroup))>0) {
        p <- p + geom_line(data=election, aes(x=Electoral.Division,y=PAP.Actual,col="PAP",group=1))}
     if (length(grep("2",input$checkGroup))>0) {
        p <- p + geom_line(data=election, aes(x=Electoral.Division,y=Opp.Actual,col="Opp",group=2))}
     if (length(grep("3",input$checkGroup))>0) {
        p <- p + geom_line(data=election, aes(x=Electoral.Division,y=Predicted,col="Predict", group=3))}
     if (length(grep("4",input$checkGroup))>0) {
        p <- p + geom_line(data=election, aes(x=Electoral.Division,y=GE2011,col="GE2011", group=4))}
      p
        
    })
    
    output$regression <- renderPlot({
      p <- ggplot(election,aes(Percent.Blogs,PAP.Actual)) +
        geom_point() +
        geom_hline(yintercept=50,colour="red") +
        stat_smooth(method=lm,se=FALSE,colour="green",group=1) +
        xlab("Percentage of Media Chatter about PAP") +
        ylab("Percentage of Votes by PAP") +
        geom_text(aes(label=Electoral.Division),vjust=1)
      p
    })
    
    
    output$Wins <- renderPlot({
      pred_results <- glm(election$Results~election$Percent.Blogs,family="binomial")
     p <- ggplot(election, aes(Percent.Blogs,pred_results$fitted),pch=19,col="blue") +
        geom_point() +
        geom_line() +
        xlab("Percentage of Media Chatter about PAP") +
        ylab("Probability of Win") +
        geom_text(aes(label=No.),vjust=1,size=4)
      p
    }) 
    
    output$table <- renderTable({
      election[,c(1,2)]
    })
    
  })
