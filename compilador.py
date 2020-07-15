def decToBin(n):
    if n==0: return ''
    else:
        return decToBin(n//2) + str(n%2)

def createBinaryLabel(dato):
    var = decToBin(dato)
    i = 0
    tot = (20-len(var))
    while i <= tot:
        var = "0" + var
        i += 1
    print(var)
    return var

labels = {}
registers = {'r0':"0000",'r1':"0001",'r2':"0010",'r3':"0011",
             'r4':"0100",'r5':"0101",'r6':"0110",'r7':"0111",
             'r8':"1000",'r9':"1001",'r10':"1010",'r11':"1011",
             'r12':"1100",'r13':"1101",'r14':"1110",'r15':"1111"}
arit= {'add' : ["0000"], 'mulv' : ["0001"],'and' : ["0010"], 'sub' :["0001"],
       'cmp' : ["0100"], 'lsr' :["0011"], 'mov' :["1000"], 'addv' :["0110"], 'mulv' :["0111"]}
mem = {'ldr' : ["101"], 'str' :["101"]}                                                             ###################Nota falta un bit###############333

banderas = dict(eq="0000",ne="0001", cs="0010", cc="0011",      
                mi="0100" , pl= "0101", ov ="0110", oc = "0111",
                hi = "1000", ms= "1001", ge="1010", mt= "1011",
                gt= "1100", me="1101", al="1110")           

codigo=""
f = open("codigo.txt", "r")
f2 = open("hexa.data", "w")
lineas = f.readlines()
print(lineas)
l=0
m=0
v=0
i=0
s=0
l=0


def loadLabel():                        #fist read all the document to find and configure labels
    line = 0
    for p in lineas:
        listaPalabras = p.split();
        print(listaPalabras)
        for x in listaPalabras:
            if(x[0]==":"):
                labels[str(x[1:])] = str(createBinaryLabel(line))
                print("encuentra etiqueta:   " + x[1:])
                print ("diccionario de etiquetas:  ")
                print(labels)
            print("valor de i: " + x)
        if(len(listaPalabras) != 0):
            if not((len(listaPalabras) == 1) and (listaPalabras[0][0]==":")):
                line += 1
            

loadLabel();

linea = 1 
for i in lineas:
    cad = i.strip().lower()
    print("Esto es el valor de cad: " +cad)

    if cad[0:1] == "b":                               #section for branches
        datos = cad.split()
        print("control")
        if cad[1:2] == "l":                             #Nota: Esto condiciona que todos los brach vayan con BL
            codigo += "10"                              #Set "OP" [27:26] in position
            for k in banderas:
                if cad[2:4] == k:
                    codigo += banderas[k]               # this part set the correct flag in binary "COND" [21:18]
                    if (k == 'al' ):
                        codigo += "0"
                    else:
                        codigo += "1"
                elif cad[2:3] == "":
                    codigo += banderas['al']
                    codigo += "0"
            if(len(datos) < 2):
                print("faltan argumentos ")
            else:
                for busquedaDic in labels:
                    if(str(datos[1]) == str(busquedaDic)):
                        codigo += labels[datos[1]]
            if(len(codigo)==28):
                print("branch Completed")
                f2.write(hex(int(codigo[0:4],2))[2:]+ hex(int(codigo[4:8],2))[2:]+ hex(int(codigo[8:12],2))[2:]+
                                 hex(int(codigo[12:16],2))[2:]+hex(int(codigo[16:20],2))[2:]+hex(int(codigo[20:24],2))[2:]+
                                 hex(int(codigo[24:28],2))+'\n')
            print("código hasta aquí: " +codigo)
        
            
        
    elif cad[0:3] == "str" or cad[0:3] ==  "ldr" or cad[0:3] ==  "ldi":       #section form memory operations
        print("memoria")
        codigo += "01"                                  #Set "OP" [27:26] in position
        for k in banderas:
           if cad[3:5] == k:
               codigo += banderas[k]                    # this part set the correct flag in binary "COND" [21:18]
        if codigo =="01":
           codigo += "0000"


        ############### M ROM RAM ############################
        if(cad[0:3] == "ldi"):          #M
            print("leemos desde la ROM")
            codigo += "1"           #sujeto a cambios
        else:
            codigo += "0"
        if(cad[4]=="v"):                #V
            codigo += "1"
        else:
            codigo += "0"

        if(cad[0:3] == "ldr" or cad[0:3] == "ldi"):          #L
            codigo += "1"
        else:
            codigo += "0"
        ############################################################
        datos = cad.split()
        codigo += "00000"
        if(len(datos) < 3):
            print("Error falta de parámetros en la línea: ", linea)
        else:
            pos = 1
            while(pos < 3):
                for k in registers:
                    if len(datos[pos]) > 3:
                        if datos[pos][0:3] == k:
                           codigo += registers[datos[pos][0:3]]
                        elif datos[pos][0:2] == k:
                            codigo += registers[datos[pos][0:2]]
                    elif datos[pos][0:2] == k:
                        codigo += registers[datos[pos][0:2]]
                pos += 1
        codigo += "000000"
        if(len(codigo) == 28):
            print("Acceso a memoria completo, instrucción: ", codigo)
            escritura =  hex(int(codigo[0:4],2))[2:]+ hex(int(codigo[4:8],2))[2:]+ hex(int(codigo[8:12],2))[2:]+hex(int(codigo[12:16],2))[2:]+hex(int(codigo[16:20],2))[2:]+hex(int(codigo[20:24],2))[2:]+hex(int(codigo[24:28],2))+'\n'
            print(escritura)
            f2.write(hex(int(codigo[0:4],2))[2:]+ hex(int(codigo[4:8],2))[2:]+ hex(int(codigo[8:12],2))[2:]+
                                 hex(int(codigo[12:16],2))[2:]+hex(int(codigo[16:20],2))[2:]+hex(int(codigo[20:24],2))[2:]+
                                 hex(int(codigo[24:28],2))+'\n')
        
        
        
    
    else:                                               #section for aritmetic operations
        if cad != "":
            print("aritmética")
            for j in arit:
                if cad[0:3] == j:
                    codigo += "00"
                    if cad[3:5] != "vr":                
                        for k in banderas:              #
                            if cad[3:5] == k:
                                codigo += banderas[k]
                                codigo += 1
                        if codigo == "00":              #if not find flags activated, put flags of equal???
                            codigo += "0000"
                            codigo += "0"
                        if cad.find("-") == -1:
                            codigo+="0"
                        else:
                            codigo+="1"
                        if cad[4]== "v":
                            codigo+="1"
                        else:
                            codigo+="0"
                        if cad.find("#") == -1:
                            codigo+="0"
                        else:
                            codigo+="1"
                        codigo += arit[j][0]
                        
                        datos = cad.split()
                        if(len(datos) < 3):
                            print("Error faltan parámetros en la línea: ", linea)
                        else:
                            if cad.find("#") == -1:
                                pos = 1
                                while(pos < 3):
                                    for k in registers:
                                        if len(datos[pos]) > 3:
                                            if datos[pos][0:3] == k:
                                               codigo += registers[datos[pos][0:3]]
                                            elif datos[pos][0:2] == k:
                                                codigo += registers[datos[pos][0:2]]
                                        elif datos[pos][0:2] == k:
                                            codigo += registers[datos[pos][0:2]]
                                    pos += 1
                                codigo += "000000"
                            else:
                                for k in registers:
                                    if len(datos[1]) > 3:
                                        if datos[1][0:3] == k:
                                            codigo += registers[datos[1][0:3]]
                                        elif datos[1][0:2] == k:
                                            codigo += registers[datos[1][0:2]]
                                    elif datos[1][0:2] == k:
                                        codigo += registers[datos[1][0:2]]
                                inmediate = decToBin(int(datos[2][1:]))
                                if len(inmediate) <10:
                                    inmediate = "0" + inmediate
                                codigo += inmediate
                        print("Acceso a datos,tamaño de la instrucción: ", len(codigo))
                        if(len(codigo) == 28):
                            print("Acceso a datos completo, instrucción: ", codigo)
                            escritura =  hex(int(codigo[0:4],2))[2:]+ hex(int(codigo[4:8],2))[2:]+ hex(int(codigo[8:12],2))[2:]+hex(int(codigo[12:16],2))[2:]+hex(int(codigo[16:20],2))[2:]+hex(int(codigo[20:24],2))[2:]+hex(int(codigo[24:28],2))+'\n'
                            print(escritura)
                            f2.write(hex(int(codigo[0:4],2))[2:]+ hex(int(codigo[4:8],2))[2:]+ hex(int(codigo[8:12],2))[2:]+
                                                 hex(int(codigo[12:16],2))[2:]+hex(int(codigo[16:20],2))[2:]+hex(int(codigo[20:24],2))[2:]+
                                                 hex(int(codigo[24:28],2))+'\n')
                       

                        print("el código es: " , codigo , "y su tamaño:  " , len(codigo))
                    
    codigo = "";
    linea +=1
    
        
f.close()
f2.close()
