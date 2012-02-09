#################################################################################
#
#   Richard To
#   rto@alaska.edu
#   CS-221 Assignment 1, Program 3
#   February 5, 2012
#
#   PURPOSE:        Learn how to write loops in MIPS
#
#   ALGORITHM:      total = 0
#                   upper = 0
#                   lower = 0
#                   chars = 'aBwdfe$%2s.';
#
#                   for c in chars:
#                       if c == '.':
#                           break;                    
#                       total += 1
#                       if c >= 'A' and c <= 'Z':
#                           upper += 1
#                       elif c >= 'a' and c <= 'z':
#                           lower += 1
#
#   INPUTS:	    CHARS is the characters that will be be run through the loop
#               and test for total characters, uppercase, and lowercase.
#
#   OUTPUTS:    TOTAL returns the total characters in string.
#               
#               UPPER returns the total uppercase characters
#
#               LOWER returns the total lowercase characters
#
#################################################################################

        .data
CHARS:  .asciiz "aBwdfe$%2s."
UPPER:  .word 0
LOWER:  .word 0
TOTAL:  .word 0

        .text
main:
    add   $t4, $zero, $zero     # I = 0
    add   $t0, $zero, $zero     # TOTAL = 0
    add   $t1, $zero, $zero     # UPPER = 0 
    add   $t2, $zero, $zero     # LOWER = 0
    addi  $t3, $zero, 46        # ENDPOINT = '.'
loop:
    lb    $t5, CHARS($t4)       # for c in chars
    beq   $t5, $zero, endloop   #
    beq   $t5, $t3, endloop     # if c == '.':     
    addi  $t4, $t4, 1           # i += 1    
    addi  $t0, $t0, 1           # total += 1
    addi  $t6, $t5, -65         # if c >= 'A' and c <= 'Z': 
    bltz  $t6, loop             #
    addi  $t6, $t5, -90         #
    blez  $t6, isupper          #
    addi  $t6, $t5, -97         # if c >= 'a' and c <= 'z': 
    bltz  $t6, loop             #
    addi  $t6, $t5, -122        #
    blez  $t6, islower          #         
    j     loop

isupper:
    addi  $t1, $t1, 1           # upper += 1 
    j     loop

islower:
    addi  $t2, $t2, 1           # lower += 1 
    j     loop
            
endloop:
    sw   $t0, TOTAL             # Store TOTAL
    sw   $t1, UPPER             # Store UPPER
    sw   $t2, LOWER             # Store LOWER 
    li   $v0, 10                # Syscall Exit
    syscall
