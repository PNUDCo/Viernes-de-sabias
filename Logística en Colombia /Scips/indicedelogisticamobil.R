library(hrbrthemes)
install.packages("RColorBrewer")
library("RColorBrewer")
setwd("~/Desktop/PNUD/SABIASQUE1/8.DocLogística")
dir()


actividad<- read_excel("scatter1.xlsx")
view(actividad)
#actividad$TOTAL=factor(actividad$TOTAL, levels=c("Agricultura","Manufactura construcción","Suministro SSPP","Comercio,transporte,servicios comida","Información y comunicaciones","Actividades financieras y de seguros","Actividades inmobiliarias","Actividades profesionales y adminsitrativas", "Administración pública"))
#actividad$sec=factor(actividad$sec, levels=c("Primaria","Secundaria","Terciaria")
actividad$país=factor(actividad$país, levels=c("Haití","Cuba","Nicaragua","Honduras","Guatemala","Bolivia","Jamaica","El Salvador","Paraguay","Ecuador","Perú","Panama","México","Venezuela","Costa Rica","Brasil","Argentina","Colombia","Uruguay","Chile","España","Portugal","América del Norte")
#actividad$Fecha<- as.Date(actividad$Fecha)





 


# Basic scatter plot
ggplot(actividad, aes(x=x, y=y)) + geom_point()
# Change the point size, and shape
sc<-ggplot(actividad, aes(x=x, y=y, color=país)) +
  geom_point(size=5, shape=18)+
  #geom_smooth(method = "lm")+
  #geom_text(país)+
  geom_hline(yintercept=0, linetype="dashed", color = "black")+
  geom_vline(xintercept=0, linetype="dashed", color = "black")+
  labs(x= "Ecosistema digital",
       y= "Índice  de logística" ,
       color= "País",
       title= "Índice de logística vs ecosistema digital",
       subtitle= "",
       caption= "Fuente: PNUD con base en Logistics Performance Index 2018")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  
  
  sc+ scale_fill_viridis_c()+
  transition_reveal(along = x) +
  shadow_mark()


