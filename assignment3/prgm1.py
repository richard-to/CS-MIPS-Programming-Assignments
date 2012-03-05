import re

def stripNonAlpha(palindrome):
    return re.sub(r'\W', '', palindrome)

def toUpperCase(palindrome):
    return palindrome.upper()

def isAPalindrome(palindrome):
    return palindrome == palindrome[::-1]
    
go_again = "Y"
while go_again == "Y":
                  
    palindrome = raw_input("Enter a string: ")
    palindrome = stripNonAlpha(palindrome)
    palindrome = toUpperCase(palindrome)
    is_palindrome = isAPalindrome(palindrome)

    print is_palindrome
    
    go_again = raw_input("Enter another string? (Y/n) ")     
