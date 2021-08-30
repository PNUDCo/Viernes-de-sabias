setwd("~/Desktop/PNUD/SABIASQUE1/5. Vacunación2")
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

EDAD<- read_excel("des3.xlsx")
view(EDAD)
#EDAD$tasa=factor(EDAD$tasa, levels=c("Total","Hombres","Mujeres"))
EDAD$tasa=factor(EDAD$tasa, levels=c("Ocupados","Desocupados"))

EDAD$Fecha<- as.Date(EDAD$Fecha)


lm<- ggplot(EDAD, aes(x = Fecha, y = valor,label=sprintf("%0.2f", round(valor, digits = 2))))+ 
  geom_line(aes(color = tasa), size = 1, se = FALSE)+
  #geom_point(aes(color = edad))+
  #geom_area(aes(color = variable, fill = variable),alpha = 0.5, position = position_dodge(0.8)) +
 #geom_text(label = as.character(EDAD$Valor), size=3, vjust= 2, check_overlap = T)+
  #geom_text(aes(label = scales::comma(value)), size=3, vjust= 2, hjust=0.1, check_overlap = T) +
  #scale_y_continuous(labels = label_number(suffix = "%",scale = 1e-0))+
  #scale_y_continuous(labels = comma)+
  labs(x= "Año",
       y= "Millones de personas",
       color= "Población",
       title= "Población ocupada Vs. desocupada ",
       subtitle= "Serie desestacionalizada total nacional. Enero (2019)- Junio (2021)",
       caption= "Fuente: PNUD con base GEIH, DANE")+
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-3))+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())
        

  
lm + scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))

transition_reveal(along = Fecha) +
  shadow_mark()


ggplot(EDAD, aes(x = Fecha, y = Valor,label=sprintf("%0.2f", round(Valor, digits = 2))))+ 
  geom_smooth(aes(color = edad), size = 1, se = FALSE)+
  transition_reveal(along = Fecha) +
  shadow_mark()













