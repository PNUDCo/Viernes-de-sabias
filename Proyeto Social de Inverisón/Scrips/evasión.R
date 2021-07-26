# Create data (could be way easier but it's late)
setwd("~/Desktop/PNUD/SABIASQUE1/6.Tributaria")
dir()
don<- read_excel("eva.xlsx")
don$pais=factor(don$pais, levels=c("2010","2011", "2012", "2013", "2014", "2015", "2016" , "2017","2018"))
don$Impuesto=factor(don$Impuesto, levels=c("Impuestos al ingreso de las personas","Aportes de seguridad social","Otros impuestos  a bienes y servicios","Otros impuestos","Impuesos  sobre ingreso de empresas","Impuestos sobre la propiedad","Impuesto al valor agregado / bienes y servicios"))


ggplot(data = don) +
  geom_bar( mapping = aes(x = País, y = Por),
            position = "dodge")


ggplot(don, aes(x = pais, y =ina , fill= pais)) +
  geom_bar(stat = "identity")+
  #coord_flip()+
  theme(
    legend.position = "none",
    panel.border = element_blank(),
  ) +
  xlab("") +
  #ylab("Value of Y")+
  labs(x= "Año",
       y= "Porcentaje",
       #color= "Rango de edad",
       title= "Evolución de la tasa de evación en Colombia ",
       subtitle= "2010- 2018",
       caption= "Fuente: PNUD con base a Fedesarrollo")+
  theme_bw()+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  scale_y_continuous(labels = label_number(suffix = "%",scale = 1e-0))