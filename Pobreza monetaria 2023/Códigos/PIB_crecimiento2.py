import matplotlib.pyplot as plt
import numpy as np
from scipy.interpolate import make_interp_spline

# Datos simulados de crecimiento anual (%)
trimestres = ['2021 I', '2021 II', '2021 III', '2021 IV', 
              '2022 I', '2022 II', '2022 III', '2022 IV', 
              '2023 I', '2023 II', '2023 III', '2023 IV', 
              '2024 I']
crecimiento_original = [1.4, 18.6, 13.3, 11.0, 8.2, 7.4, 2.2, 0.3, -0.7, 0.3, 0.4, 0.9, 0.7]
crecimiento_ajustado = [1.4, 18.7, 13.5, 11.1, 8.0, 7.3, 2.1, 0.3, -0.7, 0.3, 0.4, 0.9, 0.7]

# Crear la gráfica
plt.figure(figsize=(12, 6))

# Crear líneas curvas utilizando splines
x = np.arange(len(trimestres))
xnew = np.linspace(x.min(), x.max(), 300) 

spl_original = make_interp_spline(x, crecimiento_original, k=3)
spl_ajustado = make_interp_spline(x, crecimiento_ajustado, k=3)

crecimiento_original_smooth = spl_original(xnew)
crecimiento_ajustado_smooth = spl_ajustado(xnew)

plt.plot(xnew, crecimiento_original_smooth, linestyle='-', color='black', label='Original')
plt.plot(xnew, crecimiento_ajustado_smooth, linestyle='--', color='teal', linewidth=3, label='Ajustada por efecto estacional y calendario')

# Agregar los puntos originales
plt.scatter(x, crecimiento_original, color='black')
plt.scatter(x, crecimiento_ajustado, color='teal')

# Agregar los valores solo en la serie original
for i in range(len(trimestres)):
    if trimestres[i] == '2021 I':
        plt.text(x[i] - 0.1, crecimiento_original[i] + 2, f'{crecimiento_original[i]}%', color='black', fontsize=10, ha='right', va='bottom')
    elif trimestres[i] == '2021 II':
        plt.text(x[i], crecimiento_original[i] - 2, f'{crecimiento_original[i]}%', color='black', fontsize=10, ha='center', va='top')
    else:
        plt.text(x[i], crecimiento_original[i] + 1, f'{crecimiento_original[i]}%', color='black', fontsize=10, ha='center', va='bottom')

# Personalizar el gráfico
plt.title('Producto Interno Bruto (PIB)\nTasas de crecimiento anuales (%) en volumen', fontsize=16, fontweight='bold')
plt.xlabel('Trimestres', fontsize=14)
plt.ylabel('%', fontsize=14)
plt.ylim(-5, 20)
plt.xticks(x, trimestres, rotation=45, ha='right')

# Añadir líneas verticales solo en donde comienza cada año
for i in range(0, len(trimestres), 4):
    plt.axvline(x=i, color='black', linewidth=1)

plt.legend()
plt.tight_layout()
plt.show()
