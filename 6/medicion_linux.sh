#!/bin/bash
rm -f resultados.csv lex.yy.c wc_flex wc_c test_large.txt grafica.png
echo "Lenguaje,Tiempo,Memoria" > resultados.csv
base64 /dev/urandom | head -c 100M > test_large.txt
flex wc.l && gcc lex.yy.c -o wc_flex && chmod +x wc_flex
/usr/bin/time -f "Flex,%e,%M" ./wc_flex < test_large.txt 2>> resultados.csv
gcc -O3 wc_c.c -o wc_c && chmod +x wc_c
/usr/bin/time -f "C,%e,%M" ./wc_c < test_large.txt 2>> resultados.csv
rm -f lex.yy.c wc_flex wc_c test_large.txt
python3 graficar.py
xdg-open grafica.png &

