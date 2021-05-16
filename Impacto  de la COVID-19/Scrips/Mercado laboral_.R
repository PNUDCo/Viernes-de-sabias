#-------------------------------------------
# Limpiamos consola y llamamos  librerias
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
library(magick)


#-------------------------------------------
#       Cargamos la base de datos
#-------------------------------------------

ml <- read_excel("empleo.xlsx")

#damos formato a las variables y  generamos niveles

ml <- ml%>%gather(var, val, -year,-mes)

ml$val <- ml$val/100
ml$date <- paste(ml$year,ml$mes,"01", sep="-")
ml$date <- as.Date(ml$date, format = "%Y-%m-%d")
ml$var <- factor(ml$var,
                 levels=c("TGP","TO","TD","tgp","to","td"),
                 labels=c("Tasa Global de Participaci?n","Tasa de Ocupaci?n",
                           "Tasa de Desempleo","tgp","to","td")
)
  

#-------------------------------------------
#          Elaboramos gráfica 
#-------------------------------------------

ml <-   ml%>%filter(year>=2010 &( var=="Tasa de Ocupaci?n"))
ml <- ggplot (ml, aes(x=as.Date(date, format="%Y-%m-%d"), y=val, group=var, color=var ))+
    geom_point(size=1, alpha=0.6)+
    geom_line()+
    scale_color_manual(values=c("#0B387C","#5A90DA"))+
    ggtitle("Tasa de Ocupaci?n. 2010-2021")+
    scale_y_continuous(labels = percent)+
    xlab("A?o") + ylab("%") + 
    labs(caption = "Fuente: PNUD con base en DANE")+
    scale_x_date(breaks= breaks_width("year"),labels = date_format("%Y"))+
    theme(axis.line.y = element_blank(),
          axis.line.x = element_line(color = "#000000"),
          axis.title.y = element_text(size=10, hjust = 1, angle = 360),
          axis.title.x = element_text(size=10, hjust = 1),
          strip.background =element_blank(),
          strip.text = element_text(size = 9),
          legend.title=element_blank(),
          legend.key =element_blank(),         
          panel.background = element_blank(),
          legend.position = "bottom")

#generamos  dinámica del gráfico 

ml <- ml+ transition_reveal(date) 

ml <- animate(ml, duration=15,renderer =gifski_renderer("Tasa de Ocupaci?n.gif"))+
        options(gganimate.dev_args = list(width = 7, height = 5, units = 'in', res=600))  



#-------------------------------------------
#          Cargamos base de datos
#-------------------------------------------
rm (list=ls())

ml <- read_excel("empleo.xlsx")

#damos formato a las variables y  generamos niveles

ml <- ml%>%gather(var, val, -year,-mes)

ml$val <- ml$val/100
ml$date <- paste(ml$year,ml$mes,"01", sep="-")
ml$date <- as.Date(ml$date, format = "%Y-%m-%d")
ml$var <- factor(ml$var,
                 levels=c("TGP","TO","TD","tgp","to","td"),
                 labels=c("Tasa Global de Participaci?n","Tasa de Ocupaci?n",
                          "Tasa de Desempleo","tgp","to","td"))




#-------------------------------------------
#          Elaboramos gráfico
#-------------------------------------------

ml <-   ml%>%filter(year>=2010 &( var=="Tasa de Desempleo"))
ml <- ggplot (ml, aes(x=as.Date(date, format="%Y-%m-%d"), y=val, group=var, color=var ))+
  geom_point(size=1, alpha=0.6)+
  geom_line()+
  scale_color_manual(values=c("#0B387C","#5A90DA"))+
  ggtitle("Tasa de Desempleo. 2010-2021")+
  scale_y_continuous(labels = percent)+
  xlab("A?o") + ylab("%") + 
  labs(caption = "Fuente: PNUD con base en DANE")+
  scale_x_date(breaks= breaks_width("year"),labels = date_format("%Y"))+
  theme(axis.line.y = element_blank(),
        axis.line.x = element_line(color = "#000000"),
        axis.title.y = element_text(size=10, hjust = 1, angle = 360),
        axis.title.x = element_text(size=10, hjust = 1),
        strip.background =element_blank(),
        strip.text = element_text(size = 9),
        legend.title=element_blank(),
        legend.key =element_blank(),         
        panel.background = element_blank(),
        legend.position = "bottom")

#Generamos dinámica

ml <- ml+ transition_reveal(date) 

ml <- animate(ml, duration=15,renderer =gifski_renderer("Tasa de Desempleo.gif"))+
  options(gganimate.dev_args = list(width = 7, height = 5, units = 'in', res=600))    



#anim_save("Mercado laboral.gif",ml)
#magick_renderer()
#ease_aes('linear')




