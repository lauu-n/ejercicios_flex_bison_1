# ejercicios_flex_bison_1
## Ejercicio 5

La solución de este ejercicio se encuentra en la carpeta [`5`](./5).

📄 Ver la solución completa: [`5/ejercicio5.md`](./5/ejercicio5.md)

---

## Ejercicio 6

Este ejercicio compara el rendimiento de un contador de palabras (`wc`) implementado en **Flex** vs uno implementado en **C puro**, midiendo tiempo de ejecución y memoria sobre un archivo de prueba de 100MB, y genera una gráfica comparativa.

Archivos en la carpeta [`6`](./6):
- `wc.l` → analizador léxico en Flex
- `wc_c.c` → implementación equivalente en C
- `graficar.py` → genera la gráfica comparativa (`grafica.png`) a partir de `resultados.csv`
- `medicion_linux.sh` / `medicion_mac.sh` → scripts que compilan, ejecutan y miden ambas versiones

### Requisitos previos

- **Flex**
- **GCC**
- **Python 3** con las librerías `pandas` y `matplotlib`
- En **macOS** además se necesita `gtime` (viene en el paquete `coreutils`), ya que el `time` nativo de macOS no soporta el formato usado en el script.

Instalación en Linux (Debian/Ubuntu):

```bash
sudo apt update
sudo apt install flex gcc python3 python3-pip
pip3 install pandas matplotlib
```

Instalación en macOS (con Homebrew):

```bash
brew install flex gcc coreutils
pip3 install pandas matplotlib
```

### Cómo ejecutar

1. Entra a la carpeta del ejercicio:

```bash
   cd 6
```

2. Dale permisos de ejecución al script de tu sistema operativo:

```bash
   chmod +x medicion_linux.sh   # en Linux
   chmod +x medicion_mac.sh     # en macOS
```

3. Ejecútalo:

```bash
   bash medicion_linux.sh   # en Linux
   bash medicion_mac.sh     # en macOS
```

El script genera un archivo de prueba de 100MB, compila y corre ambas versiones (Flex y C), guarda los resultados en `resultados.csv`, y abre automáticamente `grafica.png` con la comparación de tiempo y memoria.
