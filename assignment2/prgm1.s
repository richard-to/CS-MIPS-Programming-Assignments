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
#                       if line.startswith('001000', 8):
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

        .data
R_TYPES:  .word 0
I_TYPES:  .word 0
J_TYPES:  .word 0

        .text
main:                               # 
    la    $s0, 0x00400000           # file = open('prgm1.txt', 'r')
                                    #
    lui   $t1, 0xFC00               # OPCODE_MASK                                     
    lui   $s1, 0x800                # J_OPCODE
    lui   $s2, 0xC00                # JAL_OPCODE
    addi  $s3, 8                    # JR_FUNCT
                                    #                
    add   $s4, $zero, $zero         # R_TYPES = 0
    add   $s5, $zero, $zero         # I_TYPES = 0
    add   $s6, $zero, $zero         # J_TYPES = 0
                                    #         
loop:                               # for line in file:
    lw    $t0, 0($s0)               #
    and   $t2, $t0, $t1             #
    beq   $t2, $s1, is_jtype        # if line.startswith('000010') or 
    beq   $t2, $s2, is_jtype        # line.startswith('000011'):   
    bne   $t2, $zero, is_itype      # elif line.startswith('000000') == False:
is_rtype:                           #       
    addi  $s4, $s4, 1               # R_TYPES += 1
    andi  $t3, $t0, 0x3f            # 
    beq   $t3, $s3, endloop         # if line.startswith('001000', 8):       
    j     continue                  #
                                    #
is_jtype:                           #
    addi  $s6, $s6, 1               # J_TYPES += 1
    j     continue                  #
                                    #
is_itype:                           #
    addi  $s5, $s5, 1               # I_TYPES += 1
    j     continue                  #
                                    #
continue:                           #
    addi  $s0, $s0, 4               #
    j     loop                      #
                                    #
endloop:                            #
    sw    $s4, R_TYPES              # Store R Types
    sw    $s5, J_TYPES              # Store J Types
    sw    $s6, I_TYPES              # Store I Types                                
    jr    $ra                       # Exit
