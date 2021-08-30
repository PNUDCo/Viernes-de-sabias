setwd("~/Desktop/PNUD/SABIASQUE1/7.crecimiento")
dir()

install.packages("wesanderson")
library(wesanderson)
install.packages("RColorBrewer")
library("RColorBrewer")

actividad<- read_excel("po.xlsx")
actividad$Año=factor(actividad$Año, levels=c("2015","2016","2017","2018","2019","2020","2021"))
actividad$Rama=factor(actividad$Rama, levels=c("Obrero empleado particular","Obrero empleado del gobierno","Empleado doméstico","Trabajador por cuenta propia","Trabajador sin remuneración","Jornalero y peón","Patrón o empleador"))


actividad$Año<- as.Date(actividad$Año)

view(actividad)


####Stacked barplot

lm<- ggplot(actividad, aes(fill=Posición, y=valor, x=Año)) + 
  geom_bar(position="stack", stat="identity")+
  #geom_point(aes(color = edad))+
  #geom_area(aes(color = variable, fill = variable),alpha = 0.5, position = position_dodge(0.8)) +
  #geom_text(label = as.character(EDAD$Valor), size=3, vjust= 2, check_overlap = T)+
  #geom_text(aes(label = scales::comma(value)), size=3, vjust= 2, hjust=0.1, check_overlap = T) +
  scale_y_continuous(labels = label_number(suffix = "%",scale = 1e-0))+
  #scale_y_continuous(labels = comma)+
  labs(x= "",
       y= "% de participación en el total de ocupados ",
       color= "Posición ocupacional",
       title= "Participación en la ocupación por posición ocupacional",
       subtitle= "Enero - junio ( 2015-2021)",
       caption= "Fuente: PNUD con base GEIH, DANE ")+
  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())
#geom_hline(yintercept=0, linetype="dashed", color = "black")
##paleta de colores 
lm + scale_fill_brewer(palette="BuGn")


#lm+scale_fill_manual(values=wes_palette(n=9, name="GrandBudapest2"))



lm + scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))+
  transition_reveal(along = Fecha) +
  shadow_mark()


lm + scale_color_viridis()



ggplot(EDAD, aes(x = Fecha, y = Valor,label=sprintf("%0.2f", round(Valor, digits = 2))))+ 
  geom_smooth(aes(color = edad), size = 1, se = FALSE)+
  transition_reveal(along = Fecha) +
  shadow_mark()


