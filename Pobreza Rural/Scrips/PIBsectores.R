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
valadd<- read_excel("valor agregado.xlsx")


valadd$`Actividad económica` <-factor(valadd$`Actividad económica` , 
                  levels = c("Agricultura, ganadería, caza, silvicultura y pesca", "Minería", "Industrias manufactureras", "Suministro electricidad, gas, vapor", "Construcción", "Comercio",
                             "Información y telecomunicaciones", "Actividades financieras","Actividades inmobiliarias","Actividades profesionales, científicas y técnicas","Administración pública y defesa y salud","Actividades artísticas"))


valadd$mes <-factor(valadd$mes, levels = c("Ene-Mar", "Abr-Jun","Jul-Sep","Oct-Dic"))
#valadd$Trimestre <-factor(valadd$Trimestre, levels = c("I", "II","III","IV"))
#


ggplot(valadd,aes(Trimestre,`Tasa de crecimiento`,fill=`Actividad económica`))+
  geom_bar(stat = "identity",position = "dodge")+
  facet_grid(~mes)+
  scale_y_continuous(labels = label_number(suffix = "%"))+
  labs(y= "Porcentaje de variación",
       title= "Valor agregado por actividad económica  ",
       subtitle= "Tasa de crecimiento anual (%) en volumen. (2020)",
       caption= "Fuente: PNUD con base en DANE. Cuentas nacionales")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  transition_states(mes, transition_length = 3, wrap = FALSE) +
  shadow_mark()+
  anim_save("pibsect.gif",height = 5, width = 7, units = "in", res = 150, dpi=1000)
  
  
##### acá  pongo highlight en lo agro

ggplot(valadd,aes(Trimestre,`Tasa de crecimiento`,fill=`Actividad económica`))+
  geom_bar(aes(alpha=`Actividad económica`=="Agricultura, ganadería, caza, silvicultura y pesca"), stat = "identity",position = "dodge")+
  facet_grid(~mes)




