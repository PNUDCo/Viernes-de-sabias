#-----------------------------------
#    Cargamos librerias 
#----------------------------------- 

library(dplyr)
library(ggplot2)
library (tidyverse)
library(gganimate)
library(zoo)
library(ggthemes)

setwd("C:/OneDrive - United Nations Development Programme/DataCrew/8. Viernes de sabias/5. Paper pobreza")

#-----------------------------------------
#    Cargamos base y elaboramos gráfico
#-----------------------------------------


library(readxl)
ingquintil <- read_excel("ing quintil.xlsx")


#gráfico caida del ingreso por quintil

myplot1 <- ggplot(data = ingquintil, aes(x=Quintil, y=Variaci?n,fill=Variaci?n)) + facet_wrap(~Dominio) +
  geom_col() + xlab("Quintil") +ylab("Variaci?n (%)")+
  ggtitle("Variaci?n de los salarios o ganancias por quintil de ingreso.2020-2019.") + theme(legend.position = "none") +
  labs(caption = "Fuente: PNUD con base en GEIH")+ggsave("ingquint.jpg", scale=1, width = 7, height = 5 , units = 'in', dpi=1000)

myplot1
myplot1 <- myplot1 + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))
# le damos dinámica al gráfico

myplot_ingq<-myplot1 + transition_states(Quintil, wrap=FALSE)+shadow_mark()+ geom_text(label = as.character(ingquintil$Variaci?n))
myplot_ingq<-animate(myplot_ingq, duration=10, renderer = gifski_renderer("ingquintil.gif"))
myplot_ingq



#-----------------------------------------
#    Gráfico pobreza sin ayudas 
#-----------------------------------------

library(personograph) #cargamos ñiberia que permite poner el  simbolo de personas

#Le damos  las proporiciones del procentaje
data <- list(`Pobreza esc. base`=0.35, `Caer?an en pobreza sin ayudas`=0.07, `Se mantienen fuera de pobreza`= 0.58)


#le damos estilo y formato a la gráfica 
personograph(data,
             colors=list(`Pobreza esc. base` = "blue", `Caer?an en pobreza sin ayudas` = "coral", `Se mantienen fuera de pobreza` = "grey"),
             icon.style = 4, 
             n.icons = 100)

#-----------------------------------------
#    Gráfico pobreza con ayudas 
#-----------------------------------------

data <- list(`Pobreza esc. base`=0.35, `Caen en pobreza`=0.03,
             `Se mantienen fuera de pobreza`= 0.62)

personograph(data,
             colors=list(`Pobreza esc. base` = "blue", 
                         `Caen en pobreza con ayudas` = "coral", 
                         `Se mantienen fuera de pobreza` = "grey"),
             icon.style = 4, 
             n.icons = 100)



#-----------------------------------------
#    Efecto en la desigualdad 
#-----------------------------------------

#Cargamos  base
ingquintile <- read_excel("ing quintil empleo.xlsx")

#elaboramos la gráfica  por quintill 
myplot2 <- ggplot(data = ingquintile, aes(x=Quintil, y=variacion)) + facet_wrap(~panorama) +
  geom_point(size=8,color="blue3", shape=15) + geom_segment(aes(x=Quintil, 
                   xend=Quintil, 
                   y=0, 
                   yend=variacion), color="blue3")+geom_hline(yintercept=0, col="grey") + xlab("Quintil") +ylab("Variaci?n (%)")+
  ggtitle("Variaci?n del ingreso per c?pita del hogar por quintil de ingreso.2020-2019.") + theme(legend.position = "none") +
  labs(caption = "Fuente: PNUD con base en GEIH")+ggsave("ingquinte.jpg", scale=1, width = 7, height = 5 , units = 'in', dpi=2000)


#Elaboramos la dinámica de la gráfica 
myplot2

myplot_ingq2<-myplot2 + transition_states(Quintil, wrap=FALSE)+shadow_mark()+ 
  geom_text(label = as.character(ingquintile$variacion), size=2.5, color="white")
myplot_ingq2<-animate(myplot_ingq, duration=10, renderer = gifski_renderer("ingquinte.jpg"))
myplot_ingq2


#-----------------------------------------
#    Efecto en la desigualdad 2 GINI
#-----------------------------------------
desigualdad <- read_excel("Desigualdad.xlsx")

p1 <-    ggplot(data=desigualdad) +
  geom_segment( aes(x=dominio, xend=dominio, y=gb, yend=gsp), color="grey", size=3) +
  geom_point( aes(x=dominio, y=gb), color="#0B387C", size=5 ) +
  geom_point( aes(x=dominio, y=gsp), color="#000000", size=5 ) +
  geom_text( aes(x=dominio, y=gb, label=gb), color="#0B387C", nudge_x = 0.2) +
  geom_text( aes(x=dominio, y=gsp,label=gsp), color="#000000", nudge_x = 0.2) +
  geom_vline(xintercept=5, linetype="dashed", color="grey")+
  geom_vline(xintercept=4, linetype="dashed", color="grey")+
  geom_vline(xintercept=3, linetype="dashed", color="grey")+
  geom_vline(xintercept=2, linetype="dashed", color="grey")+
  geom_vline(xintercept=1, linetype="dashed", color="grey")+
  coord_flip()+
  xlab("") +
  ylab("Coeficiente de Gini")+
  theme(axis.line.x = element_line(color = "#000000"),
        axis.ticks =  element_blank(),
        strip.background =element_blank(),
        panel.background = element_blank()) 
