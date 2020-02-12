###################################################################### IMEM #####################################################################
file1 = open ("temp_imem.txt",'r')
imem_out = ""
for line in file1:
    if(line == "\n"):
        continue
    if(">:" in line):
        continue
    imem_out += line[6]
    imem_out += line[7]
    imem_out += line[8]
    imem_out += line[9]
    imem_out += line[10]
    imem_out += line[11]
    imem_out += line[12]
    imem_out += line[13]
    imem_out +="\n"
file1.close()

file1 = open("imem.hex",'w+')
file1.write(imem_out)
file1.close()

###################################################################### DMEM #####################################################################
file = open ("temp_dmem.txt",'r')
ref = 0
dmem_out = ""
for line in file:
    line = line.replace(" ","\n")
    data2 = line.splitlines()
    data2.pop(0) #remove the first null elemet
    for x in range(0,int(data2[0],16)-ref): #insert zeros for the correct address in dmem
        dmem_out += "0\n"
    
    ref = int(data2.pop(0),16)+16 #remove the address count 
    for x in data2:
        if(x == ""): 
            break
        else:
            if(len(x)==8):
                dmem_out += x[6]+x[7]
                dmem_out += x[4]+x[5]
                dmem_out += x[2]+x[3]
                dmem_out += x[0]+x[1]
                dmem_out +="\n"
                dmem_out += x[6]+x[7]
                dmem_out += x[4]+x[5]
                dmem_out += x[2]+x[3]
                dmem_out +="\n"
                dmem_out += x[6]+x[7]
                dmem_out += x[4]+x[5]
                dmem_out +="\n"
                dmem_out += x[6]+x[7]
                dmem_out +="\n"
            if(len(x)==6):
                dmem_out += x[4]+x[5]
                dmem_out += x[2]+x[3]
                dmem_out += x[0]+x[1]
                dmem_out +="\n"
                dmem_out += x[4]+x[5]
                dmem_out += x[2]+x[3]
                dmem_out +="\n"
                dmem_out += x[4]+x[5]
                dmem_out +="\n"
                dmem_out +="0\n"
            if(len(x)==4):
                dmem_out += x[2]+x[3]
                dmem_out += x[0]+x[1]
                dmem_out +="\n"
                dmem_out += x[2]+x[3]
                dmem_out +="\n"
                dmem_out +="0\n"
                dmem_out +="0\n"
            if(len(x)==2):
                dmem_out += x[0]+x[1]
                dmem_out +="\n"
                dmem_out +="0\n"
                dmem_out +="0\n"
                dmem_out +="0\n"
            

file.close()

file = open("dmem.hex",'w+')
file.write(dmem_out)
file.close()
##############################################################################################################################################################################################