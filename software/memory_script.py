###################################################################### IMEM #####################################################################
WIDTH = 32
DEPTH = 512
f = open ("temp_imem.txt",'r')
imem_out_mif = "WIDTH="+ str(WIDTH) +";\nDEPTH="+ str(DEPTH) +";\nADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n"
imem_out =""
count = 0
for line in f:
    if(line == "\n"):
        continue
    if(">:" in line):
        continue

    instruction = ""
    instruction += line[6]
    instruction += line[7]
    instruction += line[8]
    instruction += line[9]
    instruction += line[10]
    instruction += line[11]
    instruction += line[12]
    instruction += line[13]

    imem_out += instruction + "\n"
    imem_out_mif += str(count) + " : " + instruction + ";\n" 
    count +=1
imem_out_mif += "["+ str(count) +".."+ str(DEPTH - 1) +"] : 0;\nEND;"
f.close()

f = open("imem.hex",'w+')
f.write(imem_out)
f.close()

f = open("top.ram0_IRAM_c4ed6c1d.hdl.mif",'w+')
f.write(imem_out_mif)
f.close()

###################################################################### DMEM #####################################################################
WIDTH = 32
DEPTH = 4096
f = open ("temp_dmem.txt",'r')
ref = 0
dmem_out_mif = "WIDTH="+ str(WIDTH) +";\nDEPTH="+ str(DEPTH) +";\nADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n"
dmem_out = ""
count = 0
for line in f:
    line = line.replace(" ","\n")
    data2 = line.splitlines()
    data2.pop(0) #remove the first null elemet

    
    for x in range(0,int(data2[0],16)-ref): #insert zeros for the correct address in dmem
        dmem_out += "0\n"
        dmem_out_mif += str(count) + " : " "0;\n"
        count +=1
    
    ref = int(data2.pop(0),16)+16 #remove the address count 
    for x in data2:
        instruction = ""
        if(x == ""): 
            break
        else:
            if(len(x)==8):
                instruction += x[6]+x[7]
                instruction += x[4]+x[5]
                instruction += x[2]+x[3]
                instruction += x[0]+x[1]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction += x[6]+x[7]
                instruction += x[4]+x[5]
                instruction += x[2]+x[3]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction += x[6]+x[7]
                instruction += x[4]+x[5]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction += x[6]+x[7]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
            if(len(x)==6):
                instruction += x[4]+x[5]
                instruction += x[2]+x[3]
                instruction += x[0]+x[1]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction += x[4]+x[5]
                instruction += x[2]+x[3]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction += x[4]+x[5]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction +="0"
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
            if(len(x)==4):
                instruction += x[2]+x[3]
                instruction += x[0]+x[1]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction += x[2]+x[3]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction +="0"
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction +="0"
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
            if(len(x)==2):
                instruction += x[0]+x[1]
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction +="0"
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction +="0"
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1
                instruction =""
                instruction +="0"
                dmem_out += instruction + "\n"
                dmem_out_mif += str(count) + " : " + instruction + ";\n" 
                count +=1

dmem_out_mif += "["+ str(count) +".."+ str(DEPTH - 1) +"] : 0;\nEND;"            
f.close()

f = open("dmem.hex",'w+')
f.write(dmem_out)
f.close()

f = open("top.ram0_DRAM_df80aefc.hdl.mif",'w+')
f.write(dmem_out_mif)
f.close()
##############################################################################################################################################################################################