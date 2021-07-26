# Libraries
library(tidyverse)
library(hrbrthemes)
library(kableExtra)
options(knitr.table.format = "html")
library(patchwork)

# Load dataset from github
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/7_OneCatOneNum.csv", header=TRUE, sep=",")

# Plot
data %>%
  filter(!is.na(Value)) %>%
  arrange(Value) %>%
  tail(20) %>%
  mutate(Country=factor(Country, Country)) %>%
  ggplot( aes(x=Country, y=Value) ) +
  geom_segment( aes(x=Country ,xend=Country, y=0, yend=Value), color="grey") +
  geom_point(size=3, color="#69b3a2") +
  coord_flip() +
  theme_ipsum() +
  theme(
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_blank(),
    legend.position="none"
  ) +
  xlab("") +
  ylab("Weapon quantity (SIPRI trend-indicator value)")

# Create data (could be way easier but it's late)
setwd("~/Desktop/PNUD/SABIASQUE1/6.Tributaria")
dir()
don<- read_excel("gini.xlsx")
don$País=factor(don$País, levels=c("COL","CHI","MEX", "USA","JPN","CAN","IRL","OCDE","NZL","FRA","ALE","KOR","BEL","FIN","NOR","DNK"))





# With a bit more style
ggplot(don) +
  geom_segment( aes(x=País, xend=País,, y=ANTES, yend=DESPUES), color="grey") +
  geom_point( aes(x=País,, y=ANTES), color=rgb(0.2,0.7,0.1,0.8), size=3 ) +
  geom_point( aes(x=País,, y=DESPUES), color=rgb(0.4,0.5,0.7,0.6), size=3 ) +
  #coord_flip()+
  scale_y_continuous(breaks = seq(0.20, 0.60, by = 0.05))+
  theme_ipsum() +
  theme(
    legend.position = "none",
    panel.border = element_blank(),
  ) +
  xlab("") +
  #ylab("Value of Y")+
  labs(x= "País",
       y= "Coeficiente de GINI",
       #color= "Rango de edad",
       title= "Desigualdad antes y después de impuestos y transferencias",
       subtitle= "Paises miembro de la  OCDE 2019*",
       caption= "Fuente: PNUD con base la base de  distribución de ingresos y pobreza de  la OCDE \n *Los datos pueden variar de acuerdo al último año disponible por país")+
  theme_bw()+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  transition_reveal(as.integer(País))
    
  
  




View(don)