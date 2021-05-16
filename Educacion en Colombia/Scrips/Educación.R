#-------------------------------------------------------
#          Cargamos librerias e instalamos paquetes
#-------------------------------------------------------
install.packages('gganimate')
install.packages("tidyverse")
devtools::install_github('bbc/bbplot')
devtools::install_github("r-rust/gifski")
devtools::install_github('thomasp85/gganimate')
install.packages("gifski")
install.packages("jsonlite", type = "source")
install.packages("gapminder")


setwd("C:/Users//United Nations Development Programme/DataCrew/8. Jueves de Twitter/3. Educacion/")
library(dplyr)
library(ggplot2)
library (tidyverse)
library(gganimate)
library(zoo)
library(gganimate)
library(magick)
library(gapminder)


#------------------------------------------------------
#               saber 11 x INSE (municipal) 
#-------------------------------------------------------

#gargamos la base 

file <- 'zona_conectividad.csv'
data <- read.csv(file)


#Generamos gráfica  de promedio INSE contra puntaje promedio PRUEBA SABER 11


A <- ggplot(data, aes(INSE, punt_global, size = Indice_penetracion, color = Zona)) +
  geom_point() +
  scale_x_log10() +
  theme_bw() +
  # gganimate specific bits:
  labs(title = 'A?o: {frame_time}', x = 'Promedio municipal INSE', y = 'Puntaje promedio global municipal Saber 11') +
  transition_time(year) +
  ease_aes('linear')+
  labs(caption = "Fuente: PNUD con base en Saber 11 y MinTIC")

#Generamos el gráfico dinámico

a_gif <- animate(A, 
                 duration=10,
                 fps=10, 
                 renderer =magick_renderer())

a_gif
anim_save("INSE_conectividad.gif", a_gif)


#-------------------------------------------------------
#            saber 11 x INSE (departamento) 
#-------------------------------------------------------

#Cargamos bases 

file <- 'DEPTO_conectividad.csv'
data <- read.csv(file, header = TRUE, fileEncoding = "UTF-8")

# Creamos gráfico de promedio INSE contra puntaje promedio PRUEBA SABER 11 por departamento

B <- ggplot(data, aes(INSE, punt_global, size = Indice_internet_fijo, color = Zona)) +
  geom_point() +
  scale_x_log10() +
  theme_bw() +
  # gganimate specific bits:
  labs(title = 'A?o: {frame_time}', x = 'Promedio departamental INSE', y = 'Puntaje promedio global departamental Saber 11') +
  transition_time(year) +
  ease_aes('linear')+
  labs(caption = "Fuente: PNUD con base en Saber 11, MinTIC y Terridata")+
  labs(caption = "Nota: El indice de nivel socioecon?mico (INSE) recopila informaci?n
       del nivel educativo de los padres, su ocupaci?n y el ingreso familiar")+
  geom_text(aes(label = Departamento), 
            hjust = 0, vjust= 0, size = 4, family = "Helvetica")

#Creamos gráfico dinámico

b_gif <- animate(B, 
                 duration=16,
                 fps=10,
                 width=550,
                 height=550, 
                 end_pause=20,
                 renderer =magick_renderer())

b_gif
anim_save("DEPTO_conectividad2.gif", b_gif)


#---------------------------------------------
#            saber 11 LECUTRA X INSE
#---------------------------------------------

#cargamos base de datos 

file <- 'DEPTO_lectura.csv'
data <- read.csv(file)

# Elaboramos gráfica INSE por lectura critica  y le damos dinámica

C <- ggplot(data, aes(INSE, Lectura_critica, size = Porcenaje_familias_menos10libros, color = Zona)) +
  geom_point() +
  scale_x_log10() +
  theme_bw() +
  # gganimate specific bits:
  labs(title = 'A?o: {frame_time}', x = 'Promedio departamental INSE', y = 'Puntaje promedio Lectura cr?tica departamental Saber 11') +
  transition_time(year) +
  ease_aes('linear')+
  labs(caption = "Fuente: PNUD con base en Saber 11")+
  geom_text(aes(label = Departamento), 
            hjust = 0, vjust= 0, size = 4, family = "Helvetica")


c_gif <- animate(C, 
                 duration=10,
                 fps=10, 
                 renderer =magick_renderer())

c_gif
anim_save("DEPTO_lectura.gif", c_gif)






