#################################################################################
#
#   Richard To
#   rto@alaska.edu
#   Assignment 5
#   2012-04-20
#
#   PURPOSE:    Validates postfix syntax and solves valid expressions
#
#   ALGORITHM: import re
#    
#    stack = []
#    top = -1
#    max_size = 5
#
#    def Empty(S):
#    if top == -1:
#        return True
#    else:
#       return False
#        
#    def Full(S):
#    if top == max_size - 1:
#        return True
#    else:
#        return False
#        
#    def Push(S, ITEM):
#    global top
#    S.append(ITEM)
#    top += 1
#    
#    def Pop(S):
#    global top
#    top -= 1
#    return S.pop()
#    
#    def getNumber(expr):
#    expr += ' '
#    number = 0
#    I = 0
#    while(expr[I] != ' ' and expr[I] != None):
#        number = 10 * number + ord(expr[I]) - ord('0');
#        I += 1
#        
#    return number     
#   
#    def applyOperator(operator):
#    global stack
#    result = 0
#    if Empty(stack) == False:
#        op2 = Pop(stack)
#
#        if Empty(stack) == False:
#            error = False
#            op1 = Pop(stack)
#            if operator == '+':
#                    result = op1 + op2
#            elif operator == '-':
#                    result = op1 - op2
#            elif operator == '*':
#                    result = op1 * op2
#            elif operator == '/':
#                    if op2 == 0:
#                        error = True
#                        print "Divide by Zero!"
#                    else:
#                        result = op1 / op2
#            
#            if error == False:
#                Push(stack, result)
#        else:
#            print "Stack underflow: only one argument"
#    else:
#        print "Stack underflow: no arguments"
#
#    def solveExpr(expr):
#        for i in range(length):
#            curr = expr[i]
#            
#            if i+1 == length:
#                next = ' '
#            else:
#                next = expr[i+1]
#          
#            if re.search('^[\d]$', curr) != None:
#                operand += str(curr)
#                if next == ' ':  
#                    Push(stack, sign * getNumber(operand))
#                    sign = 1
#                    operand = ''           
#            elif curr == '-' and re.search('^[\d]$', next) != None:
#                 sign = -1                    
#            elif re.search('^[+-/*]$', curr) != None:
#                applyOperator(curr)
#
#   def getString(S):
#       S = raw_input("Enter a postfix expression: ")
#       return S
#
#   def putString(S):
#       print S
#        
#   def badSyntax(S):
#    
#       length = len(S)
#       prev = ' '
#       for i in range(length):
#    
#           is_valid = False                
#           curr = S[i]
#        
#           if(curr == ' '):
#               is_valid = True
#           elif(re.search('^[+-/*]$', curr) != None and prev == ' '):
#               is_valid = True
#           elif(re.search('^[\d]$', curr) != None and 
#               (prev == '-' or prev == ' ' or re.search('^[\d]$', prev))):
#               is_valid = True
#           else:
#               is_valid = False
#            
#           if is_valid == False:
#               return True
#        
#           prev = curr
#                                                        
#       return False
#    
#   def stackUnderflow(S):
#       operands = 0
#       operators = 0
#    
#       length = len(S)
#
#       for i in range(length):
#
#           curr = S[i]
#        
#           if i+1 == length:
#               next = ' '
#           else:
#               next = S[i+1]
#      
#           if next == ' ':
#               if re.search('^[\d]$', curr) != None:
#                   operands += 1
#               elif re.search('^[+-/*]$', curr) != None:
#                   operators += 1            
#
#               if (operators > 0 or operands > 0) and operands <= operators:
#                   return True
#                                                      
#        return False
#    
#   def tooManyOperands(S):
#        operands = 0
#        operators = 0
#    
#        length = len(S)
#    
#        for i in range(length):
#            curr = S[i]
#        
#            if i+1 == length:
#                next = ' '
#            else:
#                next = S[i+1]
#      
#            if next == ' ':
#                if re.search('^[\d]$', curr) != None:
#                    operands += 1
#                elif re.search('^[+-/*]$', curr) != None:
#                    operators += 1
#                
#         if operands - operators > 1:
#             return True
#         else:                                                              
#             return False
#        
#   go_again = "Y"
#   while go_again == "Y":
#                                  
#       S = getString(S)
#       if badSyntax(S):
#            print "Bad Syntax"
#       elif stackUnderflow(S):
#            print "Stack Underflow"
#       elif tooManyOperands(S):
#            print "Too many operands"
#       else
#            result = solveExpr(S)
#            print result
#       
#       go_again = raw_input("Enter another string? (Y/n) ")
###############################################################################

                   .data
S:                .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

OPERAND:          .space 80
CONTINUE:         .space 80
INPUT:            .space 80
                  
INPUT_PROMPT:     .asciiz "Enter a postfix expression: "
CONTINUE_PROMPT:  .asciiz "Enter another postfix expression? (Y/n): "
ANSWER_PROMPT:    .asciiz "Answer is: "
BAD_SYNTAX:       .asciiz "Error: Bad Syntax.\n"
TOO_MANY_OPS:     .asciiz "Error: Too many operands.\n"
STACK_UNDERFLOW:  .asciiz "Error: Stack Underflow.\n"
NO_ARGS:          .asciiz "Error: Stack Underflow: No arguments.\n"
ONE_ARG:          .asciiz "Error: Stack Underflow: Only one argument.\n"
DIV_ZERO:         .asciiz "Error: Can't divide by zero.\n"

                  .text
main:
    addi  $s0, $zero, -4                    # top = -1
    addi  $s1, $zero, 80                    # max_size = 20
    addi  $s7, $zero, 89                    # while go_again == "Y":
    la    $a0, INPUT_PROMPT                 # go_again = "Y"
    jal   putString                         # prompt = "Enter a postfix expression: "
                                            # putString(prompt)    
    la    $s2, INPUT                        #
    add   $a0, $zero $s2                    #
    jal   getString                         # getString(S)
                                            # 
mainBadSyntax:                              # 
    add   $a0, $zero, $s2                   #
    addi  $sp, $sp, -4                      # 
    sw    $ra, 0($sp)                       #
    jal   badSyntax                         # invalid = badSyntax(S)
    lw    $ra, 0($sp)                       # 
    addi  $sp, $sp, 4                       #
    add   $s3, $zero, $v0                   #
    beq   $s3, $zero, mainStackUnderflow    # if invalid:
    la    $a0, BAD_SYNTAX                   # putString("Error:Bad Syntax")    
    jal   putString                         #  
    j     mainContinue                      #
mainStackUnderflow:                         #
    add   $a0, $s2, $zero                   #
    addi  $sp, $sp, -4                      #
    sw    $ra, 0($sp)                       #
    jal   stackUnderflow                    # invalid = stackUnderflow(S)
    lw    $ra, 0($sp)                       #
    addi  $sp, $sp, 4                       #
    add   $s3, $zero, $v0                   #
    beq   $s3, $zero, mainTooManyOperands   # if invalid:
    la    $a0, STACK_UNDERFLOW              # putString("Error:Stack Underflow") 
    jal   putString                         # 
    j     mainContinue                      #
mainTooManyOperands:                        # 
    add   $a0, $zero, $s2                   #
    addi  $sp, $sp, -4                      # 
    sw    $ra, 0($sp)                       #
    jal   tooManyOperands                   # invalid = tooManyOperands(S)
    lw    $ra, 0($sp)                       #
    addi  $sp, $sp, 4                       #
    add   $s3, $zero, $v0                   #
    beq   $s3, $zero, mainSolvExpr          # if invalid:
    la    $a0, TOO_MANY_OPS                 # putString("Error:Too many Operands") 
    jal   putString                         #   
    j     mainContinue                      #
mainSolvExpr:                               #
    add   $a0, $zero, $s2                   #
    addi  $sp, $sp, -4                      # 
    sw    $ra, 0($sp)                       #
    jal   solveExpr                         # result = solveExpr(S)   
    lw    $ra, 0($sp)                       #
    addi  $sp, $sp, 4                       #
    add   $s3, $zero, $v0                   #
    add   $s4, $zero, $v1,                  #
    addi  $s5, $zero, 1                     #        
    beq   $v0, $s5, mainNoArgs              # if result[0] == 1:
    addi  $s5, $zero, 2                     # 
    beq   $v0, $s5, mainOneArg              # elif result[0] == 2:   
    addi  $s5, $zero, 3                     #  
    beq   $v0, $s5, mainDiv0                # elif result[0] == 3:                             
mainAnswer:                                 # else:
    la    $a0, ANSWER_PROMPT                # putString("Answer is: ")
    jal   putString                         #   
    add   $a0, $zero, $v1                   # putInteger(result[1])
    jal   putInteger                        #
    add   $a0, $zero, 10                    # 
    jal   putChar                           # putChar("\n")         
    j     mainContinue                      #
mainNoArgs:                                 # if result[0] == 1:
    la    $a0, NO_ARGS                      # putString(NO_ARGS)
    jal   putString                         #
    j     mainContinue                      #
mainOneArg:                                 # elif result[0] == 2:
    la    $a0, ONE_ARG                      # putString(ONE_ARG)
    jal   putString                         #
    j     mainContinue                      #
mainDiv0:                                   # elif result[0] == 3:
    la    $a0, DIV_ZERO                     # putString(DIV_ZERO)
    jal   putString                         #                                                           
mainContinue:                               #
    la    $a0, CONTINUE_PROMPT              # 
    jal   putString                         # putString("Enter another postfix expression? (Y/n) ")
                                            #
    add   $a0, $zero $s2                    #
    jal   getString                         # getString(go_again)
                                            # 
    lb    $s5, 0($a0)                       #
    beq   $s5, $s7, main                    # if go_again != "Y":
                                            # break
mainEnd:                                    #                                        
    li      $v0, 10                         #
    syscall                                 # Exit 
                                            #
                                            #
                                            #
Empty:                                      # def Empty(S):
    addi  $sp, $sp, -4                      # 
    sw    $ra, 0($sp)                       #
    add   $t0, $zero, $zero                 #
    bltz  $s0, eEnd                         # if top == -1:
    addi  $t0, $zero, 1                     # return True
eEnd:                                       # else:
    lw    $ra, 0($sp)                       # return False
    addi  $sp, $sp, 4                       #
    add   $v0, $zero, $t0                   #
    jr    $ra                               #
                                            # 
                                            #
Full:                                       # def Full(S):
    addi  $sp, $sp, -4                      #
    sw    $ra, 0($sp)                       #
    add   $t0, $zero, $zero                 #
    bne   $s0, $s1, fEnd                    # if top == max_size - 1:
    addi  $t0, $zero, 1                     # return True
fEnd:                                       # else:
    lw    $ra, 0($sp)                       # return False
    addi  $sp, $sp, 4                       #
    add   $v0, $zero, $t0                   #
    jr    $ra                               #
                                            #
                                            # 
Push:                                       # def Push(S, ITEM):
    addi  $sp, $sp, -4                      # global top
    sw    $ra, 0($sp)                       #
    addi  $s0, $s0, 4                       # top += 1
    add   $t0, $a0, $s0                     #
    sw    $a1, 0($t0)                       # S.append(ITEM)
    lw    $ra, 0($sp)                       #
    addi  $sp, $sp, 4                       #
    jr    $ra                               #
                                            # 
                                            #
Pop:                                        # def Pop(S):
    addi  $sp, $sp, -4                      # global top
    sw    $ra, 0($sp)                       #
    add   $t0, $a0, $s0                     #
    lw    $v0, 0($t0)                       # return S.pop() 
    lw    $ra, 0($sp)                       #
    addi  $s0, $s0, -4                      # top -= 1
    addi  $sp, $sp, 4                       #
    jr    $ra                               #
                                            #
                                            # 
                                            #
getNumber:                                  # def getNumber(expr):
    addi  $sp, $sp, -8                      #
    sw    $ra, 4($sp)                       #
    sw    $a0, 0($sp)                       #
    add   $t0, $a0, $zero                   #
    add   $t1, $zero, $zero                 # I = 0
    addi  $t4, $zero, 10                    #
gnLoop:                                     # while(expr[I] != ' ' and expr[I] != None):
    lb    $t2, 0($t0)                       #
    beq   $t2, $zero, gnEnd                 # 
    mult  $t1, $t4                          # number = 10 * number
    mflo  $t1                               # 
    addi  $t3, $t2, -48                     # 
    add   $t1, $t1, $t3                     # number += ord(expr[I]) - ord('0')
    addi  $t0, $t0, 1                       # I +=1
    j     gnLoop                            #
gnEnd:                                      # 
    lw    $a0, 0($sp)                       #
    lw    $ra, 4($sp)                       #
    addi  $sp, $sp, 8                       # 
    add   $v0, $zero, $t1                   # return number  
    jr    $ra                               #
                                            #
                                            #
                                            #
applyOperator:                              # def applyOperator(operator):
    addi  $sp, $sp, -8                      #
    sw    $ra, 4($sp)                       #
    sw    $a0, 0($sp)                       #
    add   $t0, $zero, $a0                   #
    addi  $sp, $sp, -4                      #
    sw    $t0, 0($sp)                       # 
    la    $a0, S                            #
    jal   Empty                             # 
    add   $t1, $zero, $v0                   #
    lw    $t0, 0($sp)                       #
    addi  $sp, $sp, 4                       #
    beq   $t1, $zero, aoNoArgs              # if Empty(stack) == False:
    addi  $sp, $sp, -4                      #
    sw    $t0, 0($sp)                       #
    la    $a0, S                            # 
    jal   Pop                               # op2 = Pop(stack)
    lw    $t0, 0($sp)                       #
    addi  $sp, $sp, 4                       #
    add   $t2, $zero, $v0                   # 
    addi  $sp, $sp, -8                      # 
    sw    $t0, 4($sp)                       #
    sw    $t2, 0($sp)                       #
    la    $a0, S                            #
    jal   Empty                             #
    add   $t1, $zero, $v0                   #  
    lw    $t2, 0($sp)                       #
    lw    $t0, 4($sp)                       #
    addi  $sp, $sp, 8                       # 
    beq   $t1, $zero, aoOneArgs             # if Empty(stack) == False:
    addi  $sp, $sp, -8                      #
    sw    $t0, 4($sp)                       #
    sw    $t2, 0($sp)                       #
    la    $a0, S                            #
    jal   Pop                               # op1 = Pop(stack)
    add   $t3, $zero, $v0                   #
    lw    $t2, 0($sp)                       #
    lw    $t0, 4($sp)                       #
    addi  $sp, $sp, 8                       # 
    addi  $t4, $zero, 43                    # 
    beq   $t0, $t4, aoAdd                   # if operator == '+':
    addi  $t4, $zero, 45                    # 
    beq   $t0, $t4, aoSub                   # elif operator == '-': 
    addi  $t4, $zero, 42                    # 
    beq   $t0, $t4, aoMult                  # elif operator == '*':
    addi  $t4, $zero, 47                    #  
    beq   $t0, $t4, aoDiv                   # elif operator == '/':
aoDiv:                                      #
    beq   $t2, $zero, aoDiv0                # if op2 == 0:
    div   $t3, $t2                          #
    mflo  $t5                               # result = op1 / op2
    j     aoPush                            #
aoMult:                                     #
    mult  $t3, $t2                          #
    mflo  $t5                               # result = op1 * op2
    j     aoPush                            #     
aoAdd:                                      #
    add   $t5, $t3, $t2                     # result = op1 + op2
    j     aoPush                            #
aoSub:                                      #
    sub   $t5, $t3, $t2                     # result = op1 - op2
aoPush:                                     #
    addi  $sp, $sp, -4                      #
    sw    $t5, 0($sp)                       #
    la    $a0, S                            #
    add   $a1, $zero, $t5                   #  
    jal   Push                              # Push(stack, result)
    addi  $v0, $zero, 0                     # 
    lw    $t5, 0($sp)                       #
    addi  $sp, $sp, 4                       #  
    j     aoEnd                             #  
aoDiv0:                                     #
    addi  $v0, $zero, 3                     # print "Divide by Zero!"
    j     aoEnd                             # //In MIPS version, error code 3 returned
aoOneArgs:                                  #
    addi  $v0, $zero, 2                     # print "Stack underflow: only one argument"
    j     aoEnd                             # //In MIPS version, error code 2 returned
aoNoArgs:                                   #
    addi  $v0, $zero, 1                     # print "Stack underflow: no arguments"
    j     aoEnd                             # //In MIPS version, error code 1 returned
aoEnd:                                      #
    lw    $a0, 0($sp)                       # 
    lw    $ra, 4($sp)                       #
    addi  $sp, $sp, 8                       # //In MIPS version, status returned 0,1,2,3
    jr    $ra                               # //0 is success
                                            #
                                            #
                                            #
solveExpr:                                  # def solveExpr(S):
    addi  $sp, $sp -8                       # 
    sw    $ra, 4($sp)                       #
    sw    $a0, 0($sp)                       #
    add   $t0, $zero, $a0                   #                  
    la    $t1, OPERAND                      # operand = ''
    add   $t2, $zero, $t1                   # 
    addi  $t9, $zero, 1                     # sign = 1;
seLoop:                                     # 
    lb    $t3, 0($t0)                       # curr = S[i]
    addi  $t4, $zero, 10                    #           
    beq   $t3, $t4, seSuccess               # for i in range(length):
    lb    $t5, 1($t0)                       # next = S[i+1]
    bne   $t5, $t4, seParseExpr             # if i+1 == length:
    addi  $t5, $zero, 32                    # next = ' '
seParseExpr:                                #
    slti  $t4, $t3, 48                      # 
    bne   $t4, $zero, seElifNotDigit        # 
seIfDigit:                                  # if re.search('^[\d]$', curr) != None:
    sb    $t3, 0($t2)                       # operand += str(curr)
    addi  $t2, $t2, 1                       #
    addi  $t4, $zero, 32                    #
    bne   $t5, $t4, seIncr                  # 
seIfDigitAndNextSpace:                      # if next == ' ':  
    addi  $sp, $sp -16                      #
    sw    $t0, 12($sp)                      #
    sw    $t1, 8($sp)                       #
    sw    $t2, 4($sp)                       #
    sw    $t9, 0($sp)                       # 
    sb    $zero, 0($t2)                     #
    add   $a0, $zero, $t1                   #
    jal   getNumber                         # num = getNumber(operand)
    add   $t8, $zero, $v0                   #
    lw    $t9, 0($sp)                       #
    lw    $t2, 4($sp)                       #
    lw    $t1, 8($sp)                       # 
    lw    $t0, 12($sp)                      # 
    addi  $sp, $sp, 16                      # 
    mult  $t9, $t8                          # num = num * sign
    mflo  $t7                               #
    addi  $sp, $sp -16                      #
    sw    $t0, 12($sp)                      # 
    sw    $t1, 8($sp)                       #
    sw    $t2, 4($sp)                       #
    sw    $t9, 0($sp)                       #
    la    $a0, S                            #
    add   $a1, $zero, $t7                   #
    jal   Push                              # Push(stack, num)
    lw    $t9, 0($sp)                       #
    lw    $t2, 4($sp)                       #
    lw    $t1, 8($sp)                       #
    lw    $t0, 12($sp)                      #
    addi  $sp, $sp, 16                      #
    addi  $t9, $zero, 1                     #  sign = 1
    add   $t2, $zero, $t1                   #  operand = ''     
    j     seIncr                            #
seElifNotDigit:                             #
    addi  $t4, $zero, 45                    #   
    beq   $t3, $t4, seElifNeg               # elif curr == '-'
    addi  $t4, $zero, 42                    # 
    beq   $t3, $t4, seElifOperator          # elif curr == '+'  
    addi  $t4, $zero, 43                    # 
    beq   $t3, $t4, seElifOperator          # elif curr == '*'             
    addi  $t4, $zero, 47                    # 
    beq   $t3, $t4, seElifOperator          # elif curr == '/'
    j     seIncr                            #
seElifNeg:                                  # elif curr == '-'
    addi  $t4, $zero, 32                    #
    beq   $t5, $t4, seElifOperator          # elif curr == '-' and re.search('^[\d]$', next) != None:
    addi  $t9, $zero -1                     # sign = -1
    j     seIncr                            #
seElifOperator:                             # elif re.search('^[+-/*]$', curr) != None:
    addi  $sp, $sp -16                      #
    sw    $t0, 12($sp)                      #
    sw    $t1, 8($sp)                       #
    sw    $t2, 4($sp)                       # 
    sw    $t9, 0($sp)                       #
    add   $a0, $zero, $t3                   #
    jal   applyOperator                     # result = applyOperator(curr)
    add   $t8, $zero, $v0                   # statusCode = result[0]
    lw    $t9, 0($sp)                       #
    lw    $t2, 4($sp)                       #
    lw    $t1, 8($sp)                       #
    lw    $t0, 12($sp)                      #
    addi  $sp, $sp, 16                      #
    bne   $t8, $zero, seError               # if statusCode != 0                                 
seIncr:                                     # 
    addi  $t0, $t0, 1                       # i++
    j     seLoop                            #   
seError:                                    # if statusCode != 0 
    add   $v0, $zero, $t8                   # return [statusCode, 0]
    add   $v1, $zero, $zero                 # 
    j     seEnd                             #
seSuccess:                                  # if statusCode == 0 
    add   $v0, $zero, $zero                 # return result
    lw    $t7, S($zero)                     # 
    add   $v1, $zero, $t7                   #
seEnd:                                      #
    lw    $a0, 0($sp)                       #
    lw    $ra, 4($sp)                       #
    addi  $sp, $sp, 8                       #
    jr    $ra                               #
                                            #
                                            #
putChar:                                    # def putChar(S):
    li       $v0, 11                        # print S
    syscall                                 #
    jr       $ra                            #
                                            #
                                            #
                                            #
putInteger:                                 # def putInteger(S):
    li       $v0, 1                         # print S
    syscall                                 #
    jr       $ra                            #
                                            #
                                            #
                                            #
putString:                                  # def putString(S):
    li       $v0, 4                         # print S
    syscall                                 #
    jr       $ra                            #
                                            #
                                            #
                                            #
getString:                                  # def getString(S):
    addi    $a1, $zero, 80                  # raw_input(S)       
    li      $v0, 8                          #
    syscall                                 #
    jr      $ra                             #
                                            #
                                            #
                                            #
badSyntax:                                  # def badSyntax(S):
    addi  $sp, $sp -8                       #
    sw    $ra, 4($sp)                       #
    sw    $a0, 0($sp)                       #
    add   $t0, $a0, $zero                   # 
    addi  $t1, $zero, 10                    # newline = "\n"
    addi  $t2, $zero, 32                    # space = ' '
    addi  $t4, $zero, 0                     # invalid = 0
bsLoop:                                     # for i in range(length):
    lb    $t3, 0($t0)                       #
    beq   $t3, $t1, bsEnd                   #
    addi  $t7, $zero, 32                    # if(curr == ' '):
    beq   $t3, $t7, bsIncr                  # is_valid = True
    addi  $t7, $zero, 42                    # 
    beq   $t3, $t7, bsIsOperator            # elif(curr == "*"):
    addi  $t7, $zero, 43                    #
    beq   $t3, $t7, bsIsOperator            # elif(curr == "+"):
    addi  $t7, $zero, 45                    # 
    beq   $t3, $t7, bsIsOperator            # elif(curr == "-"):
    addi  $t7, $zero, 47                    #
    beq   $t3, $t7, bsIsOperator            # elif(curr == "/"):
    slti  $t7, $t3, 48                      #
    bne   $t7, $zero, bsFailEnd             # elif(re.search('^[\d]$', curr) != None):
    slti  $t7, $t3, 58                      #
    beq   $t7, $zero, bsFailEnd             #
bsIsDigit:                                  #
    addi  $t7, $zero, 32                    # 
    beq   $t2, $t7, bsIncr                  # elif(prev == ' '):
    addi  $t7, $zero, 45                    #
    beq   $t2, $t7, bsIncr                  # elif(prev == '-'):
    slti  $t7, $t2, 48                      #
    bne   $t7, $zero, bsFailEnd             # elif(re.search('^[\d]$', prev) != None):
    slti  $t7, $t2, 58                      #
    beq   $t7, $zero, bsFailEnd             #
    j     bsIncr                            #
bsIsOperator:                               #
    addi  $t7, $zero, 32                    # 
    bne   $t2, $t7, bsFailEnd               # elif(prev == ' '):
bsIncr:                                     #
    add   $t2, $t3, $zero                   # 
    addi  $t0, $t0, 1                       #
    j     bsLoop                            #
bsFailEnd:                                  #
    addi  $t4, $zero, 1                     # invalid = 1
bsEnd:                                      #
    lw    $a0, 0($sp)                       # 
    lw    $ra, 4($sp)                       #
    addi  $sp, $sp, 8                       # 
    add   $v0, $zero, $t4                   #
    jr    $ra                               # return invalid
                                            #
                                            #
                                            #
stackUnderflow:                             # def stackUnderflow(S):
    addi  $sp, $sp -8                       #
    sw    $ra, 4($sp)                       #
    sw    $a0, 0($sp)                       #
    add   $t0, $a0, $zero                   # 
    addi  $t1, $zero, 10                    # newline = "\n"
    add   $t2, $zero, $zero                 # invalid = 0
    add   $t3, $zero, $zero                 # operands = 0
    add   $t4, $zero, $zero                 # operators = 0
suLoop:                                     # for i in range(length):
    lb    $t5, 0($t0)                       #
    beq   $t5, $t1, suEnd                   #
    lb    $t6, 1($t0)                       #
    beq   $t6, $t1, suNextIsSpace           # if i+1 < length:
    addi  $t7, $zero, 32                    #
    bne   $t6, $t7, suIncr                  # 
suNextIsSpace:                              # if next == ' ':
    addi  $t7, $zero, 42                    #
    beq   $t5, $t7, suIsOperator            # elif(curr == "*"): 
    addi  $t7, $zero, 43                    #
    beq   $t5, $t7, suIsOperator            # elif(curr == "+"):
    addi  $t7, $zero, 45                    #  
    beq   $t5, $t7, suIsOperator            # elif(curr == "-"):
    addi  $t7, $zero, 47                    #
    beq   $t5, $t7, suIsOperator            # elif(curr == "/"):
    slti  $t7, $t5, 48                      #  
    bne   $t7, $zero, suIncr                # elif re.search('^[\d]$', curr) != None:
    slti  $t7, $t5, 58                      #
    beq   $t7, $zero, suIncr                #
suIsOperand:                                #
    addi  $t3, $t3, 1                       # operands += 1
    j     suCheckValid                      # 
suIsOperator:                               #
    addi  $t4, $t4, 1                       # operators += 1
suCheckValid:                               #
    add   $t7, $t3, $t4                     #
    beq   $t7, $zero, suIncr                # if (operators > 0 or operands > 0) 
    sub   $t7, $t3, $t4                     #
    blez  $t7, suFailEnd                    # and operands <= operators:
suIncr:                                     #
    addi  $t0, $t0, 1                       #
    j     suLoop                            # 
suFailEnd:                                  #    
    addi  $t2, $zero, 1                     # invalid = 1
suEnd:                                      # 
    lw    $a0, 0($sp)                       #    
    lw    $ra, 4($sp)                       #
    addi  $sp, $sp, 8                       #
    add   $v0, $zero, $t2                   #
    jr    $ra                               # return invalid  
                                            # 
                                            #
                                            #
tooManyOperands:                            # def tooManyOperands(S):
    addi  $sp, $sp -8                       #
    sw    $ra, 4($sp)                       # 
    sw    $a0, 0($sp)                       #  
    add   $t0, $a0, $zero                   #
    addi  $t1, $zero, 10                    #
    add   $t2, $zero, $zero                 #
    add   $t3, $zero, $zero                 # operands = 0
    add   $t4, $zero, $zero                 # operators = 0
tmoLoop:                                    # for i in range(length):
    lb    $t5, 0($t0)                       #
    beq   $t5, $t1, tmoCheckValid           # 
    lb    $t6, 1($t0)                       #
    beq   $t6, $t1, tmoNextIsSpace          # if i+1 == length:
    addi  $t7, $zero, 32                    #     
    bne   $t6, $t7, tmoIncr                 #
tmoNextIsSpace:                             # if next == ' ':
    addi  $t7, $zero, 42                    #
    beq   $t5, $t7, tmoIsOperator           # elif(curr == "*"): 
    addi  $t7, $zero, 43                    #
    beq   $t5, $t7, tmoIsOperator           # elif(curr == "+"): 
    addi  $t7, $zero, 45                    #
    beq   $t5, $t7, tmoIsOperator           # elif(curr == "-"): 
    addi  $t7, $zero, 47                    #
    beq   $t5, $t7, tmoIsOperator           # elif(curr == "/"): 
    slti  $t7, $t5, 48                      #
    bne   $t7, $zero, tmoIncr               # elif re.search('^[+-/*]$', curr) != None:
    slti  $t7, $t5, 58                      #
    beq   $t7, $zero, tmoIncr               #
tmoIsOperand:                               # 
    addi  $t3, $t3, 1                       # operands += 1
    j     tmoIncr                           #
tmoIsOperator:                              #
    addi  $t4, $t4, 1                       # operators += 1
tmoIncr:                                    # 
    addi  $t0, $t0, 1                       #
    j     tmoLoop                           #
tmoCheckValid:                              # 
    sub   $t7, $t3, $t4                     # 
    addi  $t7, $t7, -1                      #
    blez  $t7, tmoEnd                       # if operands - operators > 1:
    add   $t2, $zero, 1                     # invalid = 1
tmoEnd:                                     #
    lw    $a0, 0($sp)                       #
    lw    $ra, 4($sp)                       #
    addi  $sp, $sp, 8                       #   
    add   $v0, $zero, $t2                   # return invalid
    jr    $ra                               #                               
