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






salud<- waffle(c('Dosis aplicada = 88.4%' = 88.4, 'Sin aplicar = 11.5%' = 11.6), rows = 5, colors = c("deepskyblue4", "lightgrey"), title = 'Personal Médico  ')
mayores<- waffle(c('Dosis aplicada = 77.6%' = 77.6, 'Sin aplicar = 22.4%' = 22.4), rows = 5, colors = c("deepskyblue4", "lightgrey"), title = 'Personas mayores de 80 años')

iron(
  salud + theme_minimal() + theme(plot.title = element_text(hjust=0.5)),
  mayores + theme_minimal() + theme(plot.title = element_text(hjust=0.5)))










