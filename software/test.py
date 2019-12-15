file = open ("temp_dmem.txt")
data = file.read() 
file.close()

#print(data)
data = data.replace(" ","\n")
data2 = data.splitlines()
#print(data2)
out = ""
data2.pop(0) #remove the first null elemet
for x in range(0,int(data2[0],16)): #insert zeros for the correct address in dmem
    out += "0\n"

data2.pop(0) #remove the address count 
for x in data2:
    if(x == ""): 
        break
    else:
        out += x[6]+x[7]
        out += x[4]+x[5]
        out += x[2]+x[3]
        out += x[0]+x[1]
        out +="\n"
        out +="0\n"
        out +="0\n"
        out +="0\n"

file = open("dmem.hex",'w')
file.write(out)
file.close()