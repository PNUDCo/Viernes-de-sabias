import matplotlib.pyplot as plt
import numpy as np

# Datos de ocupación para los años 2022, 2023, y 2024
años = [2022, 2023, 2024]
ocupacion_por_rama_2022 = [3224, 282, 2344, 306, 1547, 3970, 1483, 1595, 383, 419, 221, 1734, 2665, 1851]
ocupacion_por_rama_2023 = [3280, 279, 2401, 310, 1565, 4020, 1639, 1706, 403, 422, 275, 1822, 2738, 1925]
ocupacion_por_rama_2024 = [3245, 255, 2425, 300, 1488, 3980, 1564, 1701, 360, 428, 296, 1773, 2620, 1950]

# Calcular la variación porcentual entre los años
variacion_2022_2023 = [(y2023 - y2022) / y2022 * 100 for y2022, y2023 in zip(ocupacion_por_rama_2022, ocupacion_por_rama_2023)]
variacion_2023_2024 = [(y2024 - y2023) / y2023 * 100 for y2023, y2024 in zip(ocupacion_por_rama_2023, ocupacion_por_rama_2024)]

actividades_economicas = [
    "Agricultura, ganadería, caza, silvicultura y pesca",
    "Explotación de minas y canteras",
    "Industrias manufactureras",
    "Suministro de electricidad, gas, agua y gestión de desechos",
    "Construcción",
    "Comercio y reparación de vehículos",
    "Alojamiento y servicios de comida",
    "Transporte y almacenamiento",
    "Información y comunicaciones",
    "Actividades financieras y de seguros",
    "Actividades inmobiliarias",
    "Actividades profesionales, científicas y técnicas",
    "Administración pública y defensa, educación y salud humana",
    "Actividades artísticas, entretenimiento y recreación"
]

# Crear la gráfica
fig, ax = plt.subplots(figsize=(14, 8))
bar_width = 0.35
index = np.arange(len(actividades_economicas))

bars1 = ax.bar(index, variacion_2022_2023, bar_width, label='Variación 2022-2023', color='skyblue')
bars2 = ax.bar(index + bar_width, variacion_2023_2024, bar_width, label='Variación 2023-2024', color='teal')

# Añadir los valores en las barras
for i, v in enumerate(variacion_2022_2023):
    ax.text(i, v + (0.5 if v >= 0 else -2), f'{v:.1f}%', color='black', ha='center')
for i, v in enumerate(variacion_2023_2024):
    ax.text(i + bar_width, v + (0.5 if v >= 0 else -2), f'{v:.1f}%', color='black', ha='center')

# Etiquetas y título
ax.set_xlabel('Rama de Actividad Económica')
ax.set_ylabel('Variación Porcentual (%)')
ax.set_title('Variación Porcentual en el Número de Ocupados\npor Rama de Actividad Económica', fontsize=16, fontweight='bold')
ax.set_xticks(index + bar_width / 2)
ax.set_xticklabels(actividades_economicas, rotation=45, ha='right')
ax.legend()

plt.tight_layout()
plt.show()
