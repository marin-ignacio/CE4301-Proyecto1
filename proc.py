from PIL import Image
import numpy as np
f = open('9.txt', "r")
f2 = open ('image.txt','w')
# lista con las lineas totales
lines = f.readlines()
# Cierra archivo
f.close()
# Obtiene el string del archivo
txt = lines[0]
# Obtiene una lista del string
x = txt.split(" ")
# Produce lista con los datos 
lista = []
temp =0
entrada=[]

print(len(x))

for i in range (len(x)):
     temp = hex(int(x[i]))
     f2.write(str(temp))
     f2.write(' ')



f.close()
f2.close()   

