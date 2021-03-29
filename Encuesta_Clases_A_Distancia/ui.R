library(shiny)


# Define UI for application that draws a histogram
shinyUI(
    
    pageWithSidebar(
        headerPanel("Encuesta Sobre las Clases a Distancia"), #Funcion para el titulo principal de la app
        sidebarPanel(
            selectInput("variable", "Tabla a buscar:",  #funcion para el menu desplegable que permite cambiar de tabla para la busqueda en la bd
                        c("Consideras a tus dosentes capacitados?" = "select Consideras_a_los_docentes_capacitados from [dbo].[consideras_que_tus_docentes_est$]",
                          "Nivel de Experiencia" = "select Experiencia from [dbo].[cual_es_tu_experiencia$]",
                          "Que estrategia Propondrias" = "select Que_estrategias from [dbo].[estrategias$]",
                          "Incovenientes" = "select incovenientes_ultimo_semestre from [dbo].[inconvenientes$]",
                          "Universidad de Procedencia" = "select Universidad_de_procedencia from [dbo].[universidad_a_la_que_pertenece$]"))
        ),
        mainPanel(
            tabsetPanel( #funcion para la navegacion interna de la pagia "pestañas"
                tabPanel("Grafica de BARRAS", 
                         plotOutput("grafico1")), #funcion para desplegar los plots con los que se hicieron las tablas buscando un id
                tabPanel("Grafica de Pastel", plotOutput("grafico")),
                tabPanel("Grafica 3", plotOutput("histo"))
                
                
            )
            
        )
        
    )
)
