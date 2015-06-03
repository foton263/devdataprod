library(shiny)
library(SmarterPoland)
EurostatTOC <- getEurostatTOC()
code="ei_naga_a"
data <- getEurostatRCV(kod = code) 

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
  
  dd<- reactive ({ 
    a<-subset(data, (geo %in% selcountry()) & (indic %in% selmetric() )) 
    return(a)
  })
                   
  output$view <- renderPlot({
      plot(x=dd()$time,
         y=dd()$value,
         xlab = "Fiscal Year",
         main = paste0("Financial metric - ",toString(input$metric)))
  })

  # Generate a summary of the dataset
  output$summary <- renderPrint({
    summary(dd()$value)
  })
  
})
