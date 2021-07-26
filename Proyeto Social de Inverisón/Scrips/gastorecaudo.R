dat9 <- data.frame(
  Response = factor(c("Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo")),
  Category = factor(c("OCDE","IRL","USA","MEX","CHI","COL", "BEL", "FRA", "FIN", "DNK","NOR","ALE","CAN","NZL","JPN","DNK","KOR","LATAM","OCDE","IRL","USA","MEX","CHI","COL", "BEL", "FRA", "FIN", "DNK","NOR","ALE","CAN","NZL","JPN","DNK","KOR","LATAM" ),
                    levels=c("OCDE","IRL","USA","MEX","CHI","COL", "BEL", "FRA", "FIN", "DNK","NOR","ALE","CAN","NZL","JPN","DNK","KOR","LATAM")),
  percentage = c(40,26,35,26,25,27.5,52,56,53,52,48,44,41,36,36.5,40,26,35,26,25,22,22,24,51,53,52,52,53,46,41,38,33,24,27))
dat9$Response <- factor(dat9$Response,levels=c("Gasto","Recaudo"))
ggplot(data=dat9, aes(x=Category, y=percentage, fill=Response,)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")



dat9 <- data.frame(
  Response = factor(c("Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Recaudo","Recaudo", "Recaudo", "Recaudo",  "Recaudo", "Recaudo","Recaudo","Recaudo")),
  Category = factor(c("OCDE","IRL","USA","MEX","CHI","COL","BEL","FRA","OCDE","IRL","USA","MEX","CHI","COL","BEL","FRA"), levels=c("OCDE","IRL","USA","MEX","CHI","COL","BEL","FRA")),
  percentage = c(40,26,35,26,25,27.5,52,56, 40, 25, 31, 22, 22,24,51,53))
dat9$Response <- factor(dat9$Response,levels=c("Gasto","Recaudo"))
ggplot(data=dat9, aes(x=Category, y=percentage, fill=Response,)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")




dat9 <- data.frame(
  categoría= factor(c("Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Gasto","Recaudo","Recaudo", "Recaudo", "Recaudo",  "Recaudo", "Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo","Recaudo")),
  Category = factor(c("OCDE","IRL","USA","MEX","CHI","COL","BEL","FRA","FIN","DNK","NOR","ALE","CAN","NZL","JPN","KOR","LATAM","OCDE","IRL","USA","MEX","CHI","COL","BEL","FRA","FIN","DNK","NOR","ALE","CAN","NZL","JPN","KOR","LATAM"), levels=c("OCDE","IRL","USA","MEX","CHI","COL","BEL","FRA","FIN","DNK","NOR","ALE","CAN","NZL","JPN","KOR","LATAM")),
  percentage = c(40,26,35,26,25,27.5,52,56,53,52,48,44,41,36,36.5,22,30, 40, 25, 31, 22, 22,24,51,53,52,52,53,46,41,38,33,24,27))
dat9$categoría <- factor(dat9$categoría,levels=c("Gasto","Recaudo"))
ggplot(data=dat9, aes(x=Category, y=percentage, fill=categoría,)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")+
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
       title= "Comparación del ingreso y gasto como % del PIB",
       subtitle= "Comparativa internacional OCDE. 2019",
       caption= "Fuente: PNUD con base a perspectivas mundiales, FMI")+
  theme_bw()+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())+
  scale_y_continuous(labels = label_number(suffix = "%"))


