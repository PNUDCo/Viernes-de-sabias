# Create data (could be way easier but it's late)
setwd("~/Desktop/PNUD/SABIASQUE1/6.Tributaria")
dir()
don<- read_excel("taxstructure.xlsx")
don$Región=factor(don$Región, levels=c("Colombia","OCDE", "LATAM"))
don$Impuesto=factor(don$Impuesto, levels=c("Impuestos al ingreso de las personas","Aportes de seguridad social","Otros impuestos  a bienes y servicios","Otros impuestos","Impuesos  sobre ingreso de empresas","Impuestos sobre la propiedad","Impuesto al valor agregado / bienes y servicios"))


ggplot(data = don) +
  geom_bar( mapping = aes(x = Región, y = valor, fill = Impuesto),
    position = "dodge")


ggplot(don, aes(x = Región, y = valor, fill = Impuesto)) +
  geom_bar(stat = "identity")+
  coord_flip()+
  theme(
    legend.position = "none",
    panel.border = element_blank(),
  ) +
  xlab("") +
  #ylab("Value of Y")+
  labs(x= "Región",
       y= "Porcentaje",
       #color= "Rango de edad",
       title= "Estructura tributaria: participación de cada ingreso en el total del recaudo fiscal",
       subtitle= "Estadísticas de Ingresos por región",
       caption= "Fuente: PNUD con base a Revenue Statistics in Latin America and the Caribbean 2021 - Colombia \n *La OCDE  promedia los  datos por la falta de algunos registros anuales")+
  theme_bw()+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
        scale_y_continuous(labels = label_number(suffix = "%",scale = 1e-0))

+
  transition_reveal(as.integer(País))