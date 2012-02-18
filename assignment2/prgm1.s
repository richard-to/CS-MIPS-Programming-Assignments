#################################################################################
#
#   Richard To
#   rto@alaska.edu
#   Programming Assignment 2
#   2012-02-18
#
#   PURPOSE:    Write a program that reads its own instructions and counts
#               the occurrences of each type of instruction.
#
#   ALGORITHM:  rTypes = 0
#               iTypes = 0
#               jTypes = 0
#
#               file = open('prgm1.txt', 'r')
#               for line in file:
#                   if line.startswith('000010') or line.startswith('000011'):
#                       jTypes += 1
#                   elif line.startswith('000000') == False:
#                       iTypes += 1
#                   else:
#                       rTypes += 1    
#                       if line.startswith('001000', 26):
#                           break
#            
#               file.close()      
#               
#
#   INPUTS:     No inputs will be used since we are reading the program itself.
#
#   OUTPUTS:    R_TYPES: A count of all rtype instructions used.
#               I_TYPES: A count of all itype instructions used.
#               J_TYPES: A count of all jtype instructions used.
#
#################################################################################
