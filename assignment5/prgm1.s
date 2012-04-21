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
    jal   solveExpr                         #    
    lw    $ra, 0($sp)                       #
    addi  $sp, $sp, 4                       #
    add   $s3, $zero, $v0                   #
    add   $s4, $zero, $v1,                  #
    addi  $s5, $zero, 1                     #        
    beq   $v0, $s5, mainNoArgs              #
    addi  $s5, $zero, 2                     # 
    beq   $v0, $s5, mainOneArg              #   
    addi  $s5, $zero, 3                     #  
    beq   $v0, $s5, mainDiv0                #                              
mainAnswer:
    la    $a0, ANSWER_PROMPT                #
    jal   putString                         #   
    add   $a0, $zero, $v1                   #
    jal   putInteger                        #
    add   $a0, $zero, 10                    #
    jal   putChar                           #          
    j     mainContinue                      #
mainNoArgs:                                 #
    la    $a0, NO_ARGS                      #
    jal   putString                         #
    j     mainContinue                      #
mainOneArg:                                 # 
    la    $a0, ONE_ARG                      #
    jal   putString                         #
    j     mainContinue                      #
mainDiv0:                                   #
    la    $a0, DIV_ZERO                     #
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



Empty:
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    add   $t0, $zero, $zero
    bltz  $s0, eEnd
    addi  $t0, $zero, 1
eEnd:    
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t0
    jr    $ra
    
    
Full:
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    add   $t0, $zero, $zero
    bne   $s0, $s1, fEnd
    addi  $t0, $zero, 1
fEnd:    
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t0
    jr    $ra
    
         
Push:
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    addi  $s0, $s0, 4
    add   $t0, $a0, $s0
    sw    $a1, 0($t0)
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    jr    $ra    


Pop:
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    add   $t0, $a0, $s0
    lw    $v0, 0($t0)
    lw    $ra, 0($sp)
    addi  $s0, $s0, -4    
    addi  $sp, $sp, 4
    jr    $ra
    
    

getNumber:
    addi  $sp, $sp, -8
    sw    $ra, 4($sp)
    sw    $a0, 0($sp)
    add   $t0, $a0, $zero
    add   $t1, $zero, $zero
    addi  $t4, $zero, 10
gnLoop:
    lb    $t2, 0($t0)
    beq   $t2, $zero, gnEnd
    mult  $t1, $t4
    mflo  $t1
    addi  $t3, $t2, -48
    add   $t1, $t1, $t3
    addi  $t0, $t0, 1
    j     gnLoop    
gnEnd:
    lw    $a0, 0($sp)
    lw    $ra, 4($sp)
    addi  $sp, $sp, 8
    add   $v0, $zero, $t1
    jr    $ra  
    
    
    
applyOperator:
    addi  $sp, $sp, -8
    sw    $ra, 4($sp)
    sw    $a0, 0($sp)    
    add   $t0, $zero, $a0
    addi  $sp, $sp, -4
    sw    $t0, 0($sp)   
    la    $a0, S      
    jal   Empty
    add   $t1, $zero, $v0    
    lw    $t0, 0($sp)
    addi  $sp, $sp, 4
    beq   $t1, $zero, aoNoArgs
    addi  $sp, $sp, -4
    sw    $t0, 0($sp)   
    la    $a0, S      
    jal   Pop
    lw    $t0, 0($sp)
    addi  $sp, $sp, 4
    add   $t2, $zero, $v0
    addi  $sp, $sp, -8
    sw    $t0, 4($sp)
    sw    $t2, 0($sp)      
    la    $a0, S      
    jal   Empty
    add   $t1, $zero, $v0   
    lw    $t2, 0($sp)    
    lw    $t0, 4($sp)
    addi  $sp, $sp, 8
    beq   $t1, $zero, aoOneArgs
    addi  $sp, $sp, -8
    sw    $t0, 4($sp)
    sw    $t2, 0($sp)      
    la    $a0, S      
    jal   Pop
    add   $t3, $zero, $v0    
    lw    $t2, 0($sp)    
    lw    $t0, 4($sp)
    addi  $sp, $sp, 8
    addi  $t4, $zero, 43 
    beq   $t0, $t4, aoAdd
    addi  $t4, $zero, 45
    beq   $t0, $t4, aoSub
    addi  $t4, $zero, 42
    beq   $t0, $t4, aoMult
    addi  $t4, $zero, 47
    beq   $t0, $t4, aoDiv
aoDiv:
    beq   $t2, $zero, aoDiv0
    div   $t3, $t2
    mflo  $t5
    j     aoPush    
aoMult:
    mult  $t3, $t2
    mflo  $t5
    j     aoPush                                
aoAdd:
    add   $t5, $t3, $t2
    j     aoPush
aoSub:
    sub   $t5, $t3, $t2
aoPush:
    addi  $sp, $sp, -4
    sw    $t5, 0($sp)      
    la    $a0, S
    add   $a1, $zero, $t5      
    jal   Push
    addi  $v0, $zero, 0    
    lw    $t5, 0($sp)    
    addi  $sp, $sp, 4
    j     aoEnd 
aoDiv0:
    addi  $v0, $zero, 3
    j     aoEnd      
aoOneArgs:
    addi  $v0, $zero, 2
    j     aoEnd           
aoNoArgs:
    addi  $v0, $zero, 1  
    j     aoEnd    
aoEnd:        
    lw    $a0, 0($sp)    
    lw    $ra, 4($sp)    
    addi  $sp, $sp, 8
    jr    $ra
    
    
    
solveExpr:
    addi  $sp, $sp -8
    sw    $ra, 4($sp)
    sw    $a0, 0($sp)    
    add   $t0, $zero, $a0                                    
    la    $t1, OPERAND
    add   $t2, $zero, $t1
    addi  $t9, $zero, 1                    
seLoop:                                     
    lb    $t3, 0($t0)
    addi  $t4, $zero, 10                              
    beq   $t3, $t4, seSuccess
    lb    $t5, 1($t0)    
    bne   $t5, $t4, seParseExpr           
    addi  $t5, $zero, 32
seParseExpr:
    slti  $t4, $t3, 48                      
    bne   $t4, $zero, seElifNotDigit
seIfDigit:             
    sb    $t3, 0($t2)
    addi  $t2, $t2, 1
    addi  $t4, $zero, 32    
    bne   $t5, $t4, seIncr
seIfDigitAndNextSpace:
    addi  $sp, $sp -16
    sw    $t0, 12($sp)
    sw    $t1, 8($sp)
    sw    $t2, 4($sp)        
    sw    $t9, 0($sp)       
    sb    $zero, 0($t2)
    add   $a0, $zero, $t1
    jal   getNumber  
    add   $t8, $zero, $v0
    lw    $t9, 0($sp)
    lw    $t2, 4($sp)
    lw    $t1, 8($sp)        
    lw    $t0, 12($sp) 
    addi  $sp, $sp, 16
    mult  $t9, $t8
    mflo  $t7
    addi  $sp, $sp -16
    sw    $t0, 12($sp)
    sw    $t1, 8($sp)
    sw    $t2, 4($sp)        
    sw    $t9, 0($sp)
    la    $a0, S
    add   $a1, $zero, $t7
    jal   Push
    lw    $t9, 0($sp)
    lw    $t2, 4($sp)
    lw    $t1, 8($sp)        
    lw    $t0, 12($sp) 
    addi  $sp, $sp, 16
    addi  $t9, $zero, 1
    add   $t2, $zero, $t1                         
    j     seIncr    
seElifNotDigit:
    addi  $t4, $zero, 45                    
    beq   $t3, $t4, seElifNeg    
    addi  $t4, $zero, 42                    
    beq   $t3, $t4, seElifOperator            
    addi  $t4, $zero, 43                    
    beq   $t3, $t4, seElifOperator                        
    addi  $t4, $zero, 47                    
    beq   $t3, $t4, seElifOperator
    j     seIncr               
seElifNeg:
    addi  $t4, $zero, 32
    beq   $t5, $t4, seElifOperator
    addi  $t9, $zero -1
    j     seIncr
seElifOperator:
    addi  $sp, $sp -16
    sw    $t0, 12($sp)
    sw    $t1, 8($sp)
    sw    $t2, 4($sp)        
    sw    $t9, 0($sp)   
    add   $a0, $zero, $t3
    jal   applyOperator
    add   $t8, $zero, $v0
    lw    $t9, 0($sp)
    lw    $t2, 4($sp)
    lw    $t1, 8($sp)        
    lw    $t0, 12($sp) 
    addi  $sp, $sp, 16
    bne   $t8, $zero, seError                                                
seIncr:                                     
    addi  $t0, $t0, 1                       
    j     seLoop
seError:
    add   $v0, $zero, $t8
    add   $v1, $zero, $zero    
    j     seEnd  
seSuccess:
    add   $v0, $zero, $zero
    lw    $t7, S($zero)
    add   $v1, $zero, $t7             
seEnd:
    lw    $a0, 0($sp)    
    lw    $ra, 4($sp)    
    addi  $sp, $sp, 8
    jr    $ra
    

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
