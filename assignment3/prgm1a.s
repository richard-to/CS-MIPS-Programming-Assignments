#################################################################################
#
#   Richard To
#   rto@alaska.edu
#   Assignment 3
#   2012-03-06
#
#   PURPOSE:    Test stripNonAlpha in controlled program
#
#   ALGORITHM:  import re
#
#               def stripNonAlpha(palindrome):
#                   return re.sub(r'\W', '', palindrome)
#                  
#               palindrome = stripNonAlpha("Radofg**!@#@$")   
#        
#
#   INPUTS:     PALINDROME: String with non alpha characters
#
#   OUTPUTS:    ALPHA_STR: String with only alpha characters
#
#################################################################################

              .data
PALINDROME:   .asciiz "19AZaz{][`/:'A=-=fdg!d~[]ofg**!@#SDAS44sas@$\n"

             .text
main:
    la   $a0, PALINDROME
    addi $sp, $sp, -4
    sw   $ra, 0($sp)    
    jal  stripNonAlpha
    lw   $ra, 0($sp)
    addi $sp, $sp, 4 
    add  $s1, $v0, $zero    
    li   $v0, 10    
    syscall
    
stripNonAlpha:
    addi $sp, $sp, -8
    sw   $ra, 0($sp)
    sw   $a0, -4($sp)
    add  $t0, $a0, $zero
    li   $a0, 80
    li   $v0, 9
    syscall
    add  $t1, $v0, $zero
    addi $t2, $zero, 10
    addi $t3, $zero, 1
    
snaLoop:    
    lb   $t4, 0($t0)
    beq  $t4, $t2, snaEnd
    slti $t5, $t4, 48
    beq  $t5, $t3, snaIncr
    slti $t5, $t4, 58
    beq  $t5, $t3, snaAppend
    slti $t5, $t4, 65
    beq  $t5, $t3, snaIncr
    slti $t5, $t4, 91
    beq  $t5, $t3, snaAppend
    slti $t5, $t4, 97
    beq  $t5, $t3, snaIncr
    slti $t5, $t4, 123
    beq  $t5, $zero, snaIncr
    
snaAppend:
    sb   $t4, 0($t1)
    addi $t1, $t1, 1
    
snaIncr:
    addi $t0, $t0, 1
    j snaLoop
    
snaEnd:
    sb   $t2, 0($t1)
    lw   $a0, 4($sp)    
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra 
