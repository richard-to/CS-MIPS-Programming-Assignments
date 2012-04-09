import re

def getString(S):
    S = raw_input("Enter a postfix expression: ")
    return S

def putString(S):
    print S
        
def badSyntax(S):
    
    length = len(S)
    
    for i in range(length):
        if i == 0:
            prev = ' '
        else:
            prev = S[i-1]
        
        if i+1 == length:
            next = ' '
        else:
            next = S[i+1]
        
        curr = S[i]
        if re.search('^[\d +-/*]$', curr) == None:
            return True
        elif(re.search('^[\d]$', curr) != None and 
            (re.search('^[\d -]$', prev) == None or 
            re.search('^[\d ]$', next) == None)):
            return True                
        elif(re.search('^[+/*]$', curr) != None and 
            (prev != ' ' or next != ' ')):
            return True
        elif(curr == '-' and 
            (prev != ' ' or re.search('^[\d ]$', next) == None)):
            return True
                                                  
    return False
    
def stackUnderflow(S):
    operands = 0
    operators = 0
    
    length = len(S)
    
    for i in range(length):
        if i == 0:
            prev = ' '
        else:
            prev = S[i-1]
        
        if i+1 == length:
            next = ' '
        else:
            next = S[i+1]
        
        curr = S[i]
        if((prev == ' ' or prev == '-') and re.search('^[\d]$', curr) != None):
            operands += 1
        elif prev == ' ' and next == ' ' and re.search('^[+-/*]$', curr) != None:
            operators += 1            
        
        if(operators >= operands):
            return True
                                                      
    return False
    
def tooManyOperands(S):
    return True
    
print stackUnderflow('33 - 33 * 33 + 34')
