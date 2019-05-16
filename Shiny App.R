library(shiny)
library(shinydashboard)

library(shinydashboard)


ui <- dashboardPage(
  dashboardHeader(title = "Apple Financials"),
  dashboardSidebar(
    fileInput("myFile",
              "Upload SAS data",
              accept = ("sas7bdat")),
              selectInput("xvar",
                          'X-axis Variable:',
                          choices = c('Sales',
                                      'Cash',
                                      'Assets',
                                      'Profits',
                                      'R&D',
                                      'SG&A'),
                          selected = 'Sales'),
    selectInput("yvar",
                'Y-axis Variable:',
                choices = c('Sales',
                            'Cash',
                            'Assets',
                            'Profits',
                            'R&D',
                            'SG&A'),
                selected = 'R&D'),
    radioButtons('modelselect',
                 'Choose the model',
                 choices = c('Linear Model',
                             'Loess',
                             'Robust Linear',
                             'None'),
                 selected = 'Loess',
                 inline = FALSE),
    checkboxInput('ribbon',
                  'Standard Error Ribbon',
                  value = TRUE)
  
  ),
  dashboardBody()

)


server <- function(input, output) {
  
  d1 = reactive({
    if (!is.null(input$myFile$datapath)) {
      read.sas7bdat(input$myFile$datapath)
    }
    else NULL
  })

  output$d1<- renderPlot({
  text <- paste("Please upload a SAS data file (sas7bdat extension) \n",                                  "Make sure that it has the following variables: \n",
                
                "SALEQ, CHEQ, ATQ, OIADPQ, XRDQ, XSGAQ")
  
  
  validate(need(!is.null(input$mydata), text))
  }
  )
  
  
  
  
}

shinyApp(ui, server)