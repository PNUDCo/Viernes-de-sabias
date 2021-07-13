library(dplyr)
library(tidyverse)
library(ggplot2)
library("readxl")
library(scales)
library(gganimate)
library("readxl")
library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2)
require(maps)
require(viridis)
library(rio)
library(openxlsx)
install_formats()
library(ggrepel)
library(gganimate)
install.packages("colourpicker")
library(colourpicker)

setwd("~/Desktop/PNUD/SABIASQUE1/5. Vacunación2")
dir()
agro<- read_excel("vacpobres.xlsx")


agro$Respuesta <-factor(agro$Respuesta, 
                       levels = c("Si", "No", "Vacunado"))
agro$Actividad <-factor(agro$Actividad, 
                  levels = c("Pobre", "No Pobre"))

agro$Año <-factor(agro$Año, 
                   levels = c("2019", "2020"))


ggplot(agro,aes(Año,Porcentaje,fill=Respuesta))+geom_bar(stat = "identity",position = "stack")+facet_grid(~Actividad)+
  scale_y_continuous(labels = label_number(suffix = "%"))+
  labs(x= "Categoría",
      y= "Porcentaje (%)",
      title= "¿Está dispuesto(a) a vacunarse contra el coronavirus?",
      subtitle= "Mayo 2021",
      caption= "Fuente: PNUD con base en EPS (DANE) \n *La categoría Vacunado incluye aquellos que tienen al menos una dosis" )+
      theme_bw() +
       theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
        geom_text(aes(label = Porcentaje), vjust = 0, size=4)+

  
  








