import pandas as pd
import matplotlib.pyplot as plt

# Data for Total Nacional
data_nacional = {
    "Year": list(range(2007, 2025)),
    "% Población en edad de trabajar": [71.1, 71.6, 72.2, 72.7, 73.2, 73.7, 74.2, 74.6, 75.1, 75.5, 75.8, 76.1, 76.4, 76.7, 77.0, 77.2, 77.5, 77.7],
    "Tasa Global de Participación (TGP)": [63.7, 63.8, 66.6, 67.7, 68.1, 68.6, 67.8, 67.4, 67.5, 66.9, 66.4, 65.7, 64.8, 60.4, 61.5, 63.6, 64.1, 63.8],
    "Tasa de Ocupación (TO)": [56.5, 56.5, 58.5, 59.6, 60.6, 61.3, 61.0, 61.1, 61.3, 60.5, 60.0, 59.1, 57.7, 50.4, 53.1, 56.5, 57.6, 56.6],
    "Tasa de Desocupación (TD)": [11.3, 11.4, 12.2, 12.0, 11.1, 10.6, 9.9, 9.4, 9.2, 9.5, 9.7, 10.0, 10.9, 16.7, 13.8, 11.2, 10.2, 11.3]
}

# Data for Cabeceras (Urbano)
data_urbano = {
    "Year": list(range(2007, 2025)),
    "% Población en edad de trabajar": [72.5, 73.0, 73.5, 74.0, 74.6, 75.1, 75.6, 76.0, 76.4, 76.8, 77.2, 77.5, 77.8, 78.1, 78.4, 78.7, 78.9, 79.2],
    "Tasa Global de Participación (TGP)": [64.8, 65.1, 67.4, 68.3, 69.0, 69.3, 68.6, 68.5, 68.3, 67.6, 66.9, 66.3, 65.6, 61.2, 62.4, 64.6, 65.0, 64.8],
    "Tasa de Ocupación (TO)": [56.8, 57.1, 58.5, 59.5, 60.7, 61.2, 61.1, 61.4, 61.4, 60.4, 59.7, 58.9, 57.7, 49.9, 53.0, 56.8, 57.9, 57.0],
    "Tasa de Desocupación (TD)": [12.3, 12.2, 13.3, 12.9, 12.0, 11.7, 10.9, 10.3, 10.1, 10.6, 10.9, 11.2, 12.0, 18.6, 15.1, 12.0, 10.9, 12.1]
}

# Data for Rural
data_rural = {
    "Year": list(range(2007, 2025)),
    "% Población en edad de trabajar": [67.1, 67.6, 68.1, 68.5, 69.0, 69.5, 70.0, 70.4, 70.8, 71.2, 71.6, 71.9, 72.0, 72.1, 72.2, 72.4, 72.6, 72.8],
    "Tasa Global de Participación (TGP)": [60.1, 59.8, 63.9, 65.7, 65.1, 66.1, 64.9, 63.9, 64.7, 64.4, 64.7, 63.5, 61.9, 57.7, 58.5, 60.2, 60.9, 60.0],
    "Tasa de Ocupación (TO)": [55.4, 54.7, 58.6, 59.8, 60.0, 61.5, 60.8, 60.0, 60.8, 60.7, 61.2, 60.0, 57.7, 52.5, 53.4, 55.4, 56.4, 54.5],
    "Tasa de Desocupación (TD)": [7.9, 8.5, 8.4, 9.0, 7.9, 7.0, 6.4, 6.2, 6.1, 5.7, 5.5, 5.4, 6.9, 9.2, 8.7, 8.0, 7.3, 9.1]
}

# Convert data to DataFrames
df_nacional = pd.DataFrame(data_nacional)
df_urbano = pd.DataFrame(data_urbano)
df_rural = pd.DataFrame(data_rural)

# Plotting the data
fig, axs = plt.subplots(4, 1, figsize=(12, 20), sharex=True)

# Titles for the indicators
titles = [
    "% Población en edad de trabajar",
    "Tasa Global de Participación (TGP)",
    "Tasa de Ocupación (TO)",
    "Tasa de Desocupación (TD)"
]

# Set the colormap to viridis
cmap = plt.cm.viridis
colors = [cmap(i) for i in [0.2, 0.5, 0.8]]

for i, title in enumerate(titles):
    axs[i].plot(df_nacional["Year"], df_nacional[title], label="Total Nacional", color=colors[0], linewidth=2, marker='o', markersize=9)
    axs[i].plot(df_urbano["Year"], df_urbano[title], label="Urbano", color=colors[1], linewidth=2, marker='s', markersize=9)
    axs[i].plot(df_rural["Year"], df_rural[title], label="Rural", color=colors[2], linewidth=3, marker='^', markersize=9)
    axs[i].set_title(title, fontweight='bold')
    axs[i].set_ylabel("Porcentaje")
    axs[i].legend()

plt.xlabel("Años")
plt.xticks(df_nacional["Year"], rotation=45)
plt.tight_layout()
plt.show()
