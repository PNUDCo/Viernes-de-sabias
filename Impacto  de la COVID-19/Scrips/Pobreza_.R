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

pobreza <- read_excel("pobreza.xlsx")


#-------------------------------------------
#          Elaboramos gráficas
#-------------------------------------------

p1 <-    
ggplot(pobreza) +
  geom_segment( aes(x=pais, xend=pais, y=p19, yend=p20), color="grey", size=3) +
  geom_point( aes(x=pais, y=p19), color="#0B387C", size=5 ) +
  geom_point( aes(x=pais, y=p20), color="#000000", size=5 ) +
  geom_text( aes(x=pais, y=p19, label=p19), color="#0B387C", nudge_x = 0.2) +
  geom_text( aes(x=pais, y=p20,label=p20), color="#000000", nudge_x = 0.2) +
  geom_vline(xintercept=5, linetype="dashed", color="grey")+
  geom_vline(xintercept=4, linetype="dashed", color="grey")+
  geom_vline(xintercept=3, linetype="dashed", color="grey")+
  geom_vline(xintercept=2, linetype="dashed", color="grey")+
  geom_vline(xintercept=1, linetype="dashed", color="grey")+
  coord_flip()+
  xlab("") +
  ylab("Incidencia de la Pobreza Extrema")+
theme(axis.line.x = element_line(color = "#000000"),
      axis.ticks =  element_blank(),
      strip.background =element_blank(),
      panel.background = element_blank()) 


p2   <- 
  ggplot(pobreza) +
  geom_segment( aes(x=pais, xend=pais, y=e19, yend=e29), color="grey", size=3) +
  geom_point( aes(x=pais, y=e19), color="#0B387C", size=5 ) +
  geom_point( aes(x=pais, y=e29), color="#000000", size=5 ) +
  geom_text( aes(x=pais, y=e19, label=e19), color="#0B387C", nudge_x = 0.2) +
  geom_text( aes(x=pais, y=e29,label=e29), color="#000000", nudge_x = 0.2) +
  geom_vline(xintercept=5, linetype="dashed", color="grey")+
  geom_vline(xintercept=4, linetype="dashed", color="grey")+
  geom_vline(xintercept=3, linetype="dashed", color="grey")+
  geom_vline(xintercept=2, linetype="dashed", color="grey")+
  geom_vline(xintercept=1, linetype="dashed", color="grey")+
  coord_flip()+
  xlab("") +
  ylab("Incidencia de la Pobreza")+
  theme(axis.line.x = element_line(color = "#000000"),
        axis.text.y = element_blank(),
        axis.ticks =  element_blank(),
        strip.background =element_blank(),
        panel.background = element_blank()) 



plot <- ggarrange(p1, p2, 
         ncol = 2, nrow = 1, align = "h",
         vjust=5
         )
annotate_figure(plot,
                top = text_grob("Pobreza Monetaria. Cinco principales econom?as de Am?rica Latina 2019-2020",
                                color = "black", face = "bold", size = 10),
                bottom = text_grob("Fuente:PNUD con base en CEPAL y Nu?ez, 2020 (*cifras de Colombia corresponden a la medici?n oficial )", color = "black",
                                   hjust = 0.5, size = 9)
                )

ggsave("Pobreza.jpg", scale=1, width = 7, height = 5 , units = 'in', dpi=600)
