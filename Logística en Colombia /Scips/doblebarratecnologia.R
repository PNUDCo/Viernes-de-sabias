dat9 <- data.frame(
  Dominio= factor(c("Bogotá","Bogotá","Bogotá","Bogotá","Bogotá","Bogotá","Bogotá","Bogotá","Bogotá","Bogotá","Bogotá","Nacional","Nacional", "Nacional", "Nacional", "Nacional","Nacional","Nacional","Nacional","Nacional","Nacional","Nacional")),
  tecnología = factor(c("Ninguna","Rastreo y seguimiento pedidos","Factura electrónica","Rastreo y seguimiento vehículos","Intercambio electrónico de datos EDI","Captura con código de barras", "Sistemas y/o aplicativos  de gestión de bodegas WMS", "Sistemas y aplicativos  de planificación de recursos empresariales", "Prónostico y planeación de demanda", "Sistemas y/o aplicativos  de administración de transporte","Captura  con identificación de radio frecuencia"), levels=c("Ninguna","Rastreo y seguimiento pedidos","Factura electrónica","Rastreo y seguimiento vehículos","Intercambio electrónico de datos EDI","Captura con código de barras", "Sistemas y/o aplicativos  de gestión de bodegas WMS", "Sistemas y aplicativos  de planificación de recursos empresariales", "Prónostico y planeación de demanda", "Sistemas y/o aplicativos  de administración de transporte","Captura  con identificación de radio frecuencia")),
  porcentaje = c(60.1,16.9,14.9,15,11.6,9.4,3.3,3.3,2.9,2,0.9,64.4,14.5,13.4,12.2,7.9,7.2,2.8,2.4,2.1,1.4,1.1))

h<-ggplot(data=dat9, aes(x=tecnología, y=porcentaje, fill=Dominio,)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")+
  coord_flip()+
  theme(
    legend.position = "none",
    panel.border = element_blank(),
  ) +
  xlab("") +
  #ylab("Value of Y")+
  labs(x= "Tipo de tecnología",
       y= "Porcentaje",
       color= "Población",
       #color= "Rango de edad",
       title= "Adopción de tecnologías en logística por parte de las empresas",
       #subtitle= "2010- 2018",
       caption= "Fuente: PNUD con base en ENL 2018")+
  theme_bw()+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  scale_y_continuous(labels = label_number(suffix = "%",scale = 1e-0))+
  


h+ scale_fill_viridis_d()+
  transition_reveal(tecnología) 