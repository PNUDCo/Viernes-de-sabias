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

setwd("~/Desktop/PNUD/SABIASQUE1/4. Rural")
dir()

polar<- read_excel("quint2.xlsx")
#difjoveTB<-tbl_df(difjove)
head(difjove)
view(difjove)


levels(polar$Lugar)
polar$Fuente=factor(polar$Fuente, levels=c("Laboral","Otros","Ayudas institucionales","Ayudas hogares","IPV"))

polar$Quintil <-factor(polar$Quintil, levels = c("Q1", "","Jul-Sep","Oct-Dic"))

ggplot(data=polar, aes(x=Quintil, y=val, fill=Fuente))+
  geom_bar(stat="identity", position="dodge")+
  facet_grid(~Quintil)+


  
  
  ggplot(polar, aes(x=Quintil, y=val, fill=Fuente,group=Fuente, label=sprintf("%0.2f",round(val, digits = 2)))) + 
  geom_bar(position="stack", stat="identity")+
  theme_bw() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank())+
  geom_text(aes(label = val), position = position_stack(0.9),vjust = 0, size=4,check_overlap = TRUE )+
  scale_y_continuous(labels = label_number(suffix = "%"))+
  labs(x= "Quintil",
       col= "Lugar",
       title= "Contribuciones del ingreso real per-cápita  por fuentes de ingreso",
       subtitle= "Centros poblados y rural disperso (2019 -2020)",
       caption= "Fuente: PNUD con base en  GEIH")+
       transition_states(Fuente, transition_length = 3, wrap = FALSE) +
       shadow_mark()+
        anim_save("quintilrural.gif",height = 5, width = 7, units = "in", res = 150, dpi=1000)

  
  
  
  
  
  labs(x= "Contribuciones del ingreso real per- capita  por fuentes de ingreso",
       col= "Lugar",
       title= "Plan Nacional de vacunación en cifras",
       subtitle= "Corte 4 de mayo de 2021",
       caption= "Fuente: PNUD con base en  GEIH")
  transition_states(Quintil, transition_length = 3, wrap = FALSE) +
  shadow_mark()









bar<-ggplot(data=polar, aes(x=cat , y= Quintil 1, fill=cat))+
  geom_bar(stat="identity", position="dodge")+
  scale_x_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Asignaciones (en millones)",
       col= "Lugar",
       title= "Plan Nacional de vacunación en cifras",
       subtitle= "Corte 4 de mayo de 2021",
       caption= "Fuente: PNUD con base en MinSalud")+
  theme_bw() +
    theme(
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank())+
         geom_text(aes(label = cantidad , x = cantidad+ 1), position = position_dodge(0.9),vjust = 0, size=4)


sg<-bar + coord_flip()+
  anim_save("asignacionvaa52_mayo.png",height = 5, width = 7, units = "in", res = 150, dpi=1000)


gph + 
  transition_states(población, transition_length = 4, wrap = FALSE) +
  shadow_mark()
