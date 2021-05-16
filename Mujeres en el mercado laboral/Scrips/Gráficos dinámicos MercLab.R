setwd("C:/Users/United Nations Development Programme/DataCrew/viernesdesabias/Mujerermercadolaboral/")
#-------------------------------------------
#   Instalar paquetes y  Cargar librerias 
#-------------------------------------------
install.packages('gganimate')
install.packages("tidyverse")
devtools::install_github('bbc/bbplot')
devtools::install_github("r-rust/gifski")
devtools::install_github('thomasp85/gganimate')
install.packages("gifski")
install.packages("jsonlite", type = "source")


library(dplyr)
library(ggplot2)
library (tidyverse)
library(gganimate)
library(zoo)
library(ggthemes)
library(readxl)
#----------------------------------------------------------
#           Trabajamos sobre la variable desempleo
#----------------------------------------------------------
desempleo <- read_excel("tasa_desempleo_20182020.xlsx")

# Le damos formato trimestral a  la variable Trimestre
Trimestre_date<-as.yearqtr(desempleo$Trimestre, format="%Y-0%q")
desempleo %>%
  transmute(Trimestre_date=Trimestre)
#------------------------------------------------------------------
#         Generamos  la gráfica de  TD por trimestre
#------------------------------------------------------------------

myplot1 <- ggplot(data = desempleo, aes(x=Trimestre, y=tasa, group=Sexo, colour=Sexo)) + 
  geom_line() + geom_point() +  xlab("Trimestre") +ylab("Tasa de desempleo")+
  ggtitle("Tasa de desempleo trimestral por sexo") + theme(plot.title = element_text(hjust = 0.5)) +
  labs(caption = "Fuente: PNUD con base en GEIH")+
  theme_minimal()+theme(axis.text.x = element_text(angle = 90, hjust = 1))

#elegimos un tema para generar la data

myplot1
myplot1 <- myplot1 + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))

#una vez  establecida la  gráfica le damos movimiento

myplot_desempleo<-myplot1 + transition_reveal(fecha)
myplot_desempleo<-animate(myplot_desempleo, duration=10, renderer = gifski_renderer("Tasa_desempleo.gif"))
myplot_desempleo



#------------------------------------------------------------------
#       Generamos  la gráfica de horas de trabajo a la semana
#------------------------------------------------------------------

#Cargamos la base de datos

library(readxl)
horas <- read_excel("horas_sexo.xlsx")

#Generamos gráfica  para trabajo remunerado

myplot3 <- horas %>%
  filter(actividades == c('trabajo_remunerado')) %>%
  ggplot(aes(x=concepto, y=valores, fill=sexo)) +
  geom_bar(stat="identity", position=position_dodge())+
  scale_fill_manual(values = c("#4E84C4", "#293352"))+
  scale_y_continuous(limits=c(0,60), name="Horas")+
  scale_x_continuous(name = "A?o", breaks=seq(2009, 2020, 1)) +
  ggtitle("Horas semanales promedio en trabajo remunerado por sexo") +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(caption = "Fuente: PNUD con base en GEIH")+
  theme_minimal()+
  theme(legend.position = "bottom")
  
  
# Generamos gráfica de cuidado del hogar por  medio de un diagrama de barras

myplot2 <- horas %>%
  filter(actividades == c('hogar_cuidado')) %>%
  ggplot(aes(x=concepto, y=valores, fill=sexo)) +
  geom_bar(stat="identity", position=position_dodge())+
  scale_fill_manual(values = c("#C3D7A4", "#52854C"))+
  scale_y_continuous(limits=c(0,60), name="Horas")+
  scale_x_continuous(name = "A?o", breaks=seq(2009, 2020, 1)) +
  ggtitle("Horas semanales promedio en oficios del hogar \n y actividades de cuidado por sexo") +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(caption = "Fuente: PNUD con base en GEIH")+
  theme_minimal()+
  theme(legend.position = "bottom")


#Generamos animación de la gráfica

  myplot2
  myplot2 <- myplot2 + 
    theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(), 
          panel.background = element_blank(), 
          axis.line = element_line(colour = "black"))

myplot_horas_sexo<-myplot2 + transition_reveal(concepto)
myplot_horas_sexo<-animate(myplot_horas_sexo, duration=10, renderer = gifski_renderer("myplot_horas_sexo.gif"))
myplot_horas_sexo

#-----------------------------------------------------------
#                 POBLACION OCUPADA POR POSICION  
#-----------------------------------------------------------

#cargamos bases

library(readxl)
ocupacional <- read_excel("posicion_ocupacional.xlsx")

#Generamos un diagram de barras 

myplot3 <-ggplot(data=ocupacional, aes(x=Posicion, y=valor, fill=sexo)) +
  geom_bar(stat="identity", position=position_dodge())+ coord_flip()+
  xlab("N?mero ocupados") +ylab("Posici?n ocupacional")+
  ggtitle("Variaci?n n?mero ocupados entre 2019 y 2020") + theme(plot.title = element_text(hjust = 0.5)) +
  labs(caption = "Fuente: PNUD con base en GEIH")+
  theme_minimal()

# le damos formato al tema de la gráfica

myplot3 <- myplot3 + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))

myplot3

#-----------------------------------------------
#            Gráfico inactividad 
#-----------------------------------------------


#Cargamos bases 

library(readxl)
inactividad <- read_excel("inactividad.xlsx")

#Generamos una grafica de tendencia y puntos 

myplot2 <- ggplot(data = horas_sexo, aes(x=concepto, y=ttp_trabajo, group=sexo, colour=sexo)) + 
  geom_line() +
  geom_point() +
  scale_y_continuous(limits=c(40,80), name="Horas")+
  scale_x_continuous(name = "A?o", limits = c(2009,2020))+
  ggtitle("Tiempo total promedio trabajado") + theme(plot.title = element_text(hjust = 0.5)) +
  labs(caption = "Fuente: PNUD con base en GEIH")+
  theme_minimal()+
  

# le damos formato el tema de la gráfica 
  
myplot2
myplot2 <- myplot2 + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))

myplot_horas_sexo<-myplot2 + transition_reveal(concepto)
myplot_horas_sexo<-animate(myplot_horas_sexo, duration=10, renderer = gifski_renderer("myplot_horas_sexo.gif"))
myplot_horas_sexo

#---------------------------------------------------
#         Gráfica actividad semana anterior
#---------------------------------------------------

#Cargamos bases

library(readxl)
actividad <- read_excel("actividad_usemana.xlsx")

##Elaboramos la gráfica 

myplot_expo <-  actividad %>%
  filter(sexo == 1) %>% #filtramos por activiadad y sexo 
  filter(tipo == c('act_trabajo','act_btrabajo','act_estudia','act_hogar','act_incapacidad','act_otra')) %>%
  ggplot(aes(x=mes, y=valor, group=tipo, col=tipo)) +
  ggtitle("Actividad principal ?ltima semana 2020") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_line(col="black") + xlab("mes 2020") +ylab("Porcentaje") + scale_color_hue(l=50,c=80)+ xlab("mes")+
  labs(caption = "Fuente: PNUD con base en DANE") +geom_area(aes(fill=I("grey")), alpha=0.5)+
  theme_clean()+theme(legend.position = "bottom") +
  theme(axis.text.x=element_text(angle=-90, hjust=0.001))

##Generamos  gráfica  para exportaciones mensuales 

myplot_expo <- ggplot(data = expo_filter, aes(x=as.Date(fecha, format="%Y-%m-%d"), y=Valor, group=Tipo, col=Tipo)) + 
  ggtitle("Exportaciones mensuales (Dólares FOB)") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_line(col="black") + xlab("fecha") +ylab("millones de dólares") + scale_color_hue(l=50,c=80)+
  scale_x_date(date_labels="%b %y",date_breaks  ="3 month") + xlab("mes")+
  labs(caption = "Fuente: PNUD con base en DANE") +geom_area(aes(fill=I("grey")), alpha=0.5)+
  theme_clean()+theme(legend.position = "bottom") +
  theme(axis.text.x=element_text(angle=-90, hjust=0.001))


#Se generan las animaciones 

myplot_expo
myplot_expo<-myplot_expo + transition_reveal(fecha)
myplot_expo<-animate(myplot_expo, duration=15, renderer = gifski_renderer("myplot_expo.gif"))


