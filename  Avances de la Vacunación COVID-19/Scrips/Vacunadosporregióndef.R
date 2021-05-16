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
setwd("~/Desktop/RPNUD")
dir()

####Desocupados
depto<- read_excel("departavac2_.xlsx")
depto<-tbl_df(depto)
head(deptoTB)
depto$date<- as.Date(depto$date)
head(difjoveTB)
class(date)

ggplot(depto,aes(x=date, y=value))+
  geom_line()

####HAgo el grafico final pero sin lienas vline 
ss1<-subset(ocdifjoveTB,Date>as.Date("2020/02/17"))

ss2<-subset(depto,date>as.Date("2021/03/17"))
ggplot(data=ss2,aes(x = date,y = porce ,col = Departamento)) +
  geom_smooth(se=F)+
  facet_wrap(~Región)+
  scale_y_continuous(labels = label_number(suffix = "%"))+
  xlab(label='dates')+
  #scale_y_continuous(labels = label_number(suffix = "c",scale = 1e-4))+
  scale_x_date(date_labels = "%m-%d")+
  labs(x= "Fecha",
       y= "Porcentaje de población",
       color= "Departamento",
       title= "Porcentaje de la población con almenos una dosis aplicada por región",
       subtitle= "Corte 3 de mayo",
       caption= "Fuente: PNUD con base en MinSalud y DANE \n No incluye las dosis de las ciudades de Bogotá, Barranquilla, Cartagena y Buenaventura")+
        theme_bw() +
        theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
        anim_save("regionestot_mayo8.png",height = 5, width = 7, units = "in", res = 150, dpi=1000)

  ss+
  anim_save("regiones52_mayo.png",height = 5, width = 7, units = "in", res = 150, dpi=1000)










