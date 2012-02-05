#################################################################################
#
#	Richard To
#	rto@alaska.edu
#   CS-241 Assignment 1, Program 2
#   February 5, 2012
#
#	PURPOSE:		Learn how to write selection statements in MIPS.
#
#	ALGORITHM:		score = 102
#                   grade = '?'
#                   valid = 1
#
#                   if score < 0 or score > 100:
#                      valid = 0
#                      grade = '?'
#                   elif score >= 90:
#                       grade = 'A'
#                   elif score >= 80:
#                       grade = 'B'
#                   elif score >= 70:
#                       grade = 'C'
#                   elif score >= 60:
#                       grade = 'D'
#                   else:
#                       grade = 'F'        
#
#	INPUTS:		    SCORE is the score received
#
#	OUTPUTS:		VALID returns the validity of the grade, meaning if the grade
#                   was not less than 0 or greater than 100
#
#                   GRADE returns the letter grade based on the score, or a
#                   question mark if the score was invalid
#
#################################################################################

        .data
SCORE:  .word 105
VALID:  .word 1
GRADE:  .word 63 #ASCII for question mark

        .text
main:
    lw   $t0, SCORE     # SCORE = 102
    lw   $t1, GRADE     # GRADE = '?'
    lw   $t2, VALID     # VALID = 1
    addi $t4, $t0, -100 # if score < 0 or score > 100:
    slti $t3, $t0, 0    # 
    bgtz $t3, nograde   #
    bgez $t4, nograde   # 
    addi $t4, $t0, -90  # elif score >= 90:
    bgez $t4, grade_a   #
    addi $t4, $t0, -80  # elif score >= 80:
    bgez $t4, grade_b   #
    addi $t4, $t0, -70  # elif score >= 70:
    bgez $t4, grade_c   #
    addi $t4, $t0, -60  # elif score >= 60:
    bgez $t4, grade_d   #
                           
    j    grade_f
    
nograde:
    sw   $t1, GRADE     # GRADE = '?'
    sw   $t2, VALID     # VALID = 0
    j    end

grade_a:
    addi $t4, $zero, 65 # GRADE = 'A'
    sw   $t4, GRADE
    sw   $t2, VALID     # VALID = 1
    j    end

grade_b:
    addi $t4, $zero, 66 # GRADE = 'B'
    sw   $t4, GRADE
    sw   $t2, VALID     # VALID = 1
    j    end
    
grade_c:
    addi $t4, $zero, 67 # GRADE = 'C'
    sw   $t4, GRADE
    sw   $t2, VALID     # VALID = 1
    j    end
    
grade_d:
    addi $t4, $zero, 68 # GRADE = 'D'
    sw   $t4, GRADE
    sw   $t2, VALID     # VALID = 1
    j    end
    
grade_f:
    addi $t4, $zero, 70 # GRADE = 'F'
    sw   $t4, GRADE
    sw   $t2, VALID     # VALID = 1
    j    end
                    
end:       
    jr  $ra             # Exit       
