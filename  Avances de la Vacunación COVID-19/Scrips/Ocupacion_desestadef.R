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

dir()

####Desocupados
difjove<- read_excel("timeserdes2021_ax.xlsx")
difjoveTB<-tbl_df(difjove)
head(difjoveTB)
difjoveTB$Date<- as.Date(difjoveTB$Date)
head(difjoveTB)

ggplot(difjoveTB,aes(x=Date, y=value))+
  geom_line()

####HAgo el grafico final pero sin lienas vline     

ss<-subset(difjoveTB,Date>as.Date("2019/03/01"))
  ggplot(data=ss,aes(x = Date,y = value ,col = variable)) +
         geom_line()
  
  
  
###hasta aca ya estan las dos series de desempleo
  
#####################################
######gaficas con  lineas  verticales 
  
Vertical <- ggplot(data=ss,aes(x = Date,y = value ,col = variable)) +
    geom_line(lwd=1)
  
Vertical

dates_vline <- as.Date(c("2020-03-12","2021-02-01"))
dates_vline <- which(difjoveTB$Date %in% dates_vline)

Vertical+
  geom_vline(xintercept = as.numeric(difjoveTB$Date[dates_vline]),
             linetype=4, colour="black")+
        scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-3))+
        scale_x_date(date_labels = "%Y-%m")+
        labs(x= "fecha",
        y= "Milldesones de personas",
        color= "Dominio geográfico",
       title= "Comportamiento de los desocupados en el Total nacional y 13 ciudades",
       subtitle= "Marzo 2019 - Marzo 2021 (serie desestacionalizada)",
       caption= "Fuente: PNUD con base en GEIH")+
      theme_bw() +
        theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
        geom_vline(xintercept = as.numeric(as.Date("2020-07-01")), linetype=4)+
        geom_vline(xintercept = as.numeric(as.Date("2020-03-01")), linetype=4)


Vertical + 
  transition_states(value, transition_length = 4, wrap = FALSE) +
  shadow_mark()
              
##################################################
#######ocupadoss
##################################################
dir()
ocdifjove<- read_excel("timeseroc2021_ax2.xlsx")
ocdifjoveTB<-tbl_df(ocdifjove)
head(ocdifjoveTB)
ocdifjoveTB$Date<- as.Date(ocdifjoveTB$Date)


ggplot(ocdifjoveTB,aes(x=Date, y=value))+
  geom_line()


ss2<-subset(ocdifjoveTB,Date>as.Date("2019/03/01"))
ggplot(data=ss2,aes(x = Date,y = value ,col = variable)) +
  geom_line()


Vertical2 <- ggplot(data=ss2,aes(x = Date,y = value ,col = variable)) +
  geom_line(lwd=1)

Vertical2

#dates_vline <- as.Date(c("2020-03-12","2020-04-01"))
#dates_vline <- which(ocdifjoveTB$Date %in% dates_vline)

Vertical2+
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-3))+
  scale_x_date(date_labels = "%Y-%m")+
  labs(x= " ",
       y= "Millones de personas",
       color= "Dominio geográfico",
       title= "Comportamiento de los ocupados en el Total nacional y 13 ciudades",
       subtitle= "Marzo 2019 - 2021 (serie desestacionalizada)",
       caption= "Fuente: PNUD con base en GEIH")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
        geom_vline(xintercept = as.numeric(as.Date("2021-01-01")), linetype=4)+
        geom_vline(xintercept = as.numeric(as.Date("2020-06-01")), linetype=4)
  


Vertical2+
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-3))+
  scale_x_date(date_labels = "%Y-%m")+
  labs(x= " ",
       y= "Millones de personas",
       color= "Dominio geográfico",
       title= "Comportamiento de los ocupados en el Total nacional y 13 ciudades",
       subtitle= "Marzo 2019 - 2021 (serie desestacionalizada)",
       caption= "Fuente: PNUD con base en GEIH")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  geom_vline(xintercept = as.numeric(as.Date("2020-04-01")), linetype=4)+
  geom_vline(xintercept = as.numeric(as.Date("2020-02-01")), linetype=4)+
  geom_vline(xintercept = as.numeric(as.Date("2020-12-01")), linetype=4)+



######### definitia

myplot<-Vertical2+
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-3))+
  scale_x_date(date_labels = "%Y-%m")+
  labs(x= " ",
       y= "Millones de personas",
       color= "Dominio geográfico",
       title= "Comportamiento de los ocupados en el Total nacional y 13 ciudades",
       subtitle= "Marzo 2019 - 2021 (serie desestacionalizada)",
       caption= "Fuente: PNUD con base en GEIH")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  geom_vline(xintercept = as.numeric(as.Date("2020-04-01")), linetype=4)+
  geom_vline(xintercept = as.numeric(as.Date("2021-01-01")), linetype=4)+
  #geom_vline(xintercept = as.numeric(as.Date("2020-12-01")), linetype=4)+


 
  
  
  
  
  
  
  