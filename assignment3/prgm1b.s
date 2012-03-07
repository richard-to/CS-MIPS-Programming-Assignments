#################################################################################
#
#   Richard To
#   rto@alaska.edu
#   Assignment 3
#   2012-03-06
#
#   PURPOSE:    Test toUpperCase in controlled program
#
#   ALGORITHM:  
#               def toUpperCase(palindrome):
#                   return palindrome.upper()
#                  
#               palindrome = toUpperCase("SDFdddswerTT")      
#
#   INPUTS:     PALINDROME: String with upper and lowercase characters
#
#   OUTPUTS:    UPPER_STR: String with only uppercase alpha characters
#
#################################################################################

            .data
PALINDROME:  .asciiz "SwaeDFdddswzerTssT\n"

            .text
main:
    la      $a0, PALINDROME
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)
    jal     toUpperCase
    lw      $ra, 0($sp)    
    addi    $sp, $sp, 4
    li      $v0, 10
    syscall
    
    
toUpperCase:
    addi    $sp, $sp, -8
    sw      $ra, 0($sp)
    sw      $a0, -4($sp)
    add     $t0, $a0, $zero
    li      $a0, 80
    li      $v0, 9
    syscall
    add     $t1, $v0, $zero
    addi    $t2, $zero, 10
    addi    $t3, $zero, 1
    
tucLoop:
    lb      $t4, 0($t0)
    beq     $t4, $t2, tucEnd
    slti    $t5, $t4, 123
    beq     $t5, $zero, tucIncr
    slti    $t5, $t4, 97
    beq     $t5, $t3, tucIncr
    addi    $t4, $t4, -32
tucIncr:
    sb      $t4, 0($t1) 
    addi    $t1, $t1, 1
    addi    $t0, $t0, 1
    j       tucLoop          
        
tucEnd:
    lw      $ra, 4($sp)
    lw      $ra, 0($sp)        
    addi    $sp, $sp, 8
    jr      $ra    
    
    
          
