setwd("~/Desktop/PNUD/SABIASQUE1/7.crecimiento")
dir()




## instalo paquetes 

install.packages
install.packages("tidyverse")
install.packages("gifski")
install.packages("png")
install.packages("plyr")
install.packages("readxl")
install.packages("sf")
install.packages("raster")
install.packages("spData")
remotes::install_github("Nowosad/spDataLarge")
nstall.packages("tmap")
install.packages("leaflet")
install.packages("maps")
install.packages("viridis")
install.packages("viridisLite")
library(tidyverse)
library(dplyr)
library(gapminder)
library(ggplot2)
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


rm(list = ls())

actividad<- read_excel("indice.xlsx")
actividad$categoria=factor(actividad$categoria, levels=c("Terciarias","Secundarias","Primarias"))

actividad$Fecha<- as.Date(actividad$Fecha)

view(actividad)


lm<- ggplot(actividad, aes(x = Fecha, y = Valor,label=sprintf("%0.2f", round(Valor, digits = 2))))+ 
  geom_line(aes(color = categoria), size = 1, se = FALSE)+
  #geom_point(aes(color = edad))+
  #geom_area(aes(color = variable, fill = variable),alpha = 0.5, position = position_dodge(0.8)) +
  #geom_text(label = as.character(EDAD$Valor), size=3, vjust= 2, check_overlap = T)+
  #geom_text(aes(label = scales::comma(value)), size=3, vjust= 2, hjust=0.1, check_overlap = T) +
  scale_y_continuous(labels = label_number(suffix = "%",scale = 1e-0))+
  scale_y_continuous(labels = comma)+
  labs(x= "Mes",
       y= "Índice 100 = Febrero 2020",
       color= "Tipo de actividad económica",
       title= "Indicador de seguimiento a la economía (ISE)",
       subtitle= "Actividades primarias, secundarias y terciarias. Enero (2020) - Mayo (2021)",
       caption= "Fuente: PNUD con base a Indicador de Seguimiento a la Economía, DANE \nSerie ajustada por efecto estacional y calendario ")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())
  #geom_hline(yintercept=0, linetype="dashed", color = "black")+
  


lm + scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))+
  transition_reveal(along = Fecha) +
  shadow_mark()


lm + scale_color_viridis()



ggplot(EDAD, aes(x = Fecha, y = Valor,label=sprintf("%0.2f", round(Valor, digits = 2))))+ 
  geom_smooth(aes(color = edad), size = 1, se = FALSE)+
  transition_reveal(along = Fecha) +
  shadow_mark()













