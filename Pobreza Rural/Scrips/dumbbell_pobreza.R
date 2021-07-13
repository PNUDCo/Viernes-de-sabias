install.packages("ggalt")
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
library(dplyr)
library(ggplot2)
library(ggalt)

setwd("~/Desktop/PNUD/SABIASQUE1/4. Rural")
dir()

#-------------------------------------------------
#           Dumbbell para pobreza extrema 
#-------------------------------------------------

pobext<- read_excel("republi.xlsx")


blue <- "deepskyblue4"
red <- "deepskyblue"
percent_first <- function(x) {
  #x <- sprintf("%d%%", round(x))
  #x[1:length(x)] <- sub("%$", "", x[1:length(x)])
  x
}

pobext$Dominio <-factor(pobext$Dominio, levels = c("Cabeceras","Nacional","Rural"))
  

ggplot() +
  geom_segment(data=pobext, aes(y=Dominio, yend=Dominio, x=15, xend=17), color="#b2b2b2", size=0.15)+
  geom_dumbbell(data=pobext, aes(y=Dominio, x=SIN, xend=CON),
              size=1.5, color="#b2b2b2", size_x=4, size_xend = 4, colour_x = red, colour_xend = blue)+
              geom_text(data=filter(pobext, Dominio =="Rural"),
               aes(x=CON, y=Dominio, label="Con ayudas"),
               color=blue, size=3.5, vjust=-1.5, fontface="bold") +
               geom_text(data=filter(pobext, Dominio=="Rural"),
               aes(x=SIN, y=Dominio, label="Sin ayudas"),
               color=red, size=3.5, vjust=-1.5, fontface="bold")+
  geom_text(data=pobext, aes(x=SIN, y=Dominio, label=percent_first(SIN)),
            color=red, size=2.75, vjust=2.5) +
  geom_text(data=pobext, color=blue, size=2.75, vjust=2.5,
            aes(x=CON, y=Dominio, label=percent_first(CON)))+
  theme_bw() +
  theme(
    #panel.grid.major=element_blank(),
    panel.grid.minor=element_blank(),
    panel.border=element_blank(),
    axis.ticks=element_blank(),
    axis.text.x=element_blank(),
    plot.title=element_text(size = 16, face="bold"),
    plot.title.position = "plot",
    plot.subtitle=element_text(face="italic", size=12, margin=margin(b=12)),
    plot.caption=element_text(size=8, margin=margin(t=12), color="#7a7d7e")
  )+
  labs(x= "Incidencia",
        y= "Dominio",
       title= " Escenarios incidencia de la pobreza extrema ",
       subtitle= "Diferencia por el efecto de las ayudas del gobierno",
       caption= "Fuente: PNUD con base en  DANE \n Las ayudas incluyen las ordinarias y las extraordinarias, creadas por motivo de  la pandemia")+

    ##En caso de qie queramos poner una franja que nos diga el diferencial
 #geom_rect(data=pobext, aes(xmin=.5, xmax=.6, ymin=-Inf, ymax=Inf), fill="grey") +
  geom_text(data=pobext, aes(label=paste0(DIF, ""), y=Dominio, x=.55), fontface="bold", size=3) +
  geom_text(data=filter(pobext, Dominio=="Rural"), 
            aes(x=.55, y=Dominio, label="Diferencia"),
            color="black", size=3.1, vjust=-2, fontface="bold") 


  
  
  
#-------------------------------------------------
#         Dumbbell para pobreza monetaria
#-------------------------------------------------
dir()

pobext2<- read_excel("pobmont.xlsx")


blue <- "deepskyblue4"
red <- "deepskyblue"
percent_first <- function(x) {
  #x <- sprintf("%d%%", round(x))
  #x[1:length(x)] <- sub("%$", "", x[1:length(x)])
  x
}

pobext2$Dominio <-factor(pobext2$Dominio, levels = c("Cabeceras","Nacional","Rural"))


ha<- ggplot() +
  geom_segment(data=pobext2, aes(y=Dominio, yend=Dominio, x=42, xend=50), color="#b2b2b2", size=0.15)+
  geom_dumbbell(data=pobext2, aes(y=Dominio, x=SIN, xend=CON),
                size=1.5, color="#b2b2b2", size_x=4, size_xend = 4, colour_x = red, colour_xend = blue)+
  geom_text(data=filter(pobext2, Dominio =="Rural"),
            aes(x=CON, y=Dominio, label="Con ayudas"),
            color=blue, size=3.5, vjust=-1.5, fontface="bold") +
  geom_text(data=filter(pobext2, Dominio=="Rural"),
            aes(x=SIN, y=Dominio, label="Sin ayudas"),
            color=red, size=3.5, vjust=-1.5, fontface="bold")+
  geom_text(data=pobext2, aes(x=SIN, y=Dominio, label=percent_first(SIN)),
            color=red, size=2.75, vjust=2.5) +
  geom_text(data=pobext2, color=blue, size=2.75, vjust=2.5,
            aes(x=CON, y=Dominio, label=percent_first(CON)))+
  theme_bw() +
  theme(
    #panel.grid.major=element_blank(),
    panel.grid.minor=element_blank(),
    panel.border=element_blank(),
    axis.ticks=element_blank(),
    axis.text.x=element_blank(),
    plot.title=element_text(size = 16, face="bold"),
    plot.title.position = "plot",
    plot.subtitle=element_text(face="italic", size=12, margin=margin(b=12)),
    plot.caption=element_text(size=8, margin=margin(t=12), color="#7a7d7e")
  )+
  labs(x= "Incidencia",
       y= "Dominio",
       title= " Escenarios incidencia de la pobreza monetaria ",
       subtitle= "Diferencia por el efecto de las ayudas del gobierno",
       caption= "Fuente: PNUD con base en  DANE \n Las ayudas incluyen las  ordinarias y las extraordinarias creadas por motivo de  la pandemia")+
      transition_states(CON, transition_length = 4, wrap = T) +
      shadow_mark()
  
  
  
  
  ##En caso de qie queramos poner una franja que nos diga el diferencial
  #geom_rect(data=pobext, aes(xmin=.5, xmax=.6, ymin=-Inf, ymax=Inf), fill="grey") +
  geom_text(data=pobext2, aes(label=paste0(DIF, ""), y=Dominio, x=.55), fontface="bold", size=3) +
  geom_text(data=filter(pobext2, Dominio=="Rural"), 
            aes(x=.55, y=Dominio, label="Diferencia"),
            color="black", size=3.1, vjust=-2, fontface="bold") 











