# EJERCICIO 2
## Calculadora hexadecimal (flex + bison)

---

**Calculadora a una que acepte números decimales y hexadecimales y regrese el resulado en ambos formatos**


Archivos:
- *ej_2.l*: Escáner (entrada de flex). Convierte el texto en tokens.
- *ej_2.y*: Gramática (entrada de bison). Define cómo se combinan los tokens y evalúa las expresiones.
- *conf_2:* Automatiza la ejecución de ambos de ambos archivos.

---

### Ejecución

-Verificar que esté instalado flex, bison y un compilador de C (gcc):
```
$ sudo apt-get install flex bison build-essential
```

- Compilar:
```
$ make
```

- Ejecutar:
```
$ ./ej_2
```

---

### Cambios

**En el escáner (ej_2.l)**

Se agregó una regla antes de la regla de números decimales:
```
0x[a-fA-F0-9]+     {
                      yylval = strtol(yytext, NULL, 16);
                      return NUMBER;
                   }
```

- *0x[a-fA-F0-9]+* es la expresión regular que reconoce el prefijo *0x* seguido de uno o más dígitos hexadecimales.
- *strtol(yytext, NULL, 16)* convierte el texto completo (por ejemplo, "0x1A") a un entero interpretándolo en base 16. *strtol* reconoce el prefijo *0x* automáticamente.


**En el parser (ej_2.y)**

El único cambio fue en el printf que imprime el resultado, para mostrarlo en decimal y hexadecimal a la vez:
```
printf("= %d (%#x)\n", $2, $2);
```

El especificador %#x agrega automáticamente el prefijo 0x al número hexadecimal impreso.

---

### Resultados

![resultado](image.png)

