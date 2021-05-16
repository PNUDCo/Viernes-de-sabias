#-------------------------------------------
#   Limpiamos consola y llamamos librerias
#-------------------------------------------

rm (list=ls())
options(OutDec= ",")
setwd ("D:/Google Drive/PNUD/Mision Calidad/3 Marzo/Data lab/")


library(tidyr)
library(dplyr)
library(readxl)
library(ggplot2)
library(gganimate)
library(zoo)
library(ggthemes)
library(scales)
library(ggpubr)


#-------------------------------------------
#          Cargamos base de datos 
#-------------------------------------------

informales <- read_excel("informales.xlsx", sheet="Hoja1")

#Establecemos los niveles y les damos formato 
informales$tri <- factor(informales$tri,
                        levels=c(1,2,3,4,5,6,7,8,9,10,11,12),
                        labels=c("Enero-Marzo","Febrero-Abril","Marzo-Mayo",
                                 "Abril-Junio","Mayo-Julio","Junio-Agosto",
                                 "Julio-Septiembre","Agosto-Octubre",
                                 "Septiembre-Noviembre","Octubre-Diciembre",
                                 "Noviembre-Enero","Diciembre-Febrero")
                        )
#informales$formales <- informales$formales*100
#informales$informales <- informales$informales*100
#informales$ocupados <- informales$ocupados*100

informales$Formales <- NULL
informales$Informales <- NULL
informales$Ocupados <- NULL

informales <- informales%>%filter(year>2007)
informales <- informales%>%gather(var, val, -year, -tri)
informales$var <- factor(informales$var,
                         levels = c("ocupados","formales","informales"),
                         labels = c("Ocupados","Formales","Informales"))
informales <- informales%>%filter(var!="Ocupados")  



#-------------------------------------------
#          Elaboramos gráfica 
#-------------------------------------------
ggplot(informales,aes(x=year, y=tri, fill=val))+
  geom_tile(colour="white",size=0.25)+
  scale_y_discrete(limits=rev)+
  facet_grid(.~var)+
  guides(fill=guide_legend(title="Variaci?n trimestre a?o anterior"))+
  labs(x="A?o",y="", title="Varaici?n ocupados. 13 Ciudaddes y AM 2008-2020")+
  labs(caption = "Fuente:PNUD con base en DANE")+
  scale_fill_gradientn(colours= c("#d53e4f","#f46d43","#fdae61","#fee08b","#e6f598","#abdda4","#ddf1da" ), 
                       breaks=seq(-0.3,0.1,0.04),
                       limit=c(-0.3,0.1))+
  ggtitle("Variaci?n ocupados informales y formales trimestre a?o anterior. Colombia 2008-2020")+
  theme(axis.line.y = element_blank(),
        axis.ticks =  element_blank(),
        plot.title = element_text(size =10, face = "bold", hjust = 0.5),
        axis.line.x = element_line(color = "#000000"),
        axis.title.y =  element_blank(),
        axis.title.x = element_text(size=10, hjust = 1),
        axis.text.x=element_text(hjust=0.001),
        strip.background =element_blank(),
        strip.text = element_text(size = 7.5, face="bold"),
        legend.title=element_blank(),
        legend.key =element_blank(),  
        panel.background = element_blank()) 
ggsave("Informalidad.jpg", scale=1, width = 7, height = 5 , units = 'in', dpi=600) 
  