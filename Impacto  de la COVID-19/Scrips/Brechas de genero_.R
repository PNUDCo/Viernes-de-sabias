#-----------------------------------------------------
#       Limpiamos consola y llamamos las librerias 
#-----------------------------------------------------


rm (list=ls())
options(OutDec= ",")
setwd ("D:/Google Drive/PNUD/Mision Calidad/3 Marzo/Data lab/")


library(tidyr)
library(dplyr)
library(readxl)
library(ggplot2)
library(gganimate)
library(zoo)
library (scales)
library(ggpubr)


#-------------------------------------------------
#           llamamos la base de ocupados 
#-------------------------------------------------

ocupados <- read_excel("ocupados.xlsx")
ocupados <- ocupados%>%filter(med=="brecha") #organizamos por la variable que deseamos  analizar
ocupados$med <- NULL
ocupados <- ocupados%>%gather(brecha, by, -year, -mes)# Eleiminamos la variable año y mes de acuerdo a la varibla previamente identificada
ocupados$date <- paste(ocupados$year,ocupados$mes,"01", sep="-")#Establecemos  el origen del eje
ocupados$date <- as.Date(ocupados$date, format = "%Y-%m-%d") # Damos formato de fecha 
ocupados$brecha <- factor(ocupados$brecha,
                          levels=c("ocupados","inactivos","desocupados"),
                          labels=c("Tasa de ocupados",
                                   "Tasa de inactivos",
                                   "Tasa de descupados")) #  establecemos los nivles de  la  variable brecha 


#--------------------------------------------------
#         Generamos la gráfica TO
#--------------------------------------------------

o <-    
  ggplot(ocupados%>%filter(brecha=="Tasa de ocupados"), aes(x=as.Date(date, format="%Y/%m/d%"), # le damos formato a la fecha
                y=by, group=brecha, color=brecha))+
  geom_line(color="#003366",size=1)+
   geom_vline(xintercept=as.Date("2009-03-01"),linetype="dashed", color = "#003366")+  #introduccimos una linea verical 
  geom_vline(xintercept=as.Date("2020-07-01"),linetype="dashed", color = "#003366")+
  scale_x_date(breaks = date_breaks("12 months"),date_labels="%b %y")+   #establecemos la periodicidad de el eje de datos
  scale_y_continuous(labels = percent)+
 ggtitle("Brechas desestacionalizadas. Colombia 2007-2021") + 
  annotate(geom="text", x=as.Date("2020-03-01"), y=0.68, 
           label="68,5%", size=3) +
  annotate(geom="point", x=as.Date("2020-07-01"), y=0.68, size=5, shape=21, fill="transparent") +
  xlab("Mes") +ylab("")+
  theme(axis.line.y = element_blank(),
        axis.ticks =  element_blank(),
        plot.title = element_text(size =10, face = "bold", hjust = 0.5),
        axis.line.x =element_blank(),
        axis.title.y = element_text(size=10, hjust = 1, angle = 360),
        axis.title.x = element_blank(),
        axis.text.x=element_blank(),
        strip.background =element_blank(),
        strip.text = element_text(size = 7.5, face="bold"),
        legend.title=element_blank(),
        legend.key =element_blank(),         
        panel.background = element_blank()) 

#--------------------------------------------------
#         Generamos la gráfica TI
#--------------------------------------------------
i <-    
ggplot(ocupados%>%filter(brecha=="Tasa de inactivos"), aes(x=as.Date(date, format="%Y/%m/d%"), 
                     y=by, group=brecha, color=brecha))+
  geom_line(color="#265F91",size=1)+
  geom_hline(yintercept=0, color = "#BBBBBB")+
  geom_vline(xintercept=as.Date("2009-03-01"),linetype="dashed", color = "#003366")+
  geom_vline(xintercept=as.Date("2020-05-01"),linetype="dashed", color = "#003366")+
  scale_x_date(breaks = date_breaks("12 months"),date_labels="%b %y")+
  scale_y_continuous(labels = percent)+
  annotate(geom="text", x=as.Date("2019-12-31"), y=0.05, 
           label="5,6%", size=3) +
  annotate(geom="point", x=as.Date("2020-05-01"), y=0.05, size=5, shape=21, fill="transparent") +
  xlab("Mes") +ylab("")+
  theme(axis.line.y = element_blank(),
        plot.title = element_blank(),
        axis.ticks =  element_blank(),
        axis.line.x =element_blank(),
        axis.title.y = element_text(size=10, hjust = 1, angle = 360),
        axis.title.x = element_blank(),
        axis.text.x=element_blank(),
        strip.background =element_blank(),
        strip.text = element_text(size = 7.5, face="bold"),
        legend.title=element_blank(),
        legend.key =element_blank(),         
        panel.background = element_blank())


#--------------------------------------------------
#         Generamos la gráfica TD
#--------------------------------------------------


d <- 
ggplot(ocupados%>%filter(brecha=="Tasa de descupados"), aes(x=as.Date(date, format="%Y/%m/d%"), 
                                                           y=by, group=brecha, color=brecha))+
  geom_line(color="#003366")+
  #geom_hline(yintercept=0, color = "#BBBBBB")+
  geom_vline(xintercept=as.Date("2009-03-01"),linetype="dashed", color = "#003366")+
  geom_vline(xintercept=as.Date("2020-09-01"),linetype="dashed", color = "#003366")+
  #facet_grid(brecha~.)+  
  scale_x_date(breaks = date_breaks("12 months"),date_labels="%b %y")+
  scale_y_continuous(labels = percent)+
  #ggtitle("Brechas desestacionalizada: Tasa de descupados (%). Colombia 2007-2021") + 
  labs(caption = "Fuente:PNUD con base en DANE")+
  annotate(geom="text", x=as.Date("2020-09-01"), y=-0.495, 
           label="-48,4%", size=3) +
  annotate(geom="point", x=as.Date("2020-09-01"), y=-0.484, size=5, shape=21, fill="transparent") +
  xlab("Mes") +ylab("")+
  theme(axis.line.y = element_blank(),
        axis.ticks.y =  element_blank(),
        plot.title = element_blank(),
        axis.line.x = element_line(color = "#000000"),
        axis.title.y = element_text(size=10, hjust = 1, angle = 360),
        axis.title.x = element_text(size=10, hjust = 1),
        axis.text.x=element_text(angle=-90, hjust=0.001),
        strip.background =element_blank(),
        strip.text = element_text(size = 7.5, face="bold"),
        legend.title=element_blank(),
        legend.key =element_blank(),         
        panel.background = element_blank()) 

#--------------------------------------------------
#     Generamos una gráfica de  TO, TD y TI
#--------------------------------------------------
  ggarrange(o,i,d, 
                labels = c("Tasa de ocupados","Tasa de inactivos","Tasa de descupados"),
                ncol = 1, nrow = 3, align = "v",
                font.label = list(size = 7, face = "italic")
                              )

#--------------------------------------------------
#         Salvamos la gráfica
#--------------------------------------------------
  
ggsave("Brechas de genero.jpg", scale=1, width = 7, height = 5 , units = 'in', dpi=600)

