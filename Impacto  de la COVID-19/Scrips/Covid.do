clear all

set dp comma

cd "D:\Google Drive\PNUD\Mision Calidad\3 Marzo\Data lab"

import excel "Poblacion.xlsx", sheet("Hoja1") firstrow clear

save poblacion.dta, replace

import delimited "Casos_positivos_de_COVID-19_en_Colombia.csv", varnames(1) encoding(UTF-8) 

gen dpto= subinstr(códigodivipoladepartamento , ",", "",.)
destring dpto, replace

gen mcpio= subinstr(códigodivipolamunicipio , ",", "",.)
destring mcpio, replace

replace recuperado="Fallecido" if recuperado=="fallecido"

split fechadenotificación, parse(" ") gen(d)

drop d2

gen date=date(d1, "DMY")

format date %td

save "BD.dta", replace

gen n=1

gen dto=dpto
replace dto=8 if dto==8001
replace dto=13 if dto==13001
replace dto=47 if dto==47001


preserve
collapse (sum) n, by(dto date)
bysort dto (date) : gen cumsum =sum(n)
merge m:1 dto using "poblacion.dta"
drop _merge
gen tasa=(n/poblacion)*100000
keep dto date tasa
reshape wide tasa, j(dto) i(date)
export excel "Casos.xlsx", replace firstrow(variables)
restore

preserve
collapse (sum) n if recuperado=="Fallecido", by(dto date)
bysort dto (date) : gen cumsum =sum(n)
*merge m:1 dto using "poblacion.dta"
*drop _merge
*gen tasa=(n/poblacion)*10000
keep dto date cumsum
reshape wide cumsum, j(dto) i(date)
export excel "Fallecidos.xlsx", replace firstrow(variables)
restore



