#---------------------------------------------
#         Cargamos paquetes y librerias 
#---------------------------------------------

Pkgs <- c("ggplot2", "tidyverse", "dplyr", "highcharter", "hrbrthemes", "ggrepel", 
          "stringr", "skimr", "viridis", "haven", "stats", "RColorBrewer", "fontawesome",
          "ggpubr", "knitr", "broom", "ggthemes", "zoo", "readxl", "kableExtra", "emojifont",
          "lubridate", "ggalt", "htmltools", "gridExtra", "billboarder", "gapminder",
          "gganimate", "magick", "bbplot", "transformr", "sf")                    


lapply(Pkgs, library, character.only = TRUE)

#establecemos ruta de trabajo

setwd("D:/Juan/Documents/UNDP/Data Bases/Tweets/")

#---------------------------------------------
#         Cargamos bases de datos 
#---------------------------------------------

Pobreza_Caribe <- read_excel("Tweet Regi?n Caribe 2021.xlsx",
                       sheet = 1)

Pobreza_Extrema_Caribe <- read_excel("Tweet Regi?n Caribe 2021.xlsx",
                             sheet = 2)

#cargamos bases de datos para hacer mapas de Colombia 

Colombia_Geo_Data <- read_sf("https://gist.githubusercontent.com/john-guerra/43c7656821069d00dcbc/raw/be6a6e239cd5b5b803c6e7c2ec405b793a9064dd/Colombia.geo.json")  
                     

Poverty_Map <- read_excel("Tweet Regi?n Caribe 2021.xlsx",
                                     sheet = 3)

Extreme_Poverty_Map <- read_excel("Tweet Regi?n Caribe 2021.xlsx",
                          sheet = 4)
        
#---------------------------------------------
#         ordenamos  bases de datos PM
#---------------------------------------------

#Bases de pobreza 
#Se elige una varibale pivote para pdoer realizar los mapas

Pobreza_Caribe_L <- Pobreza_Caribe %>%
  pivot_longer(!Departamento, 
               names_to = "A?o", 
               values_to = "Pobreza"
  ) %>%  
  mutate(Pobreza = round(Pobreza,2))


Pobreza_Extrema_Caribe_L <- Pobreza_Extrema_Caribe %>%
  pivot_longer(!Departamento, 
               names_to = "A?o", 
               values_to = "Pobreza Extrema"
  ) %>%  
  mutate(Pobreza = round(`Pobreza Extrema`,2))


#---------------------------------------------
#   Ordenamos el mapa para la región caribe
#---------------------------------------------


Caribe_Region <- c("LA GUAJIRA", "CORDOBA", "SUCRE", "BOLIVAR",
                   "CESAR", "ATLANTICO", "MAGDALENA")

Colombia_Geo_Data_F <- Colombia_Geo_Data %>%
  mutate(ID = as.numeric(DPTO)) %>% 
  filter(NOMBRE_DPT %in% Caribe_Region)

# Se une la bases de datos de pobreza con el poligono del mapa

Final_Base <- merge(Colombia_Geo_Data_F,
                    Poverty_Map,
                    by.y = "Departamentos",
                    by.x = "NOMBRE_DPT", 
                    all.x = TRUE)

# se repite el ejercicio  para pobreza extrema 

Caribe_Region <- c("LA GUAJIRA", "CORDOBA", "SUCRE", "BOLIVAR",
                   "CESAR", "ATLANTICO", "MAGDALENA")

Colombia_Geo_Data_F <- Colombia_Geo_Data %>%
  mutate(ID = as.numeric(DPTO)) %>% 
  filter(NOMBRE_DPT %in% Caribe_Region)

# Se une la bases de datos de pobreza con el poligono del mapa

Final_Base2 <- merge(Colombia_Geo_Data_F,
                    Extreme_Poverty_Map,
                    by.y = "Departamentos",
                    by.x = "NOMBRE_DPT", 
                    all.x = TRUE)

#---------------------------------------------
#            Realizamos la gráfica 
#---------------------------------------------

#Elegimos los colores

Colors_U <- c("#FAAB18", 
              "#1380A1",
              "#990000", 
              "#588300",
              "#00994C",
              "#4C0099",
              "#606060"
              )

#Animación Pobreza monetaria 

Animation <- Pobreza_Caribe_L %>%
  ggplot(aes(x= A?o, 
             y= Pobreza,
             group = Departamento,
             color = Departamento)) + 
  geom_line(size = 1) +
  scale_size(guide = FALSE) +
  bbc_style() +
  geom_text(aes(label = as.character(Pobreza)), 
            hjust = 0, vjust= 0, size = 4, family = "Helvetica") +
  theme(axis.title = element_text(size = 9),
        axis.text.y = element_text(size = 9, 
                                   margin = margin(l = 12)),
        axis.text.x = element_text(size = 9,
                                   margin = margin(b = 12)),
        legend.text = element_text(size = 9),
        legend.position = "bottom", 
        legend.direction = "vertical",
        legend.title = element_text(size = 9),
        plot.title = element_text(size = 14),
        plot.subtitle = element_text(size = 13)) +
        scale_colour_manual(values = Colors_U) +
  labs( title = "Evoluci?n de la pobreza monetaria en la regi?n Caribe",
        subtitle = "No incluye transferencias del gobierno",
    y = "Pobreza Monetaria",
    x = " ",
    caption = "Fuente: PNUD & CESORE 2021") +
  transition_reveal(as.integer(A?o))

#Creación del GIF

GIF <- animate(Animation,
               duration = 14,
               fps = 10,
               width =700,
               height =550,
               end_pause = 20,
               renderer = magick_renderer())

GIF

anim_save("Pobreza Monetaria Caribe GIF.gif", GIF)

#Animación Pobreza extrema


Animation <- Pobreza_Extrema_Caribe_L %>%
  ggplot(aes(x= A?o, 
             y= `Pobreza Extrema`,
             group = Departamento,
             color = Departamento)) + 
  geom_line(size = 1) +
  scale_size(guide = FALSE) +
  bbc_style() +
  geom_text(aes(label = as.character(`Pobreza Extrema`)), 
            hjust = 0, vjust= 0, size = 4, family = "Helvetica") +
  theme(axis.title = element_text(size = 9),
        axis.text.y = element_text(size = 9, 
                                   margin = margin(l = 12)),
        axis.text.x = element_text(size = 9,
                                   margin = margin(b = 12)),
        legend.text = element_text(size = 9),
        legend.position = "bottom", 
        legend.direction = "vertical",
        legend.title = element_text(size = 9),
        plot.title = element_text(size = 14),
        plot.subtitle = element_text(size = 13)) +
  scale_colour_manual(values = Colors_U) +
  labs( title = "Evoluci?n de la pobreza extrema en la regi?n Caribe",
        subtitle = "No incluye transferencias del gobierno",
    y = "Pobreza Extrema",
    x = " ",
    caption = "Fuente: PNUD & CESORE 2021") +
  transition_reveal(as.integer(A?o))


#Creación del GIF

GIF <- animate(Animation,
               duration = 14,
               fps = 10,
               width =700,
               height =550,
               end_pause = 20,
               renderer = magick_renderer())

GIF

anim_save("Pobreza Extrema Caribe GIF.gif", GIF)



#---------------------------------------------
#             Mapa de pobreza monetaria 
#---------------------------------------------
 

Base_points <- st_centroid(Final_Base)

Base_points <- cbind(Final_Base, st_coordinates(st_centroid(Final_Base$geometry)))


tiff("PovertyNo.tiff", 
     units="in", 
     width = 3, 
     height = 3, 
     res= 300,
     compression = "lzw")

Base_points %>% 
  filter(Tempo == "Sin ayudas") %>% 
  ggplot() + 
  geom_sf(aes(fill = Pobreza),
          na.rm = FALSE,
          color = "bisque2") +
  geom_text(aes(x = X, y = Y, label = Label),
            color = "gray100", check_overlap = FALSE) +
  theme_map() +
  scale_fill_viridis(
    begin = 0, 
    end = 0.5, 
    limits = c(),
    na.value = "white",
    option = "viridis", 
    direction = -1,
    name = "Aumento en la Pobreza Monetaria (pp)",
    # here we use guide_colourbar because it is still a continuous scale
    guide = guide_colorbar(
      direction = "horizontal",
      barheight = unit(2, units = "mm"),
      barwidth = unit(50, units = "mm"),
      draw.ulim = F,
      title.position = 'top',
      # some shifting around
      title.hjust = 0.5,
      label.hjust = 0.5,
      na.value = "white"
    )) +
  labs(title = "Impacto de la pandemia en la pobreza monetaria 2020",
       subtitle = "Sin transferencias del gobierno",
       caption = "Fuente: PNUD & CESORE 2021") +
  theme(plot.title = element_text(family = "Helvetica", 
                                  face = "bold", size = (18)),
        plot.subtitle = element_text(family = "Helvetica",
                                     size = (14)),
        plot.caption = element_text(family = "Helvetica", 
                                    size = (12)),
        legend.title = element_text(family = "Helvetica",
                                    face = "bold",
                                    size = (12)),
        legend.position = "bottom") 
  
dev.off()
  
  
tiff("PovertyYes.tiff", 
     units="in", 
     width = 3, 
     height = 3, 
     res= 300,
     compression = "lzw")

Base_points %>% 
  filter(Tempo == "Con ayudas") %>% 
  ggplot() + 
  geom_sf(aes(fill = Pobreza),
          na.rm = FALSE,
          color = "bisque2") +
  geom_text(aes(x = X, y = Y, label = Label),
            color = "black", check_overlap = FALSE) +
  theme_map() +
  theme(legend.position = "bottom") +
  scale_fill_viridis(
    begin = 0.3, 
    end = 0.9, 
    limits = c(),
    na.value = "white",
    option = "viridis", 
    direction = -1,
    name = "Aumento en la Pobreza Monetaria (pp)",
    # here we use guide_colourbar because it is still a continuous scale
    guide = guide_colorbar(
      direction = "horizontal",
      barheight = unit(2, units = "mm"),
      barwidth = unit(50, units = "mm"),
      draw.ulim = F,
      title.position = 'top',
      # some shifting around
      title.hjust = 0.5,
      label.hjust = 0.5,
      na.value = "white"
    )) +
  labs(title = "Impacto de la pandemia en la pobreza monetaria 2020",
       subtitle = "Con transferencias del gobierno",
       caption = "Fuente: PNUD & CESORE 2021") +
  theme(plot.title = element_text(family = "Helvetica", 
                                  face = "bold", size = (18)),
        plot.subtitle = element_text(family = "Helvetica",
                                     size = (14)),
        plot.caption = element_text(family = "Helvetica", 
                                    size = (12)),
        legend.title = element_text(family = "Helvetica",
                                    face = "bold",
                                    size = (12)),
        legend.position = "bottom") 

dev.off()

#---------------------------------------------
#          Mapa de pobreza Extrema
#---------------------------------------------

Base_points <- st_centroid(Final_Base2)

Base_points <- cbind(Final_Base2, st_coordinates(st_centroid(Final_Base2$geometry)))


tiff("ExtremePovertyNo.tiff", 
     units="in", 
     width = 3, 
     height = 3, 
     res= 300,
     compression = "lzw")

Base_points %>% 
  filter(Tempo == "Sin ayudas") %>% 
  ggplot() + 
  geom_sf(aes(fill = Pobreza),
          na.rm = FALSE,
          color = "bisque2") +
  geom_text(aes(x = X, y = Y, label = Label),
            color = "gray100", check_overlap = FALSE) +
  theme_map() +
  scale_fill_viridis(
    begin = 0, 
    end = 0.5, 
    limits = c(),
    na.value = "white",
    option = "viridis", 
    direction = -1,
    name = "Variaci?n en la Pobreza Extrema (pp)",
    # here we use guide_colourbar because it is still a continuous scale
    guide = guide_colorbar(
      direction = "horizontal",
      barheight = unit(2, units = "mm"),
      barwidth = unit(50, units = "mm"),
      draw.ulim = F,
      title.position = 'top',
      # some shifting around
      title.hjust = 0.5,
      label.hjust = 0.5,
      na.value = "white"
    )) +
  labs(title = "Impacto de la pandemia en la pobreza extrema 2020",
       subtitle = "Sin transferencias del gobierno",
       caption = "Fuente: PNUD & CESORE 2021") +
  theme(plot.title = element_text(family = "Helvetica", 
                                  face = "bold", size = (18)),
        plot.subtitle = element_text(family = "Helvetica",
                                     size = (14)),
        plot.caption = element_text(family = "Helvetica", 
                                    size = (12)),
        legend.title = element_text(family = "Helvetica",
                                    face = "bold",
                                    size = (12)),
        legend.position = "bottom") 

dev.off()


tiff("ExtremePovertyYes.tiff", 
     units="in", 
     width = 3, 
     height = 3, 
     res= 300,
     compression = "lzw")

Base_points %>% 
  filter(Tempo == "Con ayudas") %>% 
  ggplot() + 
  geom_sf(aes(fill = Pobreza),
          na.rm = FALSE,
          color = "bisque2") +
  geom_text(aes(x = X, y = Y, label = Label),
            color = "black", check_overlap = FALSE) +
  theme_map() +
  theme(legend.position = "bottom") +
  scale_fill_viridis(
    begin = 0.3, 
    end = 0.9, 
    limits = c(),
    na.value = "white",
    option = "viridis", 
    direction = -1,
    name = "Variaci?n en la Pobreza Extrema (pp)",
    # here we use guide_colourbar because it is still a continuous scale
    guide = guide_colorbar(
      direction = "horizontal",
      barheight = unit(2, units = "mm"),
      barwidth = unit(50, units = "mm"),
      draw.ulim = F,
      title.position = 'top',
      # some shifting around
      title.hjust = 0.5,
      label.hjust = 0.5,
      na.value = "white"
    )) +
  labs(title = "Impacto de la pandemia en la pobreza extrema 2020",
       subtitle = "Con transferencias del gobierno",
       caption = "Fuente: PNUD & CESORE 2021") +
  theme(plot.title = element_text(family = "Helvetica", 
                                  face = "bold", size = (18)),
        plot.subtitle = element_text(family = "Helvetica",
                                     size = (14)),
        plot.caption = element_text(family = "Helvetica", 
                                    size = (12)),
        legend.title = element_text(family = "Helvetica",
                                    face = "bold",
                                    size = (12)),
        legend.position = "bottom") 

dev.off()

#---------------------------------------------
#         definición de función apriori
#---------------------------------------------



bbc_style <- function () 
{
  font <- "Helvetica"
  ggplot2::theme(plot.title = ggplot2::element_text(family = font, 
                                                    size = 28, face = "bold", color = "#222222"), plot.subtitle = ggplot2::element_text(family = font, 
                                                                                                                                        size = 22),
                 legend.position = "top", legend.text.align = 0, legend.background = ggplot2::element_blank(), 
                 legend.key = ggplot2::element_blank(), 
                 legend.text = ggplot2::element_text(family = font, size = 18, 
                                                     color = "#222222"), 
                 axis.text = ggplot2::element_text(family = font, size = 18, 
                                                   color = "#222222"), axis.ticks = ggplot2::element_blank(), 
                 axis.line = ggplot2::element_blank(), panel.grid.minor = ggplot2::element_blank(), 
                 panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb"), 
                 panel.grid.major.x = ggplot2::element_blank(), panel.background = ggplot2::element_blank(), 
                 strip.background = ggplot2::element_rect(fill = "white"), 
                 strip.text = ggplot2::element_text(size = 22, hjust = 0))
}

proper = function(x) paste0(toupper(substr(x, 1, 1)), tolower(substring(x, 2)))
