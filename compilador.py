arit= {'add' : ["000"], 'mul' : ["001"],'and' : ["010"], 'sub' :["011"],
       'cmp' : ["100"], 'lsr' :["101"], 'mov' :["110"]}
mem = {'ldr' : ["101"], 'str' :["101"]}

banderas = dict(eq="0000",ne="0001", cs="0010", cc="0011",
                mi="0100" , pl= "0101", vs ="0110", vc = "0111",
                hi = "1000", ls= "1001", ge="1010", lt= "1011",
                gt= "0011", le="0011", al="1110")

codigo=""
f = open("codigo.txt", "r")
f2 = open("hexa.data", "w")
lineas = f.readlines()
l=0
m=0



for i in lineas:
    cad = i.strip().lower()
    if cad.find(":") != -1:
        print("etiqueta")
    elif cad[0:1] == "b":
        print("control")
        for k in banderas:
            if cad[1:3] == k:
                codigo += banderas[k][0]
            elif cad[1] == "l":
                l=1
        if codigo == "":
            codigo += "0000"
        codigo += "10" + "l" +"0"
        codigo += cad[2:]
        
            
        
    elif cad[0:3] == "str" or cad[0:3] ==  "ldr":
        print("memoria")
        for k in banderas:
           if cad[3:5] == k:
               codigo += banderas[k][0]
        if codigo =="":
           codigo += "0000"
        codigo += "01"
        if cad.find("#") == -1:
           codigo+="0"
        else:
           codigo+="1"
        if cad.find("-") == -1:
            codigo+="0"
        else:
           codigo += "1"
        
        
    
    else:
        if cad != "":
            print("aritmética")
            for j in arit:
                if cad[0:3] == j:
                    codigo += "00"
                    if cad[3:5] != "vr":
                        for k in banderas:
                            if cad[3:5] == k:
                                
                                codigo += banderas[k][0]
                        if codigo == "00":
                            codigo += "0000"  
                        if cad.find("#") == -1:
                            codigo+="0"
                        else:
                            codigo+="1"
                        if cad.find("-") == -1:
                            codigo+="0"
                        else:
                            codigo+="1"
                        if i[4]== "v":
                            codigo+="1"
                        else:
                            codigo+="0"
                        codigo += arit[j][0]
                        Rn= str(bin(int(cad[5:6]))[2:])
                        while len(Rn)<3:
                            Rn ="0"+ Rn
                        codigo +=Rn
                        src2= str(bin(int(cad[9:]))[2:])
                        while len(src2)<18:
                            src2 ="0"+ src2
                        codigo += src2
                        f2.write(hex(int(codigo[0],2))[2:]+ hex(int(codigo[1:5],2))[2:]+ hex(int(codigo[5:9],2))[2:]+
                                 hex(int(codigo[9:13],2))[2:]+hex(int(codigo[13:17],2))[2:]+hex(int(codigo[17:21],2))[2:]+
                                 hex(int(codigo[21:25],2))[2:]+hex(int(codigo[25:29],2))[2:]+hex(int(codigo[29:33],2))[2:]+'\n')

                        print(codigo)
                    
    codigo = "";
        
f.close()
f2.close()
