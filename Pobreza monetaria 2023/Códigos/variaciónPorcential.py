import matplotlib.pyplot as plt
import numpy as np

# Datos del PIB
trimestres = [
    '2007 I', '2007 II', '2007 III', '2007 IV',
    '2008 I', '2008 II', '2008 III', '2008 IV',
    '2009 I', '2009 II', '2009 III', '2009 IV',
    '2010 I', '2010 II', '2010 III', '2010 IV',
    '2011 I', '2011 II', '2011 III', '2011 IV',
    '2012 I', '2012 II', '2012 III', '2012 IV',
    '2013 I', '2013 II', '2013 III', '2013 IV',
    '2014 I', '2014 II', '2014 III', '2014 IV',
    '2015 I', '2015 II', '2015 III', '2015 IV',
    '2016 I', '2016 II', '2016 III', '2016 IV',
    '2017 I', '2017 II', '2017 III', '2017 IV',
    '2018 I', '2018 II', '2018 III', '2018 IV',
    '2019 I', '2019 II', '2019 III', '2019 IV',
    '2020 I', '2020 II', '2020 III', '2020 IV',
    '2021 I', '2021 II', '2021 III', '2021 IV',
    '2022 I', '2022 II', '2022 III', '2022 IV',
    '2023 I', '2023 II', '2023 III', '2023 IV',
    '2024 I'
]
pib = [
    137366, 141264, 148815, 159013,
    144477, 148027, 153749, 159460,
    144690, 149053, 154577, 164296,
    150306, 155948, 160825, 173073,
    160528, 166527, 173545, 184028,
    170382, 174601, 177449, 188983,
    174447, 183981, 188524, 200987,
    185963, 190290, 196780, 208557,
    191216, 196798, 203824, 212853,
    195759, 200982, 207001, 217747,
    197840, 203513, 210526, 220777,
    201119, 209139, 216587, 227163,
    208068, 215533, 223375, 234249,
    209047, 179359, 203149, 226345,
    212016, 212786, 230210, 251231,
    229390, 238992, 247215, 256700,
    235649, 239690, 245408, 257486,
    237181
]

# Calcular la variación porcentual trimestre a trimestre
variacion_porc = [0]  # El primer valor no tiene una variación anterior
for i in range(1, len(pib)):
    variacion = ((pib[i] - pib[i - 1]) / pib[i - 1]) * 100
    variacion_porc.append(variacion)

# Crear la gráfica de barras
plt.figure(figsize=(14, 7))
trimestres_np = np.array(trimestres)
plt.bar(trimestres_np, variacion_porc, color='skyblue')
plt.title('Variación Porcentual Trimestral del PIB de Colombia (2007 - 2024)', fontsize=16, fontweight='bold')
plt.xlabel('Trimestres', fontsize=14)
plt.ylabel('Variación Porcentual (%)', fontsize=14)
plt.xticks(rotation=90)

# Separar los trimestres por años
for i in range(len(trimestres_np)):
    if i % 4 == 0:
        plt.axvline(x=i-0.5, color='black', linewidth=0.8)

plt.tight_layout()
plt.show()
