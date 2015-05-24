library(shiny)
library(SmarterPoland)
 

# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output) {
  
  selcountry<- reactive({
      toString(input$country)
    })
  selmetric<-reactive({
      switch(input$metric,
             "General Government Debt" = "NA-GDEBT",
             "General Government Deficit" = "NA-GDEF"
             )
    })
  EurostatTOC <- getEurostatTOC()
  code="ei_naga_a"
  data <- getEurostatRCV(kod = code)
  mydata<- reactive({
     a<-subset(data,data$geo %in% input$country) # & (data$indic %in% input$metric) & (data$unit == "MIO-EUR"),]
     a<-droplevels(a)
     return(a)
     }) 
    
  

  output$view <- renderPlot({
    
    plot(x=mydata()$time,
         y=mydata()$value,
         xlab = "Fiscal Year",
         main = paste0("Financial metric - ",toString(input$metric)))
  })

  # Generate a summary of the dataset
  output$summary <- renderPrint({
    summary(mydata()$value)
  })
  
})
