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

setwd("~/Desktop/RPNUD/archovs indsumo viernes2")
dir()
agro<- read_excel("agronoagro.xlsx")


agro$Mes <-factor(agro$Mes, 
                       levels = c("Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre",
                                  "Noviembre", "Diciembre"))
agro$Actividad <-factor(agro$Actividad, 
                  levels = c("Agrícolas rurales", "No agrícolas rurales"))

agro$Año <-factor(agro$Año, 
                   levels = c("2019", "2020"))


ggplot(agro,aes(Año,Porcentaje,fill=Actividad))+geom_bar(stat = "identity",position = "stack")+facet_grid(~Mes)+
  scale_y_continuous(labels = label_number(suffix = "%"))+
  labs(x= "Mes",
      y= "Porcentaje",
      title= "Proporción de ocupados rurales en actividades agrícolas y no agrícolas,",
      subtitle= "Mayo - diciembre (2019 -2020)",
      caption= "Fuente: PNUD con base en GEIH")+
      theme_bw() +
       theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())
  
  








