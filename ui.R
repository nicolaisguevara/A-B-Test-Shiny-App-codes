require(markdown)
shinyUI(fluidPage(
        #headerPanel("A/B Test"),
        img(src="abtest.png", height = 70, width = 283),
        sidebarLayout(
        sidebarPanel( 
        # c1 number of conversion in control page
        # c2 number of conversion in test page
        # n1 is the number of visitor to the control page (size of the control page)
        # n2 is the number of visitor to the test page (size of the test page)
        numericInput('n1', 'Number of Visitors (Control Page)', 200, min = 15, step = 1),
        numericInput('n2', 'Number of Visitors (Test Page)', 195, min = 15, step = 1),
        numericInput('c1', 'Number of Conversion (Control Page)', 55,  min = 10, step = 1),
        numericInput('c2', 'Number of Conversion (Test Page)', 69,  min = 10, step = 1),          
        sliderInput('sl', 'Significance level (%)',value = 5, min = 1, max = 10, step = 1,)    
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel("Plot", plotOutput("conversionPlot")),
                        tabPanel("Results",
                                p("p-value (%)"), p(verbatimTextOutput("pvalue")),
                                p("Significance level (%)"), p(verbatimTextOutput("slevel")),
                                p("Is the difference statistical significant?"), p(verbatimTextOutput("signif")) ),
                        tabPanel("Documentation", includeMarkdown("documentation.md"))                        
                )
        )
)))
