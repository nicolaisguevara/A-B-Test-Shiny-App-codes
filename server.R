shinyServer(function(input, output) {          
        # Calculation of z-score
        # c1 number of conversion in control page
        # c2 number of conversion in test page
        # n1 is the size of the control page
        # n2 is the size of the test page
        # conversion rates (proportion) 
        output$pvalue  <- renderPrint({
                in1 <- input$n1
                in2 <- input$n2      
                p1 <- input$c1/in1
                p2 <- input$c2/in2         
                # Pooled sample proportion
                pool <-  (p1 * in1 + p2 * in2) / (in1 + in2)              
                # p1 is the conversion rate (proportion) of the control page
                # p2 is the conversion rate (proportion) from test page                          
                # Standard error                
                Se <-  sqrt( pool * ( 1. - pool ) * (( (1./in1) + (1./in2) )))              
                # Z-score
                Z_score <- (p2 - p1) / Se       
                p_value <- pnorm(Z_score,lower.tail = F)*100
                return(p_value)
                })
        output$slevel  <- renderPrint({input$sl})
        output$signif  <- renderText({
        in1 <- input$n1
        in2 <- input$n2      
        p1 <- input$c1/in1
        p2 <- input$c2/in2         
        # Pooled sample proportion
        pool <-  (p1 * in1 + p2 * in2) / (in1 + in2)              
        # p1 is the conversion rate (proportion) of the control page
        # p2 is the conversion rate (proportion) from test page                          
        # Standard error                
        Se <-  sqrt( pool * ( 1. - pool ) * (( (1./in1) + (1./in2) )))              
        # Z-score
        Z_score <- (p2 - p1) / Se       
        options(scipen = 1, digits = 3)
        p_value <- pnorm(Z_score,lower.tail = F)*100
        #paste("p-value is", as.character(p_value))
        is1 <- input$sl
        if (p_value < is1 ) 
                {result_sign ="YES (p-value < significance level) ->TIME TO CHANGE TO THE TEST WEB PAGE"}
        else
                {result_sign = "NO (p-value > significance level) ->KEEP USING THE CONTROL WEB PAGE"}
        return(result_sign)
        })      
        output$conversionPlot <- renderPlot({      
                #         output$conversionPlot <- reactive(function(){      
                # Render a barplot 
                p1 <- input$c1/input$n1
                p2 <- input$c2/input$n1                            
                v <- c(p1,p2)
                par(las=2) # make label text perpendicular to axis
                par(mar=c(5,8,4,2)) # increase y-axis margin.
                barplot(v, main="Conversion Rates", 
                      horiz=TRUE, 
                      names.arg=c( "Control Page", "Test Page"), 
                      col=c("darkblue","red"),
                      cex.names=1.2,
                      border = TRUE)
        })           
  }
)
