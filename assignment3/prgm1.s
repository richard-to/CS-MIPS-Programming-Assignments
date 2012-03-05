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
