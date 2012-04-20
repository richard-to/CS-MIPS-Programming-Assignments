import re

stack = []
top = -1
max_size = 5

def Empty(S):
    if top == -1:
        return True
    else:
        return False
        
def Full(S):
    if top == max_size - 1:
        return True
    else:
        return False
        
def Push(S, ITEM):
    global top
    S.append(ITEM)
    top += 1
    
def Pop(S):
    global top
    top -= 1
    return S.pop()
    
def getNumber(expr):
    expr += ' '
    number = 0
    I = 0
    while(expr[I] != ' ' and expr[I] != None):
        number = 10 * number + ord(expr[I]) - ord('0');
        I += 1
        
    return number     
   
def applyOperator(operator):
    global stack
    result = 0
    if Empty(stack) == False:
        op2 = Pop(stack)

        if Empty(stack) == False:
            error = False
            op1 = Pop(stack)
            if operator == '+':
                    result = op1 + op2
            elif operator == '-':
                    result = op1 - op2
            elif operator == '*':
                    result = op1 * op2
            elif operator == '/':
                    if op2 == 0:
                        error = True
                        print "Divide by Zero!"
                    else:
                        result = op1 / op2
            
            if error == False:
                Push(stack, result)
        else:
            print "Stack underflow: only one argument"
    else:
        print "Stack underflow: no arguments"

expr = '44 45 +'
operand = ''
sign = 1;

length = len(expr)
    
for i in range(length):
    curr = expr[i]
    
    if i+1 == length:
        next = ' '
    else:
        next = expr[i+1]
  
    if re.search('^[\d]$', curr) != None:
        operand += str(curr)
        if next == ' ':  
            Push(stack, sign * getNumber(operand))
            sign = 1
            operand = ''           
    elif curr == '-' and re.search('^[\d]$', next) != None:
         sign = -1                    
    elif re.search('^[+-/*]$', curr) != None:
        applyOperator(curr)
                
print stack
