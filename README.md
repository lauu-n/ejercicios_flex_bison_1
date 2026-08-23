# EJERCICIOS FLEX BISON 1

---

## Ejercicio 1

La solución se encuentra en el archivo [`ejercicio_1.md`](https://github.com/lauu-n/ejercicios_flex_bison_1/blob/main/ejercicio_1.md)

---

## Ejercicio 2

Generar una calculadora que reciba números en hexa y decimal.

La solución de este ejercicio se encuentra en la carpeta [`2`](./2).

---

## Ejercicio 3

- ejercicio3.l

Es el archivo del scanner de Flex.

Su función es leer la entrada y reconocer los diferentes elementos de la calculadora mediante expresiones regulares.

Reconoce:

`+` → ADD

`-` → SUB

`*` → MUL

`/` → DIV

`&` → AND

`|` → ABS

números → NUMBER
salto de línea → EOL
espacios y tabulaciones → se ignoran

Cuando encuentra un número, utiliza atoi() para convertir el texto leído en un número entero y almacenarlo en yylval.

El scanner devuelve los tokens a Bison para que el parser pueda realizar las operaciones.

- ejercicio3.y

Es el archivo del parser de Bison.

Su función es definir cómo se combinan los tokens recibidos desde Flex y qué operación debe realizarse.

Se agregaron las operaciones:

- AND mediante `&`

- OR mediante `|`

- Valor absoluto mediante `|` como operador unario


El problema principal del ejercicio es que el símbolo `|` tiene dos funciones.

Por ejemplo:

|5

representa valor absoluto.

Mientras que:

5 | 3

representa OR bit a bit.

La gramática utiliza el contexto de la expresión para diferenciar ambas situaciones.

También se establecen niveles de precedencia para que las operaciones puedan evaluarse correctamente.

- Makefile

Es un archivo utilizado para automatizar la compilación del ejercicio 3.

En lugar de ejecutar manualmente todos los comandos, se puede utilizar:

make

El Makefile ejecuta los pasos necesarios:

Bison genera el parser y el archivo de tokens.
Flex genera el scanner en C.
GCC compila ambos archivos y los enlaza con la biblioteca de Flex.

También incluye:

make clean

que elimina los archivos generados durante la compilación.

Archivos generados por Flex y Bison

Al ejecutar:

make

se generan archivos adicionales.

- ejercicio3.tab.c

Es el código C generado por Bison a partir de ejercicio3.y.

Contiene el parser generado automáticamente.

- ejercicio3.tab.h

Contiene las definiciones de los tokens que utiliza el parser y que necesita conocer el scanner.

- lex.yy.c

Es el código C generado automáticamente por Flex a partir de ejercicio3.l.

No se debe editar manualmente, ya que se vuelve a generar cada vez que se ejecuta Flex.

- ejercicio3

Es el programa ejecutable final generado mediante GCC.

Cómo compilar el ejercicio 3

Entrar a la carpeta del proyecto:

cd ejercicios_flex_bison

Después ejecutar:

make

Si la compilación es correcta, se puede comprobar con:

ls

Deberían aparecer los archivos del proyecto y los archivos generados por Flex y Bison.

Cómo ejecutar el ejercicio 3

Ejecutar:

./ejercicio3

Se pueden probar las operaciones introduciendo expresiones y presionando Enter.

Prueba AND
5 & 3

Resultado:

= 1

Esto ocurre porque:

5 = 101

3 = 011

101

011

001 = 1

Prueba OR

5 | 3

Resultado:

= 7

Porque:

5 = 101

3 = 011

101

011

111 = 7

Prueba de valor absoluto
|5

Resultado:

= 5

Para terminar el programa se puede utilizar:

Ctrl + D

Análisis del ejercicio 3

El objetivo del ejercicio es agregar operadores bit a bit AND y OR al calculador.

Para AND se agregó el símbolo &.

Para OR se reutilizó el símbolo |, debido a que este símbolo ya era utilizado por el calculador como operador unario de valor absoluto.

Esto genera una ambigüedad que debe ser resuelta por la gramática.

Cuando el símbolo aparece antes de una expresión:

|5

se interpreta como valor absoluto.

Cuando aparece entre dos expresiones:

5 | 3

se interpreta como OR bit a bit.

La diferencia se puede determinar por la posición que ocupa el operador dentro de la expresión.

Las pruebas realizadas muestran:

5 & 3 = 1
5 | 3 = 7
|5 = 5

Por lo tanto, las operaciones agregadas funcionan correctamente.

---

## Ejercicio 4

Para el ejercicio 4 se utilizaron dos implementaciones del scanner:

- Una versión escrita manualmente en C.

- Una versión creada mediante Flex.

Ambas siguen las reglas y tokens mostrados en el Example 1-4 del material.

ejercicio4_manual.c

Es la implementación manual del scanner.

En lugar de utilizar Flex para generar automáticamente el scanner, el programa analiza la entrada carácter por carácter.

Utiliza un switch para identificar operadores como:

`+`

`-`

`*`

`/`

`|`


También identifica:

números

espacios

tabulaciones

saltos de línea


Cuando encuentra un número de varios dígitos, va construyendo su valor numérico y lo almacena en yylval.

Los tokens utilizan los mismos valores numéricos del Example 1-4:

- NUMBER = 258
- ADD    = 259
- SUB    = 260
- MUL    = 261
- DIV    = 262
- ABS    = 263
- EOL    = 264


Cómo compilar ejercicio4_manual.c

Ejecutar:

gcc ejercicio4_manual.c -o ejercicio4_manual

Esto genera el ejecutable:

ejercicio4_manual
Cómo ejecutar el scanner manual

Ejecutar:

./ejercicio4_manual

Se puede utilizar la misma prueba mostrada en el Example 1-4:

a / 34 + |45

La salida esperada es:

Mystery character a

262

258 = 34

259

263

258 = 45

264


Los números representan los tokens:

262 → DIV

258 → NUMBER

259 → ADD

263 → ABS

258 → NUMBER

264 → EOL


El carácter a no pertenece a ninguno de los patrones reconocidos y por eso aparece como Mystery character.

ejercicio4_flex.l

Es la versión del scanner implementada utilizando Flex.

Contiene las mismas reglas que se presentan en el Example 1-4.

Flex toma las expresiones regulares y las acciones definidas en este archivo y genera automáticamente el código C correspondiente al scanner.

Entre las reglas se encuentran:

`"+"`      → ADD

`"-"`      → SUB

`"*"`      → MUL

`"/"`      → DIV

`"|"`      → ABS

`[0-9]+`   → NUMBER

`\n`       → EOL

`[ \t]`    → ignorar espacios


Cuando se reconoce un número, se utiliza atoi() para convertir el texto a un entero.

Cómo compilar ejercicio4_flex.l

Primero ejecutar Flex:

flex ejercicio4_flex.l

Esto genera:

lex.yy.c

Después se compila el código generado:

gcc lex.yy.c -o ejercicio4_flex -lfl

Esto genera el ejecutable:

ejercicio4_flex
Cómo ejecutar la versión de Flex

Ejecutar:

./ejercicio4_flex

Utilizar la misma entrada que se utilizó con la versión manual:

a / 34 + |45

La salida esperada es:

Mystery character a

262

258 = 34

259

263

258 = 45

264

Comparación del ejercicio 4


Se ejecutó la misma entrada en ambas versiones:

a / 34 + |45

Scanner manual

Mystery character a

262

258 = 34

259

263

258 = 45

264

Scanner generado con Flex

Mystery character a
262

258 = 34

259

263

258 = 45

264


Los resultados son iguales.

Por lo tanto, la versión manual construida siguiendo las reglas del Example 1-4 reconoce los mismos tokens que la versión implementada con Flex.

La diferencia está en la forma en que se implementa el scanner.

En la versión manual, el programador debe escribir directamente la lógica para analizar cada carácter y decidir qué token corresponde.

En la versión de Flex, el programador solamente define los patrones y las acciones, y Flex genera automáticamente el código del scanner.

Análisis del ejercicio 4

El ejercicio pregunta si la versión handwritten del scanner reconoce exactamente los mismos tokens que la versión de Flex.

El material proporcionado contiene el Example 1-4, que define los tokens y las reglas que debe reconocer el scanner, pero no proporciona una implementación handwritten independiente.

Por esta razón, se construyó una versión manual siguiendo exactamente las reglas del Example 1-4.

Después se ejecutó la misma entrada en ambas versiones:

a / 34 + |45

Ambos scanners reconocieron:

DIV

NUMBER

ADD

ABS

NUMBER

EOL


y ambos trataron a como un carácter desconocido.

Por lo tanto, para las reglas utilizadas en el Example 1-4, ambas implementaciones reconocen exactamente los mismos tokens.

La principal diferencia es la implementación: la versión manual analiza los caracteres directamente mediante código C, mientras que Flex genera automáticamente el scanner a partir de las expresiones regulares.

---

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
