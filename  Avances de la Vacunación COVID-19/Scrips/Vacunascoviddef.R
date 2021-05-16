setwd("~/Desktop/RPNUD")
dir()




## instalo paquetes 

install.packages
install.packages("tidyverse")
install.packages("gifski")
install.packages("png")
install.packages("plyr")
install.packages("readxl")
install.packages("sf")
install.packages("raster")
install.packages("spData")
remotes::install_github("Nowosad/spDataLarge")
nstall.packages("tmap")
install.packages("leaflet")
install.packages("maps")
install.packages("viridis")
install.packages("viridisLite")
library(tidyverse)
library(dplyr)
library(gapminder)
library(ggplot2)
library(scales)
library(gganimate)
library("readxl")
library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2)
require(maps)
require(viridis)
library(rio)
library(openxlsx)
install_formats()
library(ggrepel)
library(gganimate)
library(xlsx)
library(plotly)


rm(list = ls())

#voy a llamar a la base  de covid 
vacucovid<- read.csv("coronavirus-data-explorer_2.csv", sep=",")
#view(vacucovid)
vacucovidTB<-tbl_df(vacucovid)
##convierto en fecha la vairable
head(vacucovidTB)
vacucovidTB$date<- as.Date(vacucovidTB$date)
head(vacucovidTB)

##### elijo las variables de vacunacioón 
vacucovidlatam<- vacucovidTB%>%dplyr::select(continent,date,location, total_vaccinations,people_vaccinated,people_fully_vaccinated,new_vaccinations,population)
vaclatam2 <- dplyr::select(filter(vacucovidlatam, continent == "South America" ),c(location,date, total_vaccinations,people_vaccinated,people_fully_vaccinated,new_vaccinations, population))

##### saco  el porcentaje de  vacunados/población total 

export(vaclatam2, "parahacerpor_2.xlsx")
vaclatam4<- read_excel("parahacerpor_2.xlsx")
view(parahacerpor_2)


vaclatam4 <- parahacerpor_2[-c(2583:2649,2650:3059,3951:4358),]
vaclatam4$location <- gsub("Brazil", "Brasil", vaclatam4$location)
vaclatam4$location <- gsub("Peru", "Perú", vaclatam4$location)

ss<-subset(vaclatam4,date>as.Date("2021/01/01"))
ggplot(data= ss, aes(x= date, y = porce_b))+
  geom_line(aes(color = location))+
  scale_x_date(date_labels = "%Y-%m")


ss<-subset(vaclatam4,date>as.Date("2021/01/01"))
ggplot(data= ss, aes(x= date, y = porce))+
  geom_line(aes(color = location))+
  labs(x= "Mes",
       y= "Porcentaje vacunados",
       color= "País",
       title= "Poblaciónvacunada en Sur America",
       subtitle= "Vacunación por país",
       caption= "Fuente: PNUD con base en Global Change Data Lab")

na.omit(vaclatam4)
view(vaclatam4)

####Grafica definitiva##

ss1<-subset(vaclatam4,date>as.Date("2021/01/01"))
ggplot(data= ss, aes(x= date, y = porce_b, color = location, label=sprintf("%0.2f",round(porce, digits = 2))))+
  geom_line(lwd=1)+
  geom_point()+
  scale_y_continuous(labels = label_number(suffix = "%"))+
  labs(x= "Mes",
       y= "Porcentaje",
       color= "País",
       title= "Porcentaje de población con dosis aplicadas en Sur América",
       subtitle= "Población relativa. (Corte 3 de mayo)",
       caption= "Fuente: PNUD con base en Global Change Data Lab")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
        geom_text(label = as.character(ss1$porce_b), size=3, vjust= 2, check_overlap = T)+
        transition_reveal(along = date)+
        anim_save("dosisuramerica7_mayo.gif",height = 5, width = 7, units = "in", res = 150, dpi=1000)


#######otras graficas generadas #############3
export(vaclatam4, "estevacuno.xlsx")


estevacuno2 <- read_excel("estevacuno2.xlsx")
View(estevacuno2)  

dir()
estevacuno4 <- read_excel("estevacuno4.xlsx")
View(estevacuno3)  

ss4<-subset(estevacuno4,date>as.Date("2021/01/01"))
ggplot(data= ss4, aes(x= date, y = people_vaccinated))+
  geom_line(aes(color = location))



ss4<-subset(estevacuno3,date>as.Date("2021/01/01"))
ggplot(data= ss4, aes(x= date, y = porce, color = location,))+
  geom_smooth()+
  #scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Mes",
       y= "Población vacunada",
       color= "País",
       title= "Población vacunada en Sur América",
       subtitle= "Total de vacunados por país",
       caption= "Fuente: PNUD con base en Global Change Data Lab")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())

###gracia con los datos suavizados, pero con geom_smooth, tiene  valores en brazil de 0 puede ser error

ggplot(data= ss4, aes(x= date, y = people_vaccinated, color = location,))+
  geom_smooth(se=F)+ 
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Mes",
       y= "Población vacunada",
       color= "País",
       title= "Población vacunada en Sur America",
       subtitle= "Vacunación por país",
       caption= "Fuente: PNUD con base en Global Change Data Lab")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())


####vamos a  haver la misma grafica pero congeom line 

ggplot(data= ss4, aes(x= date, y = people_vaccinated, color = location,))+
  geom_line()+ 
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Mes",
       y= "Población vacunada",
       color= "País",
       title= "Población vacunada en Sur America",
       subtitle= "Vacunación por país",
       caption= "Fuente: PNUD con base en Global Change Data Lab")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())

view(ss4)



######### con la segunda base de datos 


dir()
estevacuno5 <- read_excel("estevacuno5.xlsx")
View(estevacuno3)  

ss5<-subset(estevacuno5,date>as.Date("2021/01/01"))
ggplot(data= ss5, aes(x= date, y = people_vaccinated))+
  geom_line(aes(color = location))



ss5<-subset(estevacuno5,date>as.Date("2021/01/01"))
ggplot(data= ss5, aes(x= date, y = people_vaccinated, color = location,))+
  geom_smooth()+
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Mes",
       y= "Población vacunada",
       color= "País",
       title= "Población vacunada en Sur América",
       subtitle= "Total de vacunados por país",
       caption= "Fuente: PNUD con base en Global Change Data Lab")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())

###gracia con los datos suavizados, pero con geom_smooth, tiene  valores en brazil de 0 puede ser error

ggplot(data= ss5, aes(x= date, y = people_vaccinated, color = location,))+
  geom_smooth(se=F)+ 
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Mes",
       y= "Población vacunada",
       color= "País",
       title= "Población vacunada en Sur America",
       subtitle= "Vacunación por país",
       caption= "Fuente: PNUD con base en Global Change Data Lab")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())


####vamos a  haver la misma grafica pero congeom line 

ss6<-ggplot(data= ss5, aes(x= date, y = people_vaccinated, color = location,))+
  geom_line(lwd=1.0)+ 
  scale_y_continuous(labels = label_number(suffix = "M",scale = 1e-6))+
  labs(x= "Mes",
       y= "",
       color= "País ",
       title= "Población vacunada en Sur América",
       subtitle= "Total de Vacunados por país (Corte 30 abril 2021)",
       caption= "Fuente: PNUD con base en Global Change Data Lab ")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())


ss6 + 
  transition_states(location, transition_length = 4, wrap = FALSE) +
  shadow_mark()
















ss6+
  transition_time(date, range = NULL) +
  shadow_mark()



class(ss5$location)

ss5 +
  transition_time(date) +
  shadow_mark()


rlang::last_error()
rlang::last_trace()
animate









ss5<- transition_time(date)
ss5


anim <- 
  ss5 + 
  transition_states(location,transition_length = 2,state_length = 1)

anim
view(ss4)





+
  
  
  
  
  transition_time(date) +
  ease_aes("linear") +
  enter_fade() +
  exit_fade()


geom_text_repel(label = as.numeric(ss4$people_vaccinated))



geom_text_repel(
  aes(label = variable), data = data_ends,
  color = "black", size = 3
)











view(ss3)
transition_reveal(location)


ss1 %>% 
  transition_reveal(location)


ss1%>% 
  transition_states(people_vaccinated, transition_length = 4, wrap = FALSE) +
  shadow_mark()





ss + 
  facet_wrap(~location) +
  transition_time(date()) +
  labs(title = "date: {frame_time}") 


ss + transition_time(date) +
  labs(title = "Year: {frame_time}") +
  view_follow(fixed_y = TRUE)










ss+
  transition_states(date, transition_length = 1, state_length = 1, wrap = TRUE)

library(ggflags)
library(gifski)


animate(,width = 400, height = 400,nframes = 480, fps = 24)




