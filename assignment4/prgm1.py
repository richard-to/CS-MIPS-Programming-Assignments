import re

def getString(S):
    S = raw_input("Enter a postfix expression: ")
    return S

def putString(S):
    print S
        
def badSyntax(S):
    
    length = len(S)
    prev = ' '
    for i in range(length):
    
        is_valid = False                
        curr = S[i]
        
        if(curr == ' '):
            is_valid = True
        elif(re.search('^[+-/*]$', curr) != None and prev == ' '):
            is_valid = True
        elif(re.search('^[\d]$', curr) != None and 
                (prev == '-' or prev == ' ' or re.search('^[\d]$', prev))):
            is_valid = True
        else:
            is_valid = False
            
        if is_valid == False:
            return True
        
        prev = curr
                                                        
    return False
    
def stackUnderflow(S):
    operands = 0
    operators = 0
    
    length = len(S)

    for i in range(length):

        curr = S[i]
        
        if i+1 == length:
            next = ' '
        else:
            next = S[i+1]
      
        if next == ' ':
            if re.search('^[\d]$', curr) != None:
                operands += 1
            elif re.search('^[+-/*]$', curr) != None:
                operators += 1            
            print operators, ' ', operands 
            if (operators > 0 or operands > 0) and operands <= operators:
                return True
                                                      
    return False
    
def tooManyOperands(S):
    operands = 0
    operators = 0
    
    length = len(S)
    
    for i in range(length):
        curr = S[i]
        
        if i+1 == length:
            next = ' '
        else:
            next = S[i+1]
      
        if next == ' ':
            if re.search('^[\d]$', curr) != None:
                operands += 1
            elif re.search('^[+-/*]$', curr) != None:
                operators += 1
                
    if operands - operators > 1:
        return True
    else:                                                              
        return False
