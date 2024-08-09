import matplotlib.pyplot as plt
import pandas as pd

# Datos de pobreza monetaria GEIH_05
data_pobreza_monetaria_geih_05 = {
    'Año': [2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021],
    'Nacional': [40.8, 38.3, 36.3, 36.1, 36.2, 35.2, 34.7, 35.7, 42.5, 39.3],
    'Urbana': [36.0, 33.9, 31.7, 31.6, 32.4, 31.9, 31.4, 32.3, 42.4, 37.8],
    'Rural': [56.4, 52.8, 51.5, 51.5, 48.8, 46.2, 46.0, 47.5, 42.9, 44.6]
}

# Datos de pobreza monetaria GEIH_18
data_pobreza_monetaria_geih_18 = {
    'Año': [2021, 2022, 2023],
    'Nacional': [39.7, 36.6, 33.0],
    'Urbana': [37.0, 33.8, 30.6],
    'Rural': [48.5, 45.9, 41.2]
}

# Datos de pobreza monetaria extrema GEIH_05
data_pobreza_extrema_geih_05 = {
    'Año': [2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021],
    'Nacional': [11.7, 10.0, 9.4, 9.1, 9.9, 8.4, 8.2, 9.6, 15.1, 12.2],
    'Urbana': [7.9, 7.0, 6.3, 6.0, 6.9, 6.0, 5.8, 6.8, 14.2, 10.3],
    'Rural': [24.2, 19.8, 19.4, 19.4, 20.1, 16.6, 16.2, 19.3, 18.2, 18.8]
}

# Datos de pobreza monetaria extrema GEIH_18
data_pobreza_extrema_geih_18 = {
    'Año': [2021, 2022, 2023],
    'Nacional': [13.7, 13.8, 11.4],
    'Urbana': [11.3, 11.0, 8.9],
    'Rural': [21.6, 23.3, 19.8]
}

# Convertir los datos en DataFrames
df_pobreza_monetaria_geih_05 = pd.DataFrame(data_pobreza_monetaria_geih_05)
df_pobreza_monetaria_geih_18 = pd.DataFrame(data_pobreza_monetaria_geih_18)
df_pobreza_extrema_geih_05 = pd.DataFrame(data_pobreza_extrema_geih_05)
df_pobreza_extrema_geih_18 = pd.DataFrame(data_pobreza_extrema_geih_18)

# Gráfico de Pobreza Monetaria
plt.figure(figsize=(10, 6))
plt.plot(df_pobreza_monetaria_geih_05['Año'], df_pobreza_monetaria_geih_05['Nacional'], marker='o', label='Nacional (GEIH_05)', color='navy')
plt.plot(df_pobreza_monetaria_geih_05['Año'], df_pobreza_monetaria_geih_05['Urbana'], marker='o', label='Urbana (GEIH_05)', color='green')
plt.plot(df_pobreza_monetaria_geih_05['Año'], df_pobreza_monetaria_geih_05['Rural'], marker='o', label='Rural (GEIH_05)', color='purple')
plt.plot(df_pobreza_monetaria_geih_18['Año'], df_pobreza_monetaria_geih_18['Nacional'], marker='o', label='Nacional (GEIH_18)', color='darkblue', linestyle='--')
plt.plot(df_pobreza_monetaria_geih_18['Año'], df_pobreza_monetaria_geih_18['Urbana'], marker='o', label='Urbana (GEIH_18)', color='darkgreen', linestyle='--')
plt.plot(df_pobreza_monetaria_geih_18['Año'], df_pobreza_monetaria_geih_18['Rural'], marker='o', label='Rural (GEIH_18)', color='darkmagenta', linestyle='--')

# Añadir etiquetas en los años 2021, 2022 y 2023
for i in range(len(df_pobreza_monetaria_geih_18)):
    año = df_pobreza_monetaria_geih_18['Año'][i]
    plt.text(año, df_pobreza_monetaria_geih_18['Nacional'][i] + 0.5, f"{df_pobreza_monetaria_geih_18['Nacional'][i]:.1f}%", color='darkblue')
    plt.text(año, df_pobreza_monetaria_geih_18['Urbana'][i] + 0.5, f"{df_pobreza_monetaria_geih_18['Urbana'][i]:.1f}%", color='darkgreen')
    plt.text(año, df_pobreza_monetaria_geih_18['Rural'][i] + 0.5, f"{df_pobreza_monetaria_geih_18['Rural'][i]:.1f}%", color='darkmagenta')

plt.title('Pobreza Monetaria marco GEIH 2005 y 2018.\n (2012 a 2023)')
plt.xlabel('Año')
plt.ylabel('Porcentaje (%)')
plt.legend()
plt.grid(True)
plt.show()

# Gráfico de Pobreza Monetaria Extrema
plt.figure(figsize=(10, 6))
plt.plot(df_pobreza_extrema_geih_05['Año'], df_pobreza_extrema_geih_05['Nacional'], marker='o', label='Nacional (GEIH_05)', color='darkgreen')
plt.plot(df_pobreza_extrema_geih_05['Año'], df_pobreza_extrema_geih_05['Urbana'], marker='o', label='Urbana (GEIH_05)', color='purple')
plt.plot(df_pobreza_extrema_geih_05['Año'], df_pobreza_extrema_geih_05['Rural'], marker='o', label='Rural (GEIH_05)', color='blue')
plt.plot(df_pobreza_extrema_geih_18['Año'], df_pobreza_extrema_geih_18['Nacional'], marker='o', label='Nacional (GEIH_18)', color='forestgreen', linestyle='--')
plt.plot(df_pobreza_extrema_geih_18['Año'], df_pobreza_extrema_geih_18['Urbana'], marker='o', label='Urbana (GEIH_18)', color='darkmagenta', linestyle='--')
plt.plot(df_pobreza_extrema_geih_18['Año'], df_pobreza_extrema_geih_18['Rural'], marker='o', label='Rural (GEIH_18)', color='darkblue', linestyle='--')

# Añadir etiquetas en los años 2021, 2022 y 2023
for i in range(len(df_pobreza_extrema_geih_18)):
    año = df_pobreza_extrema_geih_18['Año'][i]
    plt.text(año, df_pobreza_extrema_geih_18['Nacional'][i] + 0.5, f"{df_pobreza_extrema_geih_18['Nacional'][i]:.1f}%", color='forestgreen')
    plt.text(año, df_pobreza_extrema_geih_18['Urbana'][i] + 0.5, f"{df_pobreza_extrema_geih_18['Urbana'][i]:.1f}%", color='darkmagenta')
    plt.text(año, df_pobreza_extrema_geih_18['Rural'][i] + 0.5, f"{df_pobreza_extrema_geih_18['Rural'][i]:.1f}%", color='darkblue')

plt.title('Pobreza Monetaria Extrema marco GEIH 2005 y 2018.\n(2012 a 2023)' )
plt.xlabel('Año')
plt.ylabel('Porcentaje (%)')
plt.legend()
plt.grid(True)
plt.show()
