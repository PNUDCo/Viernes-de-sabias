library(hrbrthemes)
actividad<- read_excel("scatter.xlsx")
actividad$TOTAL=factor(actividad$TOTAL, levels=c("Agricultura","Manufactura construcción","Suministro SSPP","Comercio,transporte,servicios comida","Información y comunicaciones","Actividades financieras y de seguros","Actividades inmobiliarias","Actividades profesionales y adminsitrativas", "Administración pública"))
actividad$sec=factor(actividad$sec, levels=c("Primaria","Secundaria","Terciaria")
actividad$Fecha<- as.Date(actividad$Fecha)


# Basic scatter plot
ggplot(actividad, aes(x=variación, y=ISE)) + geom_point()
# Change the point size, and shape
ggplot(actividad, aes(x=variación, y=participación, color=TOTAL)) +
  geom_point(size=5, shape=19)+
  geom_hline(yintercept=0, linetype="dashed", color = "black")+
  geom_vline(xintercept=0, linetype="dashed", color = "black")+
  labs(x= "Variación en la ocupación bienal 2019-2021",
       y= "ISE por variación en volumen Bienal 2019-2021",
       color= "Rama de actividad",
       title= "Variación bienal  por principales ramas de actividad ",
       subtitle= "2019 -2021",
       caption= "Fuente: PNUD con base GEIH, DANE")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())





ggplot(actividad, aes(x=variación, y=ISE, color=TOTAL))+
  geom_point() + 
  geom_label(
    label=rownames(actividad), 
    nudge_x = 0.25, nudge_y = 0.25, 
    check_overlap = T
  )