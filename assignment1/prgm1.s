#################################################################################
#	
#   Richard To
#   rto@alaska.edu
#   CS-221 Assignment 1, Program 1
#   February 4, 2012
#
#   PURPOSE:        This program demonstrates various MIPS instructions.
#
#   ALGORITHM:      a = 2
#                   b = 55
#                   c = 2353
#                   d = 4
#
#                   a = (a << 1) + (a << 2)
#
#                   b = b >> 3
#
#                   c = c >> 10
#
#                   #Couldn't figure out a simple way to rotate bits in python
#                   d = d << 12
#
#   INPUTS:         The values of A_VAL, B_VAL, C_VAL, D_VAL will be integers 
#                   which will have various computations performed on them.                   
#
#   OUTPUTS:        The value of "A_VAL" will be multipled by 6
#                   The value of "B_VAL" will be divided by 8
#                   The value of "C_VAL" will be shifted to the right 10 bit places
#                   The value of "D_VAL" will be rotated to the left 12 places
#
#################################################################################

        .data
A_VAL:  .word -3
B_VAL:  .word -128
C_VAL:  .word -4355
D_VAL:  .word -300

        .text
main:
    lw   $t0, A_VAL       # Load the value of A into temp register $t0
    sll  $t1, $t0, 1      # Shift A to the left by 1 to multiply A by 2
    sll  $t2, $t0, 2      # Shift A to the left by 2 to multiply A by 4
    add  $t3, $t1, $t2    # Add the results of $t1 and $t2 to get A x 6
    sw   $t3, A_VAL       # Store the result back into A
    
    lw   $t0, B_VAL       # Load the value of B into temp register $t0
    andi $t7, $t0, 0x8000 # Mask the value of B and get the most significant byte
    srl  $t6, $t7, 1      # Shift sign bits over 1
    or   $t6, $t6, $t7    # Change left most bit to correct sign
    srl  $t6, $t6, 1      # Shift sign bits over 1
    or   $t6, $t6, $t7    # Change left most bit to the correct sign (000 or 111)  
    sll  $t6, $t6, 16     # Shift everything left 16 bits   
    srl  $t2, $t0, 3      # Divide B by 3 by shifting to the right 3 bits 
    or   $t1, $t2, $t6    # Change left three bits to correct sign         
    sw   $t1, B_VAL       # Store the result back into B
    
    lw   $t0, C_VAL      # Load the value of C into temp register $t0
    srl  $t1, $t0, 10    # Shift the value of C ten places
    sw   $t1, C_VAL      # Store the result back into C
    
    
    lw   $t0, D_VAL      # Load the value of D into temp register $t0
    rol  $t1, $t0, 12    # Rotate the value of D 12 places
    sw   $t1, D_VAL      # Store the result back into D
       
    li   $v0, 10         # Syscall Exit
    syscall  
