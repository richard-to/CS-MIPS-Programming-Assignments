#################################################################################
#
#   Richard To
#   rto@alaska.edu
#   Assignment 3
#   2012-03-05
#
#   PURPOSE:    Checks if the user entered string is a palindrome
#
#   ALGORITHM:  import re
#
#               def stripNonAlpha(palindrome):
#                   return re.sub(r'\W', '', palindrome)
#
#               def toUpperCase(palindrome):
#                   return palindrome.upper()
#
#               def isAPalindrome(palindrome):
#                   return palindrome == palindrome[::-1]
#                    
#               go_again = "Y"
#               while go_again == "Y":
#                                  
#                   palindrome = raw_input("Enter a string: ")
#                   palindrome = stripNonAlpha(palindrome)
#                   palindrome = toUpperCase(palindrome)
#                   is_palindrome = isAPalindrome(palindrome)
#
#                   print is_palindrome
#                    
#                   go_again = raw_input("Enter another string? (Y/n) ")     
#        
#
#   INPUTS:     INPUT: User entered value that will be tested for its 
#               palindrome properties
#               CONTINUE: Whether the user wants to enter another string 
#
#   OUTPUTS:    IS_PALINDROME: Whether the user entered value was a palindrome
#               INPUT_PROMPT: Text asking user to enter palindrome
#               CONTINUE_PROMPT: Text asking whether user wants to enter another
#               NOT_PAL: Text saying the palindrome was invalid
#               IS_PAL: Text saying the palindrome was valid
#################################################################################

                 .data
INPUT_PROMPT:    .asciiz "Enter a palindrome: "
CONTINUE_PROMPT: .asciiz "Enter another palindrome? (Y/n): "
NOT_PAL:         .asciiz "Invalid Palindrome.\n"
IS_PAL:          .asciiz "Valid Palindrome.\n"                
CONTINUE:        .word 0
INPUT:           .space 80
IS_PALINDROME:   .word 0


                 .text             
main:                                      # while go_again == "Y":
    addi    $s5, $zero, 89                 # go_again = "Y"
    la      $a0, INPUT_PROMPT              # input = 
    li      $v0, 4                         #    raw_input("Enter a palindrome: ")  
    syscall                                #
                                           #
    la      $s0, INPUT                     #           
    add     $a0, $s0, $zero                #
    addi    $a1, $zero, 80                 #            
    li      $v0, 8                         #
    syscall                                #     
                                           #
mainStrip:                                 #
    add     $a0, $s0, $zero                #                       
    addi    $sp, $sp, -4                   #
    sw      $ra, 0($sp)                    #
    jal     stripNonAlpha                  # pal = stripNonAlpha(input)
    lw      $ra, 0($sp)                    #
    addi    $sp, $sp, 4                    #
    add     $s1, $v0, $zero                # 
                                           #
mainUpper:                                 #
    add     $a0, $s1, $zero                #                        
    addi    $sp, $sp, -4                   # 
    sw      $ra, 0($sp)                    #
    jal     toUpperCase                    # upperPal = toUpperCase(pal)
    lw      $ra, 0($sp)                    #
    addi    $sp, $sp, 4                    #
    add     $s2, $v0, $zero                # 
                                           #
mainPalindrome:                            #
    add     $a0, $s2, $zero                #                            
    addi    $sp, $sp, -4                   #
    sw      $ra, 0($sp)                    #
    jal     isAPalindrome                  # is_pal = isAPalindrome(upperPal)
    lw      $ra, 0($sp)                    #
    addi    $sp, $sp, 4                    # 
    add     $s3, $v0, $zero                #
    beq     $s3, $zero, mainNotPal         # if is_pal:
    la      $a0, IS_PAL                    #     print "Valid palindrome"  
    li      $v0, 4                         #
    syscall                                #
    j       mainContinue                   #
                                           #
mainNotPal:                                # else:
    la      $a0, NOT_PAL                   #     print "Invalid palindrome"
    li      $v0, 4                         #
    syscall                                #
                                           #
mainContinue:                              # 
    la      $a0, CONTINUE_PROMPT           # go_again = 
    li      $v0, 4                         #     raw_input("Enter another palindrome? (Y/n) ")
    syscall                                #
                                           #
    la      $a0, CONTINUE                  #
    addi    $a1, 2                         #
    li      $v0, 8                         #
    syscall                                #
                                           #
mainEnd:                                   #
    lb      $s4, 0($a0)                    #
    beq     $s4, $s5, main                 #        
    li      $v0, 10                        #
    syscall                                #  Exit
                                           #
                                           #    
stripNonAlpha:                             # def stripNonAlpha(str):
    addi    $sp, $sp, -8                   #
    sw      $ra, 0($sp)                    #
    sw      $a0, -4($sp)                   #
    add     $t0, $a0, $zero                #
    li      $a0, 80                        #
    li      $v0, 9                         # 
    syscall                                #  
    add     $t1, $v0, $zero                #
    addi    $t2, $zero, 10                 #
    addi    $t3, $zero, 1                  #
                                           #
snaLoop:                                   # return re.sub(r'\W', '', str)
    lb      $t4, 0($t0)                    #
    beq     $t4, $t2, snaEnd               #     
    slti    $t5, $t4, 48                   #
    beq     $t5, $t3, snaIncr              #
    slti    $t5, $t4, 58                   #
    beq     $t5, $t3, snaAppend            #
    slti    $t5, $t4, 65                   #
    beq     $t5, $t3, snaIncr              #
    slti    $t5, $t4, 91                   #
    beq     $t5, $t3, snaAppend            #
    slti    $t5, $t4, 97                   #
    beq     $t5, $t3, snaIncr              #
    slti    $t5, $t4, 123                  #
    beq     $t5, $zero, snaIncr            #
                                           #
snaAppend:                                 #
    sb      $t4, 0($t1)                    #  
    addi    $t1, $t1, 1                    # 
                                           # 
snaIncr:                                   #
    addi    $t0, $t0, 1                    #
    j       snaLoop                        #
                                           # 
snaEnd:                                    # 
    sb      $t2, 0($t1)                    #
    lw      $a0, 4($sp)                    #
    lw      $ra, 0($sp)                    #
    addi    $sp, $sp, 4                    #
    jr      $ra                            #
                                           #
                                           #
toUpperCase:                               #
    addi    $sp, $sp, -8                   #
    sw      $ra, 0($sp)                    #
    sw      $a0, -4($sp)                   #
    add     $t0, $a0, $zero                #
    li      $a0, 80                        # 
    li      $v0, 9                         #  
    syscall                                #
    add     $t1, $v0, $zero                # 
    addi    $t2, $zero, 10                 #
    addi    $t3, $zero, 1                  #
                                           #
tucLoop:                                   #
    lb      $t4, 0($t0)                    #
    beq     $t4, $t2, tucEnd               # 
    slti    $t5, $t4, 123                  #
    beq     $t5, $zero, tucIncr            #
    slti    $t5, $t4, 97                   #
    beq     $t5, $t3, tucIncr              #  
    addi    $t4, $t4, -32                  #
tucIncr:                                   #
    sb      $t4, 0($t1)                    # 
    addi    $t1, $t1, 1                    #
    addi    $t0, $t0, 1                    #
    j       tucLoop                        #
                                           #
tucEnd:                                    #
    sb      $t2, 0($t1)                    #
    lw      $ra, 4($sp)                    #
    lw      $ra, 0($sp)                    # 
    addi    $sp, $sp, 8                    #
    jr      $ra                            #
                                           #
                                           #
isAPalindrome:                             #
    addi    $sp, $sp, -4                   # 
    sw      $ra, 0($sp)                    #
    add     $t0, $a0, $zero                # 
    add     $t1, $t0, $zero                #
    add     $t2, $zero, $zero              #
    addi    $t3, $zero, 10                 #
                                           #
iapLengthLoop:                             #
    lb      $t4, 0($t1)                    #
    beq     $t4, $t3, iapLengthLoopEnd     #
    addi    $t1, $t1, 1                    #  
    j       iapLengthLoop                  #
                                           #
iapLengthLoopEnd:                          # 
    addi    $t1, $t1, -1                   #
                                           # 
iapCompare:                                #
    lb      $t4, 0($t0)                    #
    lb      $t5, 0($t1)                    # 
    beq     $t4, $t3, iapPalindromeTrue    # 
    bne     $t4, $t5, iapPalindromeFalse   #
    addi    $t0, $t0, 1                    #  
    addi    $t1, $t1, -1                   #
    j       iapCompare                     #
                                           #
iapPalindromeTrue:                         #
    addi    $v0, $zero, 1                  #
    j       iapEnd                         #
                                           #
iapPalindromeFalse:                        #
    add    $v0, $zero, $zero               #
                                           #
iapEnd:                                    #
    lw      $ra, 0($sp)                    #
    addi    $sp, $sp, 4                    #
    jr      $ra                            # 
