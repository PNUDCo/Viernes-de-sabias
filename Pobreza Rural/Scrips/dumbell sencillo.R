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

setwd("~/Desktop/RPNUD/archovs indsumo viernes2")
dir()
pobext<- read_excel("PobrezaExtrema.xlsx")



dotchart(pobext$`Ayudas extraordinarias`, labels = pobext$Dominio, pch = 21, bg = "green", pt.cex = 1.5)


#Gráficas conjuntas


dotchart(pobext$`Ayudas extraordinarias`, pch = 21, labels = pobext$Dominio,bg = "green", pt.cex = 1.5, xlim = range (pobext$`Sin ayudas`,pobext$`Ayudas extraordinarias`)+ c(-2,2)) points(pobext$`Sin ayudas, 1:nrow(pobext), col ="red",pch =19, cex = 1.5)


dotchart(datos$sold, pch = 21, labels = datos$mes, bg = "green",pt.cex = 1.5, xlim = range(datos$esperado, datos$vendido) + c(-2, 2))points(datos$esperado, 1:nrow(datos), col = "red", pch = 19, cex = 1.5)



### funciona dos 


dotchart(pobext$vendido, pch = 21, labels = pobext$Dominio, bg = "green",
         pt.cex = 1.5, xlim = range(pobext$vendido, pobext$esperado) + c(-2, 2))
points(pobext$esperado, 1:nrow(pobext), col = "red", pch = 19, cex = 1.5)


## funcuona 3

<-dotchart(pobext$vendido, labels = pobext$Dominio, pch = 21, bg = "green",
         xlim = range(pobext$esperado, pobext$vendido) + c(-2, 2),
         pt.cex = 1.5)
a
plot 
points(pobext$esperado, 1:nrow(pobext), col = "red", pch = 19, cex = 1.5)

invisible(sapply(1:nrow(pobext), function(i) {
  segments(min(pobext$vendido[i], pobext$esperado[i]), i,
           max(pobext$vendido[i], pobext$esperado[i]), i, lwd = 2)
  text(min(pobext$vendido[i], pobext$esperado[i]) - 1.0, i,
       labels = min(pobext$vendido[i], pobext$esperado[i]))
  text(max(pobext$vendido[i], pobext$esperado[i]) + 1.0, i,
       labels = max(pobext$vendido[i], pobext$esperado[i]))
}))

points(pobext$esperado, 1:nrow(pobext), col = "red",
       pch = 19, cex = 1.5)
points(pobext$vendido, 1:nrow(pobext), col = "red",
       pch = 21, bg = "green", cex = 1.5)



## geo segment 
ggplot(pobext,aes(esperado,Dominio,fill=esperado))+
  geom_bar(stat = "identity",position = "dodge")+


### dumbbell definitiva
  
  ggplot(pobext, aes(x=esperado, xend=vendido, y=Dominio)) + 
  geom_segment(aes(x=esperado, xend=vendido, y=Dominio, yend=Dominio),
  color="#b2b2b2", size=1.5)+
  geom_dumbbell(color="grey", 
                size_x=4.5, 
                size_xend = 4.5,
                #Note: there is no US:'color' for UK:'colour' 
                # in geom_dumbbel unlike standard geoms in ggplot()
                colour_x="deepskyblue4", 
                colour_xend = "deepskyblue")+
  labs(x=NULL, y=NULL, 
       title="Dumbbell Chart", 
       subtitle="Pct Change: 2013 vs 2014")+
  geom_text(color="black", size=3, hjust=-0.5,
            aes(x=esperado, label=esperado))+
  geom_text(aes(x=vendido, label=vendido), 
            color="black", size=3, hjust=1.5)








