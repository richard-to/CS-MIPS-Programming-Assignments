rTypes = 0
iTypes = 0
jTypes = 0

file = open('prgm1.txt', 'r')
for line in file:
    if line.startswith('000010') or line.startswith('000011'):
        jTypes += 1
    elif line.startswith('000000') == False:
        iTypes += 1
    else:
        rTypes += 1    
        if line.startswith('001000', 8):
            break
            
file.close()     

print rTypes
print iTypes
print jTypes   
        
