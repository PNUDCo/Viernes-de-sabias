install.packages(c("waffle", "extrafont"))
library(waffle)
library(extrafont)
font_import()

# check that Font Awesome is imported
fonts()[grep("Awesome", fonts())]
# [1] "FontAwesome"

# this should be fine for Mac OSX
loadfonts()

# Chart 3
iron(
  waffle(c(no = 11.7, yes = 88.34), rows = 5, use_glyph = "child", glyph_size = 6,
         colors = c("#c7d4b6", "#a3aabd"), title = "Profesionales de la salud"),
  waffle(c(no = 22.4, yes = 77,6), rows = 5,use_glyph = "child", glyph_size = 6,
         colors = c("#c7d4b6", "#a3aabd"), title = "MAyores de 80 años")
)









salud<- waffle(c('Vacunados = 88.34%' = 88.4, 'No vacunados = 11.65%' = 11.6), rows = 5, colors = (c("orange", "lightgrey"), title = 'Medicos'), title = 'Población vacunada Etapa - I PNV (%)')
mayores<- waffle(c('Vacunados = 77.6%' = 77.6, 'No vacunados = 22.4%' = 22.4), rows = 5, colors = c("orange", "lightgrey"), title = 'Mayores 80 años')






salud<- waffle(c('Avance = 100%' = 100, 'Sin  cobertura = 0%' = 0), rows = 3, colors = c("deepskyblue4", "lightgrey"), title = 'Etapa 1: Personal Médico  ')
mayores<- waffle(c('Avance = 89.54%' = 89.54, 'Sin  cobertura  = 10.46%' = 10.46), rows = 3, colors = c("deepskyblue4", "lightgrey"), title = 'Etapa 1: Personas mayores de 80 años')
prueba<- waffle(c('Avance= 73.08%' = 73.08, 'Sin  cobertura  = 26.92%' = 26.92), rows = 3, colors = c("slateblue4", "lightgrey"), title = 'Etapa 2: Personas entre 60 a 79 años')
prueba2<- waffle(c('Avance = 51.53%' = 51.53, 'Sin  cobertura  = 48.47%' = 48.47), rows = 3, colors = c("springgreen4", "lightgrey"), title = 'Etapa 3: Personas entre 50 a 59 años')
prueba3<- waffle(c('Avance= 7.81%' = 7.81, 'Sin  cobertura  = 92.19%' = 92.19), rows = 3, colors = c("lightsalmon4", "lightgrey"), title = 'Etapa 4: Personas entre 45 a 49 años')


iron(
  salud + theme_minimal() + theme(plot.title = element_text(hjust=0.5)),
  mayores + theme_minimal() + theme(plot.title = element_text(hjust=0.5)),
  prueba + theme_minimal() + theme(plot.title = element_text(hjust=0.5)),
  prueba2 + theme_minimal() + theme(plot.title = element_text(hjust=0.5)),
  prueba3 + theme_minimal() + theme(plot.title = element_text(hjust=0.5)))
  










