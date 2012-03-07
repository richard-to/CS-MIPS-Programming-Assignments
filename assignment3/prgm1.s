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
#
#################################################################################

                 .data
INPUT_PROMPT:    .asciiz "Enter a string: "
CONTINUE_PROMPT: .asciiz "Enter another string? (Y/n): "                
CONTINUE:        .word 0
IS_PALINDROME:   .word 0
INPUT:           .word 0

                 .text             # go_again = "Y"
main:                              # while go_again == "Y":
    la      $a0, INPUT_PROMPT      # palindrome = raw_input("Enter a string: ")
    li      $v0, 4                 #
    syscall                        #
                                   #
    la      $a0, INPUT             #
    li      $v0, 8                 #
    syscall                        #  
                                   #
    li      $v0, 10                #
    syscall                        #
    
