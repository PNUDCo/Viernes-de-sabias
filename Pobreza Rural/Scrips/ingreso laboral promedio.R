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


Pkgs <- c("ggplot2", "tidyverse", "dplyr", "highcharter", "hrbrthemes", "ggrepel", 
          "stringr", "skimr", "viridis", "haven", "stats", "RColorBrewer", "fontawesome",
          "ggpubr", "knitr", "broom", "ggthemes", "zoo", "readxl", "kableExtra", "emojifont",
          "lubridate", "ggalt", "htmltools", "gridExtra", "billboarder", "gapminder",
          "gganimate", "magick", "bbplot")                    


lapply(Pkgs, library, character.only = TRUE)

setwd("~/Desktop/PNUD/SABIASQUE1/4. Rural")


Clases <- read_excel("salario.xlsx",
                     sheet = 1)
Colors_U <- c("#fa3a18", 
              "#1380A1",
              "#990000", 
              "#588300")

Animation <- Clases %>%
  ggplot(aes(x= date, 
             y=value,
             color = variable)) + 
  geom_line() +
  scale_size(guide = FALSE) +
  #bbc_style() +
  #geom_text(aes(label = as.character(value)), 
            #hjust = 0, vjust= 0, size = 4, family = "Helvetica") +
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
  scale_color_viridis_d(name = "Categoría",
                        guide = guide_legend(override.aes = list(size = 4,
                                                                 alpha = 1))) +
  
  scale_y_continuous(labels = label_number(suffix = "%",scale = 1e-0))+
  geom_text(aes(label = scales::comma(value)), size=2.5, vjust= 2, hjust=0.1, check_overlap = T) +
  scale_y_continuous(labels = label_number(suffix = "",scale = 1e-0))+
  scale_y_continuous(labels = comma)+
  #theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  labs(x= "Año",
       y= "Salario en pesos constantes",
       color= "Dominio geográfico",
       title= "Ingreso laboral promedio de la población ocupada por dominio",
       subtitle= "Cifras en precios constantes. (2008-2020)",
       caption= "Fuente: PNUD con base a GEIH y FILCO \n  *Precios base 2018")+

  transition_reveal(as.integer(date))


GIF <- animate(Animation,
               duration = 10,
               fps = 10,
               width =550,
               height =550,
               renderer = magick_renderer())

GIF
