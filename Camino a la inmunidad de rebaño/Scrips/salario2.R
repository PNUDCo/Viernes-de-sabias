install.packages
install.packages("tidyverse")
install.packages("dplyr")
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
install.packages("scales")
library("scales")
library(ggrepel)
devtools::install_github("AliciaSchep/gglabeller") 
library(gglabeller)
library(ggplot2)
library(ggrepel)

setwd("~/Desktop/PNUD/SABIASQUE1/4. Rural")
dir()
polar<- read_excel("salario.xlsx")



h2<-ggplot(polar, aes(x = date, y = value))+ 
  geom_line(aes(color = variable), size = 1)+
  geom_point(aes(color = variable))+
  #geom_text(label = as.character(polar$value), size=3, vjust= 2, check_overlap = T)+
  geom_text(aes(label = scales::comma(value)), size=2, vjust= 2, hjust=0.1, check_overlap = T) +
  scale_y_continuous(labels = label_number(suffix = "",scale = 1e-0))+
  scale_y_continuous(labels = comma)+
  labs(x= "Año",
       y= "Salario en pesos constantes",
       color= "Dominio geográfico",
       title= "Ingreso laboral promedio de la población ocupada por dominio",
       subtitle= "Cifras en precios constantes",
       caption= "Fuente: PNUD con base a GEIH y FILCO \n  *Precios base 2018")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())

gglabeller_example <- gglabeller(h2, aes(label = rownames(value)))
 
  
  
  
  
  
  
  
  
  
  
  











  
  
  
 transition_states(date, transition_length = 3, wrap = FALSE) +
        shadow_mark()


  
  scale_color_manual(values = c("#00AFBB", "#E7B800")) +
  theme_minimal()



