#################################################################################
#
#   Richard To
#   rto@alaska.edu
#   Assignment 3
#   2012-03-06
#
#   PURPOSE:    Test isAPalindrome in controlled program
#
#   ALGORITHM:  
#               def isAPalindrome(palindrome):
#                   return palindrome == palindrome[::-1]
#                  
#               palindrome = isAPalindrome("SDFdddswerTT")      
#
#   INPUTS:     PALINDROME: String with upper characters
#
#   OUTPUTS:    IS_PALINDROME: Whether string is palindrome or not
#
#################################################################################

               .data
PALINDROME:    .asciiz "otto\n"
IS_PALINDROME: .word 0
 
               .text
main:
    la      $a0, PALINDROME
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)
    jal     isAPalindrome
    lw      $ra  0($sp)
    sw      $v0, IS_PALINDROME
    addi    $sp, $sp, 4
    li      $v0, 10
    syscall
    
isAPalindrome:
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)
    add     $t0, $a0, $zero
    add     $t1, $t0, $zero
    add     $t2, $zero, $zero
    addi    $t3, $zero, 10

iapLengthLoop:
    lb      $t4, 0($t1)
    beq     $t4, $t3, iapLengthLoopEnd
    addi    $t1, $t1, 1
    j       iapLengthLoop

iapLengthLoopEnd:
    addi    $t1, $t1, -1
    
iapCompare:
    lb      $t4, 0($t0)
    lb      $t5, 0($t1)
    beq     $t4, $t3, iapPalindromeTrue    
    bne     $t4, $t5, iapPalindromeFalse
    addi    $t0, $t0, 1
    addi    $t1, $t1, -1
    j       iapCompare
    
iapPalindromeTrue:
    addi    $v0, $zero, 1 
    j       iapEnd
    
iapPalindromeFalse:
    add    $v0, $zero, $zero   
                  
iapEnd:    
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra            
