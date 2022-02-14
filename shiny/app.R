library(shiny)
library(tidyverse)
library(readxl)
library(ggcorrplot)
library(patchwork)
library(gtools)
library(shinythemes)
library(bslib)
library(plyr)
library(stringr)
library(RColorBrewer)
library(writexl)
library(data.table)



thematic::thematic_shiny(font = "auto")



# Define UI ----
ui <- fluidPage(theme = bs_theme(  bg = "#8d9ff7", fg = "white", primary = "#FCC780",
                                   base_font = font_google("Space Mono"),
                                   code_font = font_google("Space Mono")),
                
                
  titlePanel("Billboard Top 3 and Song Features"),
  sidebarLayout(position = "right",
                sidebarPanel(em("This is an interactive Shiny App showing correlations between various song attributes of those that have had a peak rank of at least 3 on the Billboard Top 100, from Aug-1997 to Nov-2021."),
                            
                             
                            dateRangeInput("dates", h3("Date Range"), start = '1997-08-31', end = '2021-11-31'),
                             
                             
                             p(em("Acceptable date range is from 1997-08-31 to 2021-11-31"))
                            
                             
                             ),
                
                
                
                
                
                
                
                mainPanel(
                  
                  textOutput("selected_dates"),
                  plotOutput("selected_plot")
                ),
          
  )
)

# Define server logic ----
server <- function(input, output) {
  #Graphics themer
  bs_themer()
  
  output$selected_dates <- renderText({
    paste("You have selected", input$dates[1], " to ", input$dates[2])
  })
  
  
  output$selected_plot<- renderPlot({
    
    
          full<-read_excel('topfill.xlsx')
          #pmatrix
          p <- full %>%  filter(date >= input$dates[1] & date<=input$dates[2]) %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
            as.matrix() %>% cor(use="complete.obs") %>% cor_pmat()
          #corr matrix and plot
          plt <-full %>%  filter(date >= input$dates[1] & date<=input$dates[2]) %>% select(`peak-rank`, `weeks-on-board`, acousticness,danceability,energy,instrumentalness,liveness,loudness, tempo, speechiness, happiness) %>%
            as.matrix() %>% cor(use="complete.obs") %>%
            ggcorrplot(type = "lower", lab = TRUE, insig = "blank", p.mat = p) 
          plt
  
  }) 
}

# Run the app ----
shinyApp(ui = ui, server = server)