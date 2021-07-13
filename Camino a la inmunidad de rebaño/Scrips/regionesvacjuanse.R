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

setwd("~/Desktop/PNUD/SABIASQUE1/5. Vacunación2")


Clases <- read_excel("sas.xlsx",
                     sheet = 1)
Colors_U <- c("#FAAB18", 
              "#1380A1",
              "#990000", 
              "#588300")

Animation <- Clases %>%
  ggplot(aes(x= date, 
             y=porceb,
             color = variable)) + 
  geom_line(lwd=1) +
  geom_point()+
  scale_size(guide = FALSE) +
  #bbc_style() +
  geom_text(aes(label = as.character(porceb)), 
            hjust = 0, vjust= 0, size = 4, family = "Helvetica") +
  #geom_text(aes(x= max(date), 
                #y=min(value) , 
                #label = as.factor(date)), 
            #vjust = 0.2, hjust = 1, alpha = 0.5,  col = "gray", size = 15) +
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
  scale_color_viridis_d(name = "Región geográfica",
                        guide = guide_legend(override.aes = list(size = 4,
                                                                 alpha = 1))) +
  scale_y_continuous(labels = label_number(suffix = "%"))+
 #scale_y_continuous(labels = comma)+
  labs(x= "Mes",
       y= "Porcentaje de población",
       #color= "Dominio geográfico",
       title= "Porcentaje de población con al menos una  dosis aplicada",
       subtitle= "Población relativa por región geográfica. (Corte 4 de julio)",
       caption= "Fuente: PNUD con base Minsalud  y DANE" )+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  transition_reveal(as.integer(date))


GIF <- animate(Animation,
               duration = 10,
               fps = 10,
               width =550,
               height =550,
               renderer = magick_renderer())

GIF
