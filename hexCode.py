path = input ("Enter file path: ")
print(path)
f = open(path[3:-1])
i=0
for x in f:
    print("MEM[",i,"]=32'h"+x+";")
    i=i+1
f.close
input("end")
