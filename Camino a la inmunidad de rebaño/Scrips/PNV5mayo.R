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

polar<- read_excel("totalesdv2.xlsx")
#difjoveTB<-tbl_df(difjove)
head(difjove)
view(difjove)


levels(polar$Lugar)
polar$Categoría=factor(polar$Categoría, levels=c("Total dosis entregadas","Dosis aplicadas","Esquema completo de vacunación"))
levels(difjove$población)





bar<-ggplot(data=polar, aes(x= cantidad, y= Categoría, fill=Categoría))+
  geom_bar(stat="identity", position="dodge")+
  scale_x_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Cantidad en millones",
       col= "Lugar",
       title= "Plan Nacional de vacunación en cifras",
       subtitle= "Corte 4 de julio ",
       caption= "Fuente: PNUD con base en MinSalud")+
  theme_bw() +
    theme(
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank())+
         #geom_text(aes(label = cantidad , x = cantidad+ 1), position = position_dodge(0.9),vjust = 0, size=4)


sg<-bar + coord_flip()+
  anim_save("asignacionvaa52_mayo.png",height = 5, width = 7, units = "in", res = 150, dpi=1000)


sg + 
  transition_states(Categoría, transition_length = 9) +
  shadow_mark()


geom_text(
  aes(label = y, y = y + 0.05),
  position = position_dodge(0.9),
  vjust = 0
)

+
  geom_text(aes(label = Total_vacunados , x = Total_vacunados + 1), position = position_dodge(1),vjust = 1)





####Esta transición  entre todas las de hombre y mujer

gph + 
  transition_states(población, transition_length = 4, wrap = FALSE) +
  shadow_mark()