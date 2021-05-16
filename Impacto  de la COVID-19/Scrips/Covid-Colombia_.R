#-------------------------------------------
# limpiamos consola y cargamos librerias
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
library (scales)

#-------------------------------------------
#   Cargamos y ordenamos base de datos 
#-------------------------------------------
casos <- read_excel("Casos_.xlsx")
casos$n <- NULL


#establecemos el foprmato de la fecha 

date <- as.Date(casos$date, format="%y %m %d")
colc <- zoo(casos$tasa, date)
colc <-(rollmean(colc, 7))

#damos orden al data frame

colc <- as.data.frame(fortify.zoo(colc))
colnames(colc) <- c("date","rollmean")

#generamos unios por identificador de variable deseada

casos <- merge(casos, colc, by="date", all=TRUE)

casos <- casos%>% gather(criterio, val, -date)
casos <- casos %>% drop_na()

#Convertimso en factor la variable criterio

casos$criterio <- factor(casos$criterio,
                         levels= c("tasa", "rollmean"),
                          labels=c("Casos por mill?n", "Promedio m?vil (7 d?as)")
                           )

#-------------------------------------------
#          Elaboramos gráfica 
#-------------------------------------------

casos <-     
ggplot(casos, aes(x=as.Date(date, format="%y %m %d"), y=val, colour=criterio)) + 
  geom_line(size=0.7)+
  scale_color_manual(values=c("#bbbbbb", "#0B387C"))+
  ggtitle("Casos confirmados COVID-19 por mill?n de habs.")+
  xlab("Fecha") +ylab("Casos")+ 
  labs(caption = "Fuente: PNUD con base en INS (28 de marzo de 2021)")+
  scale_x_date(breaks= breaks_width("month"),labels = date_format("%m/%d"))+
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

# generamos animación
casos<-casos + transition_reveal(date) 
casos<-animate(casos, duration=20, renderer = gifski_renderer("Casos.gif"))+
  options(gganimate.dev_args = list(width = 7, height = 5, units = 'in', res=600))
         

#-------------------------------------------
#     Cargamos base de datos de fallecidos
#-------------------------------------------

fallecidos <- read_excel("Fallecidos_.xlsx")
fallecidos$n <- NULL

#damos formato de fecha y ordenamos

date <- as.Date(fallecidos$date, format="%y %m %d")
colf <- zoo(fallecidos$tasa, date)
colf <-(rollmean(colf, 7))
colf <- as.data.frame(fortify.zoo(colf))
colnames(colf) <- c("date","rollmean")

fallecidos <- merge(fallecidos,colf, by="date", all=TRUE)
fallecidos <- fallecidos%>% gather(criterio, val, -date)
fallecidos <- fallecidos %>% drop_na()

fallecidos$criterio <- factor(fallecidos$criterio,
                         levels= c("tasa", "rollmean"),
                         labels=c("Fallecidos por mill?n", "Promedio m?vil (7 d?as)")
)

#-------------------------------------------
#          Elaboramos gráfica 
#-------------------------------------------

fallecidos <- 
  ggplot(fallecidos, aes(x=as.Date(date, format="%y %m %d"), y=val, colour=criterio))+ 
  geom_line(size=0.7)+
  scale_color_manual(values=c("#bbbbbb", "#003366"))+
  ggtitle("Personas fallecidas COVID-19 por mill?n de habs.")+
  xlab("Fecha") +ylab("Fallecidos")+ 
  labs(caption = "Fuente: PNUD con base en INS (28 de marzo de 2021)")+
  scale_x_date(breaks= breaks_width("month"),labels = date_format("%m/%d"))+
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

fallecidos<-fallecidos + transition_reveal(date)
fallecidos<-animate(fallecidos, duration=20, renderer = gifski_renderer("Fallecidos.gif"))+
        options(gganimate.dev_args = list(width = 7, height = 5 , units = 'in', res=600))



#-------------------------------------------
#         Ordenamos orden categórico 
#-------------------------------------------

casos <- xts(x = colc$Casos, order.by = colc$date)

Casos <- dygraph(casos) %>%
  dyOptions(labelsUTC = TRUE, fillGraph=TRUE, fillAlpha=0.1, drawGrid = FALSE, colors="#D8AE5A") %>%
  dyRangeSelector() %>%
  dyCrosshair(direction = "vertical") %>%
  dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)  %>%
  dyRoller(rollPeriod = 1)
 
saveWidget(Casos, file=paste0( getwd(), "Casos.html"))


#Ordenamos y damos  formato a los nombres de departamentos 

casos$dpto <- factor(casos$dto,
                     levels=c(5,8,11,13,15,17,18,19,20,23,25,27,41,44,47,50,52,54,
                              63,66,68,70,73,76,81,85,86,88,91,94,95,97,99),
                     labels= c("Antioquia","Atl??ntico","Bogot?","Bol?var","Boyac?",
                               "Caldas","Caquet?","Cauca","Cesar","C?rdoba",
                               "Cundinamarca","Choc?","Huila","La Guajira",
                               "Magdalena","Meta","Nari?o","Norte de Santander",
                               "Quind?o","Risaralda","Santander","Sucre","Tolima",
                               "Valle del Cauca","Arauca","Casanare","Putumayo",
                               "San Andr?s y Providencia","Amazonas","Guain?a",
                               "Guaviare","Vaup?s","Vichada")
)


fallecidos$dpto <- factor(fallecidos$dto,
                          levels=c(5,8,11,13,15,17,18,19,20,23,25,27,41,44,47,50,52,54,
                                   63,66,68,70,73,76,81,85,86,88,91,94,95,97,99),
                          labels= c("Antioquia","Atl??ntico","Bogot?","Bol?var","Boyac?",
                                    "Caldas","Caquet?","Cauca","Cesar","C?rdoba",
                                    "Cundinamarca","Choc?","Huila","La Guajira",
                                    "Magdalena","Meta","Nari?o","Norte de Santander",
                                    "Quind?o","Risaralda","Santander","Sucre","Tolima",
                                    "Valle del Cauca","Arauca","Casanare","Putumayo",
                                    "San Andr?s y Providencia","Amazonas","Guain?a",
                                    "Guaviare","Vaup?s","Vichada")
)

#Ordenamos columnas

colc <- casos%>% group_by(date)%>% summarise(tasa)
colnames(colc) <- c("date","Casos")
colc$Casos <- colc$Casos/10
colf <- fallecidos%>% group_by(date)%>% summarise(tasa)
colnames(colf) <- c("date","Fallecidos")


