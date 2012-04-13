            .data
EXPR:       .asciiz "1 -2 * / 3 4 -\n"

            .text
main:
    la    $a0, EXPR
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    jal   stackUnderflow
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $s0, $v0, $zero
    li    $v0, 10
    syscall
    
stackUnderflow:
    addi  $sp, $sp -8
    sw    $ra, 0($sp)
    sw    $a0, -4($sp)
    add   $t0, $a0, $zero
    addi  $t1, $zero, 10
    add   $t2, $zero, $zero
    add   $t3, $zero, $zero
    add   $t4, $zero, $zero    
suLoop:
    lb    $t5, 0($t0)
    beq   $t5, $t1, suEnd
    lb    $t6, 1($t0)
    beq   $t6, $t1, suNextIsSpace
    addi  $t7, $zero, 32
    bne   $t6, $t7, suIncr
suNextIsSpace:
    addi  $t7, $zero, 42
    beq   $t5, $t7, suIsOperator
    addi  $t7, $zero, 43
    beq   $t5, $t7, suIsOperator
    addi  $t7, $zero, 45
    beq   $t5, $t7, suIsOperator
    addi  $t7, $zero, 47
    beq   $t5, $t7, suIsOperator
    slti  $t7, $t5, 48
    bne   $t7, $zero, suIncr
    slti  $t7, $t5, 58
    beq   $t7, $zero, suIncr
suIsOperand:
    addi  $t3, $t3, 1
    j     suCheckValid        
suIsOperator:
    addi  $t4, $t4, 1
suCheckValid:
    add   $t7, $t3, $t4
    beq   $t7, $zero, suIncr
    subu  $t7, $t3, $t4
    blez  $t7, suFailEnd               
suIncr:    
    addi  $t0, $t0, 1
    j     suLoop
suFailEnd:
    addi  $t2, $zero, 1    
suEnd:
    lw    $a0, 4($sp)
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t2
    jr    $ra    
