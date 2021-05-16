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


#-------------------------------------------
#       Cargamos la base de datos
#-------------------------------------------

pib <- read_excel("pib.xlsx")

#damos formato a las variables  de fecha
pib$tri<-as.yearqtr(pib$tri, format = "%Y-%q")
pib$year <- as.Date(pib$year, format="%y/%m/%d")
pib$percent <- pib$percent/100

#-------------------------------------------
#          Elaboramos gráficas
#-------------------------------------------

p1 <-   
ggplot(pib, aes(x=as.Date(year, format="%y %m %d"), y=percent)) + 
  geom_line(color="#003366", size=0.7)+
  geom_hline(yintercept=0,linetype="dashed", color = "#BBBBBB")+
  geom_ribbon(aes( xmin=as.Date("2020-03-1"), xmax=as.Date("2020-12-31"), 
                   fill="red"), alpha=0.5, show.legend = FALSE)+
  scale_x_date(breaks = date_breaks("8 months"),date_labels="%b %y",
               limits = c(as.Date("2006-1-1"), as.Date("2020-12-31")))+
  scale_y_continuous(labels = percent)+
  ggtitle("Evoluci?n del PIB trimestral. Colombia 2005-2020") + 
  xlab("") +ylab("")+
  theme(axis.line.y = element_blank(),
        axis.ticks =  element_blank(),
        plot.title = element_text(size =10, face = "bold", hjust = 0.5),
        axis.line.x =element_blank(),
        axis.title.y =element_blank(),
        axis.title.x = element_blank(),
        axis.text.x=element_blank(),
        strip.background =element_blank(),
        strip.text = element_text(size = 7.5, face="bold"),
        legend.title=element_blank(),
        legend.key =element_blank(),         
        panel.background = element_blank()) 

p2 <-   
ggplot(pib, aes(x=as.Date(year, format="%y %m %d"), y=pib)) + 
  geom_col(fill="#003366",linetype=0, alpha=0.3)+
  scale_x_date(breaks = date_breaks("8 months"),date_labels="%b %y",
               limits = c(as.Date("2006-1-1"), as.Date("2020-12-31")))+
  scale_y_continuous(labels = dollar, limits = c(0, max(pib$pib)))+
  labs(caption = "Fuente:PNUD con base en DANE")+
  xlab("Trimestre") +ylab("Miles de millones")+
  theme(axis.line.y = element_blank(),
        axis.ticks.y =  element_blank(),
        plot.title = element_blank(),
        axis.line.x = element_line(color = "#000000"),
        axis.title.y = element_text(size=6, hjust = 1, angle = 90),
        axis.title.x = element_text(size=10, hjust = 1),
        axis.text.x=element_text(angle=-90, hjust=0.001),
        strip.background =element_blank(),
        strip.text = element_text(size = 7.5, face="bold"),
        legend.title=element_blank(),
        legend.key =element_blank(),         
        panel.background = element_blank()) 

ggarrange(p1, p2, 
          labels = c("Tasa de crecimiento del PIB trimestral(%)",
                     "PIB a precios constantes 2005-2020"),
          ncol = 1, nrow = 2, align = "v",
          vjust=5,
          font.label = list(size = 7, face = "italic")
)
ggsave("PIB.jpg", scale=1, width = 7, height = 5 , units = 'in', dpi=600)

