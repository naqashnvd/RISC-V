import fileinput
import floatedu
#filename = 'test.dat'
#with open(filename, 'rb') as f:
with fileinput.input(mode='rb') as f:
    f.readline()
    f.readline()
    f.readline()
    f.readline()
    print(f.readline().decode())
    content_newline = f.readline()
#print(content_newline)
size = (len(content_newline) - 1)
for x in range(0,size,4):
    content = content_newline[x:x+4]
    integer = int.from_bytes(content,byteorder='big')
    #print(integer)
    binary = format(integer,'032b')
    #print(binary)
    float_number = floatedu.Float32(binary)
    print(float_number)
