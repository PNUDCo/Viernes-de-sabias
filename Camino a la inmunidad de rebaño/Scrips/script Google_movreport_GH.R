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
setwd("~/Desktop/PNUD/SABIASQUE1/5. Vacunación2")
dir()

#Carga la base  del reporte de mobilidad en formato Excel
movcol1<- read_excel("mobreportcolombia.xlsx")
#Convierte la base de datos en un tibble
movcolTB<-tibble::as_tibble(movcol1)
head(movcolTB)
##convierte del fecha en formato UTC
head(movcolTB)
movcolTB$date<- as.Date(movcolTB$date)
head(movcolTB)
view(movcolTB)


###Renombra variables
movcolTB2<-rename(movcolTB, Lugar = cat)
#limpia el ruido creado por los missings
is.na(movcolTB2)
##verifica los niveles que tiene la variable Lugar
levels(movcolTB2$Lugar)
##Determina cuales son los niveles que quiere que tenga la variable Lugar
movcolTB2$Lugar=factor(movcolTB2$Lugar, levels=c("retail_and_recreation","parks","transit_stations","workplaces","residential", "grocery_and_pharmacy"))
levels(movcolTB2$Lugar)
##al hacer una trasnformación de la variable le vuelve a dar formato de fecha 
movcolTB2$date<- as.Date(movcolTB2$date)
movcolTB2$value<- as.numeric(movcolTB2$value)
#Renombra las variables que  utilizo como niveles de la variable lugar
movcolTB2$Lugar <- gsub("retail_and_recreation", "Tiendas de ocio", movcolTB2$Lugar)
movcolTB2$Lugar <- gsub("parks", "Parques", movcolTB2$Lugar)
movcolTB2$Lugar <- gsub("transit_stations", " Estaciones de transporte  ", movcolTB2$Lugar)
movcolTB2$Lugar <- gsub("workplaces", "Lugares de trabajo ", movcolTB2$Lugar)
movcolTB2$Lugar <- gsub("residential", "Zonas residenciales", movcolTB2$Lugar)
movcolTB2$Lugar<- gsub("grocery_and_pharmacy", "Supermercados y farmacias", movcolTB2$Lugar)

#Elabora la primera grafica  relación entre la fecha y el valor de los  niveles

ggplot(movcolTB2,aes(x=date, y=value))+
  geom_line()

#Le da formato de inicio  a la fecha  en la que comenzará la gráfica    
ll<-subset(movcolTB2,date>as.Date("2020/02/15"))

#Arregla el estilo de la gráfica, con temas colores y anotaciones en  los datos 
ggplot(data=ll,aes(x = date,y = value, colour = Lugar)) +
  geom_smooth()
  #geom_smooth(se= F)+
  scale_y_continuous(labels = label_number(suffix = "%", ,scale = 1e-3))+
  scale_x_date(date_labels = "%Y-%m")+
  labs(x= "Fecha",
       y= "Cambio porcentual",
       col= "Lugar",
       title= "Cambio porcentual de la movilidad promedio en Colombia",
       subtitle= " Febrero (2020) - Julio (2021)",
       caption= "Fuente: PNUD con base en Google Mobility Report")+
       theme_bw() +
        theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
        geom_hline(yintercept=0, linetype="dashed", color = "black")+
      
        transition_reveal(value, transition_length = 4, wrap = FALSE) +
        shadow_mark()+
        anim_save("movilidad5_mayo.gif",height = 5, width = 7, units = "in", res = 150, dpi=1000)










ll<-subset(movcolTB2,date>as.Date("2020/02/15"))
ggplot(data=ll,aes(x = date,y = value)) +
  geom_smooth()+
  scale_y_continuous(labels = label_number(suffix = "%"))+
  scale_x_date(date_labels = "%Y-%m")+
  labs(x= "Fecha",
       y= "Cambio porcentual",
       col= "Lugar",
       title= "Cambio porcentual de la movilidad promedio en Colombia",
       subtitle= "",
       caption= "Fuente: PNUD con base en Google Mobility Report")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  geom_hline(yintercept=0, linetype="dashed", color = "black")+
  transition_reveal(value, transition_length = 4, wrap = FALSE) +
  shadow_mark()+
  anim_save("movilidad5_mayo.gif",height = 5, width = 7, units = "in", res = 150, dpi=1000)

