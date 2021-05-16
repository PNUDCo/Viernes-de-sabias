
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


dir()

polar<- read_excel("totalvacudepto.xlsx")
#difjoveTB<-tbl_df(difjove)
head(difjove)
view(difjove)


levels(polar$Lugar)
polar$Lugar=factor(polar$Lugar, levels=c("Barranquilla","Bogotá","Cartagena","Santa Marta","Buenaventura","Amazonas","Antioquia","Arauca","Atlántico","Bolívar","Boyacá","Caldas","Caquetá","Casanare","Cauca","Cesar","Chocó","Córdoba","Cundinamarca","Guainía","Guaviare","Huila","La Guajira","Magdalena","Meta","Nariño","Norte de Santander","Putumayo","Quindío","Risaralda","San Andrés y Providencia","Santander","Sucre","Tolima","Valle del Cauca","Vaupés","Vichada"))
levels(difjove$población)



bar<-ggplot(data=polar, aes(x= Total_vacunados, y= Lugar, fill=Lugar))+
  geom_bar(stat="identity", position="dodge")+
  scale_x_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Total vacunados ",
       y= "Departamento",
       col= "Lugar",
       title= "Total  de dosis aplicadas en Colombia",
       subtitle= "Cifra a corte 3 de mayo de 2021",
       caption= "Fuente: PNUD con base en MinSalud")+
       theme_bw() +
         theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())


+
        geom_text(aes(label = Total_vacunados , x = Total_vacunados + 1), position = position_dodge(1),vjust = 1)
        

bar + 
  transition_states(Razón, transition_length = 9) +
  shadow_mark()


####Esta transición  entre todas las de hombre y mujer

gph + 
  transition_states(población, transition_length = 4, wrap = FALSE) +
  shadow_mark()