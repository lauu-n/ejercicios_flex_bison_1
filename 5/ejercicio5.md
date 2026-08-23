# Ejercicio 5

Flex es un generador de analizadores léxicos basado en autómatas finitos deterministas (DFA) y expresiones regulares. Por esta razón, es ideal para lenguajes donde los tokens son independientes del contexto y procesables mediante un flujo de bytes secuencial. 

Sin embargo, Flex no es la mejor opción para las siguientes categorías de lenguajes:

---

### 1. Lenguajes sensibles a la sangría (*Off-side Rule*)
* Ejemplos: Python, Haskell, YAML, Nim.
* Causa: Estos lenguajes delimitan sus bloques de código mediante el nivel de identación (espacios o tabulaciones) generando tokens implícitos como INDENT y DEDENT.
* Problema con Flex: Las expresiones regulares de Flex carecen de memoria para recordar cuántos espacios había en la línea anterior. Para implementarlo se requiere mantener una pila manual de sangrados en código C embebido, lo cual contrarresta la ventaja de usar un generador automático.

---

### 2. Lenguajes con dependencias de contexto (*Lexer Hack*)
* Ejemplos: C++, C#.
* Causa: Existe ambigüedad sintáctica en las secuencias de texto. Por ejemplo, A * b; puede ser:
* Una multiplicación entre las variables A y b.
* La declaración de un puntero b de tipo A.
* Problema con Flex: Flex analiza el texto aisladamente. Para resolver la ambigüedad, el *lexer* necesita consultar la tabla de símbolos del *parser* en tiempo real para verificar si A es un tipo de dato o un identificador.

---

### 3. Lenguajes con sintaxis insensible a espacios dinámicos
* Ejemplos: Fortran clásico (FORTRAN 77).
* Causa: Los espacios en blanco no son separadores y se ignoran por completo, incluso en palabras clave. Por ejemplo:
* DO 10 I = 1, 10 (Es un bucle `DO`).
* DO 10 I = 1.10 (Es una asignación a la variable `DO10I`).
* Problema con Flex: Flex no puede determinar si la palabra DO es una palabra reservada o parte del nombre de una variable sin leer varios tokens adelante (mirada hacia adelante / *lookahead* arbitrario).

---

### 4. Lenguajes con soporte nativo de caracteres Unicode / UTF-8
* Ejemplos: Swift, Rust, Java o lenguajes modernos que admiten identificadores en varios alfabetos o con emojis.
* Causa: Los caracteres en estos lenguajes tienen un tamaño variable (de 1 a 4 bytes).
* Problema con Flex: Flex tradicional procesa la entrada byte a byte orientándose al código ASCII (8 bits). Manejar rangos de caracteres UTF-8 en reglas de Flex requiere definir patrones excesivamente complejos o recurrir a herramientas más modernas como RE2C o Flex++.
