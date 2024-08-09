import matplotlib.pyplot as plt
import numpy as np

# Datos de la tabla
actividades_economicas = [
    'Administración pública, defensa, educación, salud',
    'Agricultura, ganadería, caza, silvicultura y pesca',
    'Suministro de electricidad, gas, vapor y agua',
    'Actividades artísticas, entretenimiento, hogares',
    'Actividades inmobiliarias',
    'Construcción',
    'Actividades profesionales, científicas y técnicas',
    'Información y comunicaciones',
    'Explotación de minas y canteras',
    'Actividades financieras y de seguros',
    'Comercio, reparación, transporte y alojamiento',
    'Industrias manufactureras',
    'Valor agregado',
    'Impuestos menos subvenciones',
    'Producto Interno Bruto'
]

tasas_crecimiento_2023 = [0.1, 1.0, 1.6, 15.3, 1.9, -3.1, 1.9, 1.9, 3.6, 23.0, -0.5, 1.5, 2.4, 6.2, 2.7]
tasas_crecimiento_2024 = [5.3, 5.5, 4.5, 5.2, 1.7, 0.7, -0.2, -1.6, -1.5, -3.0, -0.8, -5.9, 0.7, 0.4, 0.7]

# Crear la gráfica
fig, ax = plt.subplots(figsize=(12, 8))

bar_width = 0.35
index = np.arange(len(actividades_economicas))

# Cambiar el orden de las barras para que las azules estén arriba y las verdes abajo
bars1 = ax.barh(index + bar_width, tasas_crecimiento_2023, bar_width, label='2023p - I / 2022p - I', color='skyblue')
bars2 = ax.barh(index, tasas_crecimiento_2024, bar_width, label='2024pr - I / 2023pr - I', color='teal')

# Añadir los valores en las barras
for i, v in enumerate(tasas_crecimiento_2023):
    ax.text(v + 0.1, i + bar_width, str(v), color='black', va='center')
for i, v in enumerate(tasas_crecimiento_2024):
    ax.text(v + 0.1, i, str(v), color='black', va='center')

# Etiquetas y título
ax.set_xlabel('Tasas de crecimiento anual (%)')
ax.set_title('Producto Interno Bruto (PIB). Enfoque de la producción\nTasas de crecimiento anual (%)  \n Valor agregado por actividad \n 2023pr – 2024pr (primer trimestre)', fontsize=14, fontweight='bold')
ax.set_yticks(index + bar_width / 2)
ax.set_yticklabels(actividades_economicas)
ax.legend()

plt.tight_layout()
plt.show()
