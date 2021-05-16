#---------------------------------------------
#    Cargamos  librerias y establecemos ruta
#---------------------------------------------

setwd("C:/Users/alvar/OneDrive - United Nations Development Programme/DataCrew/8. Viernes de sabias/6. Pobreza Regi?n Caribe")
library(dplyr)
library(ggplot2)
library (tidyverse)
library(gganimate)
library(zoo)
library(ggthemes)
library(reshape2)

#---------------------------------------------
#   Cargamos base de datos  Pobreza Extrema
#---------------------------------------------

library(readxl)
pobext <-read_excel("pobextayud.xlsx")

#---------------------------------------------
#   Elaboramos gráfica  Pobreza Extrema
#---------------------------------------------

myplot1 <- ggplot(data = pobext, aes(x=Ayuda, y=Compensaci?n,fill=Compensaci?n), ) + facet_wrap(~Departamento) +
  geom_col(width=0.4,position = 'dodge',colour="deepskyblue") + xlab("Programa") +ylab("Compensaci?n (p.p.)")+ theme(legend.position = "none") +
  labs(caption = "Fuente: CESORE, 2021")+ggsave("pobayud.jpg", scale=1, width = 7, height = 5 , units = 'in', dpi=1000)

myplot1
myplot1 <- myplot1 + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))

myplot2<-myplot1 + transition_states(Ayuda, wrap=FALSE)+shadow_mark()+ geom_text(label = as.character(pobext$Compensaci?n))
myplot2<-animate(myplot1, duration=8, renderer = gifski_renderer("cesoreayudasPe.gif"))
myplot2



#---------------------------------------------
#   Cargamos base de datos efecto ayudas 
#---------------------------------------------
library(readxl)
pobext <-read_excel("pobrezaayud.xlsx")


#---------------------------------------------
#   Elaboramos gráfica  efecto ayudas
#---------------------------------------------

myplot1 <- ggplot(data = pobext, aes(x=Ayuda, y=Compensaci?n,fill=Compensaci?n), ) + facet_wrap(~Departamento) +
  geom_col(width=0.4,position = 'dodge',colour="deepskyblue") + xlab("Programa") +ylab("Compensaci?n (p.p.)")+ theme(legend.position = "none") +
  labs(caption = "Fuente: CESORE, 2021")+ggsave("pobayud.jpg", scale=1, width = 7, height = 5 , units = 'in', dpi=1000)

myplot1
myplot1 <- myplot1 + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))

myplot2<-myplot1 + transition_states(Ayuda, wrap=FALSE)+shadow_mark()+ geom_text(label = as.character(pobext$Compensaci?n))
myplot2<-animate(myplot1, duration=8, renderer = gifski_renderer("cesoreayudasPT.gif"))
myplot2

