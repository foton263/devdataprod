library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  titlePanel("EU state financial statistics"),
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view. The helpText function is
  # also used to include clarifying text. Most notably, the
  # inclusion of a submitButton defers the rendering of output
  # until the user explicitly clicks the button (rather than
  # doing it immediately when inputs change). This is useful if
  # the computations required to render output are inordinately
  # time-consuming.
  sidebarLayout(
    sidebarPanel(
      selectInput("country", "Choose a country:", 
                  choices = c("AT","BE","BG","CY","CZ","DE","DK","EL","ES","FI","FR","HR")),
      selectInput("metric", "Choose a metric:", 
                  choices = c("General Government Debt","General Government Deficit")),
            
      helpText("Note: Select the EU country you want and following ",
               "you can select either it's Government debt or deficit",
               "press the update view button to update and review the time evolution of the metric.", 
               "may the R be with you..."),
      
      submitButton("Update View")
    ),
    
    # Show a summary of the dataset and an HTML table with the
    # requested metric. Note the use of the h4
    # function to provide an additional header above each output
    # section.
    mainPanel(
      h4("State Financial Risk Position"),
      plotOutput("view"),
      
      h4("Summary of Financial metric"),
      verbatimTextOutput("summary")
      
      
    )
  )
))