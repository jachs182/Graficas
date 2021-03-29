#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(RODBC)
library(RMySQL)
library(graphics)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    datos <- reactive({
        #conexion con la bd
        conexion <- odbcConnect("Clases_Distancia", uid="root", pwd="1234")
        #consulta a las columnas
        tabla <- input$variable #variable para guardar el input del menu desplegable de la app
        qr <- sqlQuery(conexion, tabla)
        
    })
    
    #funcion para renderizar la informacion como una tabla
    output$tbtable <- renderTable({
        #revisar si la tabla no esta vacia
        if(is.null(datos())){
            return()
        }
        #si no esta vacia retornamos la informacion como una tabla
        datos()
    })
    
    #funcion para renderizar la tabla como un plot para hacer las graficas
    output$grafico1 <- renderPlot({
        
        #revisa si no esta vacia
        if(is.null(datos())){
            return()
        }
        
        barplot(table(datos()))
        
    })
    
    ##########GRAFICO 2###################################
    

    data_table3 <- reactive({
        conn2 <- odbcConnect("Clases_Distancia", uid="root", pwd="1234")

        te2 <- input$variable
        qr2 <- sqlQuery(conn2, te2)

    })

    output$grafico <- renderPlot({

        #revisar si no esta vacia
        if(is.null(data_table3())){
            return()
        }

        pie(table(data_table3()), clockwise = TRUE, main = "Grafica Pastel"  ) #funcion "pie" para grafica de pastel 
    })
    
    #############################Grafico 3 ###########################################
    
    
    data_table4 <- reactive({
        conn3 <- odbcConnect("Clases_Distancia", uid="root", pwd="1234")
        
        te3 <- input$variable
        qr3 <- sqlQuery(conn3, te3)
        
    })
    
    output$tabla_his <- renderTable({
        #revisar si la tabla no esta vacia
        if(is.null(data_table4())){
            return()
        }
        data_table4()
    })
    
    output$histo <- renderPlot({
        
        #revisar si la mydata no esta vacia
        if(is.null(data_table4())){
            return()
        }
        
        plot(table(data_table4()) ) 
        
       
    })

})
