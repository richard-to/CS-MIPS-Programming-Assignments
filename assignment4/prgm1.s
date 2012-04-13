#################################################################################
#
#   Richard To
#   rto@alaska.edu
#   Assignment 4
#   2012-04-12
#
#   PURPOSE:    Validates postfix syntax
#
#   ALGORITHM: import re
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
#            putString(S)
#       
#       go_again = raw_input("Enter another string? (Y/n) ")
###############################################################################

                  .data
INPUT_PROMPT:     .asciiz "Enter a postfix expression: "
CONTINUE_PROMPT:  .asciiz "Enter another postfix expression? (Y/n): "
BAD_SYNTAX:       .asciiz "Error: Bad Syntax.\n"
STACK_UNDERFLOW:  .asciiz "Error: Stack Underflow.\n"
TOO_MANY_OPS:     .asciiz "Error: Too many operands.\n" 
CONTINUE:         .space 80
INPUT:            .space 80

                  .text
main:
    addi  $s5, $zero, 89
    la    $a0, INPUT_PROMPT
    jal   putString    
    
    la    $s0, INPUT
    add   $a0, $zero $s0
    jal   getString

mainBadSyntax:
    add   $a0, $s0, $zero
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    jal   badSyntax
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $s1, $v0, $zero
    beq   $s1, $zero, mainStackUnderflow
    la    $a0, BAD_SYNTAX
    jal   putString     
    j     mainContinue
    
mainStackUnderflow:
    add   $a0, $s0, $zero
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    jal   stackUnderflow
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $s1, $v0, $zero
    beq   $s1, $zero, mainTooManyOperands
    la    $a0, STACK_UNDERFLOW
    jal   putString
    j     mainContinue
    
mainTooManyOperands:
    add   $a0, $s0, $zero
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    jal   tooManyOperands
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $s1, $v0, $zero
    beq   $s1, $zero, mainContinue
    la    $a0, TOO_MANY_OPS
    jal   putString
        
mainContinue:
    la    $a0, CONTINUE_PROMPT
    jal   putString
    
    add   $a0, $zero $s0
    jal   getString     
            
    lb      $s4, 0($a0)                    
    beq     $s4, $s5, main
    
mainEnd:                                                                       
    li      $v0, 10                        
    syscall
    
putString:
    li      $v0, 4            
    syscall
    jr       $ra

getString:
    addi    $a1, $zero, 80                         
    li      $v0, 8                         
    syscall
    jr      $ra
                                        
badSyntax:
    addi  $sp, $sp -8
    sw    $ra, 0($sp)
    sw    $a0, -4($sp)
    add   $t0, $a0, $zero
    addi  $t1, $zero, 10
    addi  $t2, $zero, 32
    addi  $t4, $zero, 0
bsLoop:
    lb    $t3, 0($t0)
    beq   $t3, $t1, bsEnd
    addi  $t7, $zero, 32
    beq   $t3, $t7, bsIncr
    addi  $t7, $zero, 42
    beq   $t3, $t7, bsIsOperator
    addi  $t7, $zero, 43
    beq   $t3, $t7, bsIsOperator
    addi  $t7, $zero, 45
    beq   $t3, $t7, bsIsOperator
    addi  $t7, $zero, 47
    beq   $t3, $t7, bsIsOperator   
    slti  $t7, $t3, 48
    bne   $t7, $zero, bsFailEnd
    slti  $t7, $t3, 58
    beq   $t7, $zero, bsFailEnd
bsIsDigit:
    addi  $t7, $zero, 32
    beq   $t2, $t7, bsIncr
    addi  $t7, $zero, 45
    beq   $t2, $t7, bsIncr
    slti  $t7, $t2, 48
    bne   $t7, $zero, bsFailEnd
    slti  $t7, $t2, 58
    beq   $t7, $zero, bsFailEnd       
    j     bsIncr                 
bsIsOperator:
    addi  $t7, $zero, 32
    bne   $t2, $t7, bsFailEnd          
bsIncr:
    add   $t2, $t3, $zero    
    addi  $t0, $t0, 1
    j     bsLoop
bsFailEnd:
    addi  $t4, $zero, 1    
bsEnd:
    lw    $a0, 4($sp)
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t4
    jr    $ra
    


stackUnderflow:
    addi  $sp, $sp -8
    sw    $ra, 0($sp)
    sw    $a0, -4($sp)
    add   $t0, $a0, $zero
    addi  $t1, $zero, 10
    add   $t2, $zero, $zero
    add   $t3, $zero, $zero
    add   $t4, $zero, $zero    
suLoop:
    lb    $t5, 0($t0)
    beq   $t5, $t1, suEnd
    lb    $t6, 1($t0)
    beq   $t6, $t1, suNextIsSpace
    addi  $t7, $zero, 32
    bne   $t6, $t7, suIncr
suNextIsSpace:
    addi  $t7, $zero, 42
    beq   $t5, $t7, suIsOperator
    addi  $t7, $zero, 43
    beq   $t5, $t7, suIsOperator
    addi  $t7, $zero, 45
    beq   $t5, $t7, suIsOperator
    addi  $t7, $zero, 47
    beq   $t5, $t7, suIsOperator
    slti  $t7, $t5, 48
    bne   $t7, $zero, suIncr
    slti  $t7, $t5, 58
    beq   $t7, $zero, suIncr
suIsOperand:
    addi  $t3, $t3, 1
    j     suCheckValid        
suIsOperator:
    addi  $t4, $t4, 1
suCheckValid:
    add   $t7, $t3, $t4
    beq   $t7, $zero, suIncr
    subu  $t7, $t3, $t4
    blez  $t7, suFailEnd               
suIncr:    
    addi  $t0, $t0, 1
    j     suLoop
suFailEnd:
    addi  $t2, $zero, 1    
suEnd:
    lw    $a0, 4($sp)
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t2
    jr    $ra
    
    
    
tooManyOperands:
    addi  $sp, $sp -8
    sw    $ra, 0($sp)
    sw    $a0, -4($sp)
    add   $t0, $a0, $zero
    addi  $t1, $zero, 10
    add   $t2, $zero, $zero
    add   $t3, $zero, $zero
    add   $t4, $zero, $zero    
tmoLoop:
    lb    $t5, 0($t0)
    beq   $t5, $t1, tmoCheckValid
    lb    $t6, 1($t0)
    beq   $t6, $t1, tmoNextIsSpace
    addi  $t7, $zero, 32
    bne   $t6, $t7, tmoIncr
tmoNextIsSpace:
    addi  $t7, $zero, 42
    beq   $t5, $t7, tmoIsOperator
    addi  $t7, $zero, 43
    beq   $t5, $t7, tmoIsOperator
    addi  $t7, $zero, 45
    beq   $t5, $t7, tmoIsOperator
    addi  $t7, $zero, 47
    beq   $t5, $t7, tmoIsOperator
    slti  $t7, $t5, 48
    bne   $t7, $zero, tmoIncr
    slti  $t7, $t5, 58
    beq   $t7, $zero, tmoIncr
tmoIsOperand:
    addi  $t3, $t3, 1
    j     tmoIncr        
tmoIsOperator:
    addi  $t4, $t4, 1             
tmoIncr:    
    addi  $t0, $t0, 1
    j     tmoLoop
tmoCheckValid:
    subu  $t7, $t3, $t4
    addiu $t7, $t7, -1
    blez  $t7, tmoEnd
    add   $t2, $zero, 1   
tmoEnd: 
    lw    $a0, 4($sp)
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t2
    jr    $ra                              
