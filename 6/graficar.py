import pandas as pd 
import matplotlib.pyplot as plt 

datos_resultados = pd.read_csv("resultados.csv", sep=",", skipinitialspace=True)

plt.figure(figsize=(10, 6))

plt.subplot(1, 2, 1)
plt.bar(datos_resultados["Lenguaje"], datos_resultados["Tiempo"], color="blue", alpha=0.8)
plt.xlabel("Lenguaje")
plt.ylabel("Tiempo (s)")
plt.title("Comparativa tiempo de ejecución")

plt.subplot(1, 2, 2)
plt.bar(datos_resultados["Lenguaje"], datos_resultados["Memoria"], color="red", alpha=0.8)
plt.xlabel("Lenguaje")
plt.ylabel("Memoria (KB)")
plt.title("Comparativa memoria máxima utilizada")

plt.tight_layout()
plt.savefig("grafica.png")
