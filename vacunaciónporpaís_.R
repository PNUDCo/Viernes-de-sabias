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
library(xlsx)
library(plotly)

#Para borrar el ambiente de bases 
rm(list = ls())

## Llamamos las bases de datos de  en formato CVS separadas por comas 

vacucovid<- read.csv("coronavirus-data-explorer_2.csv", sep=",")

###corroboramos que nuestra base  este correctamente 
view(vacucovid)
##convertimos en Tibble la base
vacucovidTB<-tbl_df(vacucovid)

##Confirmamos que R leas las variables según us tipo 
head(vacucovidTB)
## Dado que la variable Date es una fecha, nos aseguramos que  sea leida como fecha 

vacucovidTB$date<- as.Date(vacucovidTB$date)
head(vacucovidTB)

#Elejimos las variables que usaremos para nuestro análisis 
## en este caso queremos las cilumans con los nombres continent,date,location, total_vaccinations,people_vaccinated,people_fully_vaccinated,new_vaccinations,population

vacucovidlatam<- vacucovidTB%>%dplyr::select(continent,date,location, total_vaccinations,people_vaccinated,people_fully_vaccinated,new_vaccinations,population)

#na vez elegidas las variables filtramos las columans que deseamos por un identificador en este caso nuestro identificador es "South America" 
##Una vez elegido  el identificador, le damos la orden de elegir las columnas que deseamos para nuestro analisis
vaclatam2 <- dplyr::select(filter(vacucovidlatam, continent == "South America" ),c(location,date, total_vaccinations,people_vaccinated,people_fully_vaccinated,new_vaccinations, population))

#Dado que hay filas que no queremos analizar, las eliminamso 
vaclatam4 <- parahacerpor_2[-c(2583:2649,2650:3059,3951:4358),]

#Como hay variables que estan en otro idioma les  hacemos  arreglos ortográficos 

vaclatam4$location <- gsub("Brazil", "Brasil", vaclatam4$location)
vaclatam4$location <- gsub("Peru", "Perú", vaclatam4$location)

#nos encargamos de  queitar el ruido que hacer los missings
na.omit(vaclatam4)

#Como tengo una variable de tiempo, debo  dar la orden desde que fecha queremos que comience 
#En este caso  elegimos 2021/01/01
ss<-subset(vaclatam4,date>as.Date("2021/01/01"))

# Al haber  elegido el periodo  graficamos 
# scale_x_date me  da el formato de la fecha en este caso queremos que muester año (%Y) y mes (%m)
ggplot(data= ss, aes(x= date, y = porce_b))+
  geom_line(aes(color = location))+
  scale_x_date(date_labels = "%Y-%m")

# Perfeccionamos nuestra gráfica pidiendo que  le asigne colores a la variable "location"
#agregamos etiquetas a los datos 
ss<-subset(vaclatam4,date>as.Date("2021/01/01"))
ggplot(data= ss, aes(x= date, y = porce))+
  geom_line(aes(color = location))+
  labs(x= "Mes",
       y= "Porcentaje vacunados",
       color= "País",
       title= "Poblaciónvacunada en Sur America",
       subtitle= "Vacunación por país",
       caption= "Fuente: PNUD con base en Global Change Data Lab")

#Para mejorar el estilo de la grafica
#decidimos darle  un tema  blanco de estilo > Theme_bw()
#Agregamos etiquetas a los datos dentro de la gráfica (geom_text)
#Le  agregamos una transición por la variable Date (esta debe estar en formato fecha ) > Transition_reveal
##La guardamos en  alta resolución > animsave



ss1<-subset(vaclatam4,date>as.Date("2021/01/01"))
ggplot(data= ss, aes(x= date, y = porce_b, color = location, label=sprintf("%0.2f",round(porce, digits = 2))))+
  geom_line(lwd=1)+
  geom_point()+
  scale_y_continuous(labels = label_number(suffix = "%"))+
  labs(x= "Mes",
       y= "Porcentaje",
       color= "País",
       title= "Porcentaje de población con dosis aplicadas en Sur América",
       subtitle= "Población relativa. (Corte 3 de mayo)",
       caption= "Fuente: PNUD con base en Global Change Data Lab")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  geom_text(label = as.character(ss1$porce_b), size=3, vjust= 2, check_overlap = T)+
  transition_reveal(along = date)+
  anim_save("dosisuramerica7_mayo.gif",height = 5, width = 7, units = "in", res = 150, dpi=1000)
