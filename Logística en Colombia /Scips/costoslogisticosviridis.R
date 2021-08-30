setwd("~/Desktop/PNUD/SABIASQUE1/8.DocLogística")
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



don<- read_excel("costo.xlsx")
don$pais=factor(don$pais, levels=c("2010","2011", "2012", "2013", "2014", "2015", "2016" , "2017","2018"))
don$Impuesto=factor(don$Impuesto, levels=c("Impuestos al ingreso de las personas","Aportes de seguridad social","Otros impuestos  a bienes y servicios","Otros impuestos","Impuesos  sobre ingreso de empresas","Impuestos sobre la propiedad","Impuesto al valor agregado / bienes y servicios"))

don$lugar=factor(don$lugar, levels=c("Eje Cafetero","Pacífico Central", "Bogotá D.C", "Altiplano","Caribe Oriental","Antioquía","Santanderes","Tolima y Huila", "Amazonía" , "Pacífico Norte","Pacífico Sur","Caribe Central","San Andrés y Providencia","Caribe Occidental","Orinoquía"))





s<-ggplot(don, aes(x = lugar, y =val, fill =val )) +
  geom_bar(stat = "identity")+
  coord_flip()+
  theme(
    legend.position = "none",
    panel.border = element_blank(),
  ) +
  xlab("") +
  #ylab("Value of Y")+
  labs(x= "Año",
       y= "Porcentaje",
       color= "Población",
       #color= "Rango de edad",
       title= "Costo logístico por regiones ",
       #subtitle= "2010- 2018",
       caption= "Fuente: PNUD con base a Fedesarrollo")+
  theme_bw()+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  scale_y_continuous(labels = label_number(suffix = "%",scale = 1e-0))


s + scale_fill_viridis_c()+
  transition_reveal(along = lugar) 
