            .data
EXPR:       .asciiz "34 34\n"

            .text
main:
    la   $a0, EXPR
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    jal  tooManyOperands
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    add  $s0, $v0, $zero
    li   $v0, 10
    syscall
    
tooManyOperands:
    addi  $sp, $sp -8
    sw    $ra, 0($sp)
    sw    $a0, -4($sp)
    add   $t0, $a0, $zero
    addi  $t1, $zero, 10
    add   $t2, $zero, $zero
    add   $t3, $zero, $zero
    add   $t4, $zero, $zero    
tmoLoop:
    lb    $t5, 0($t0)
    beq   $t5, $t1, tmoCheckValid
    lb    $t6, 1($t0)
    beq   $t6, $t1, tmoNextIsSpace
    addi  $t7, $zero, 32
    bne   $t6, $t7, tmoIncr
tmoNextIsSpace:
    addi  $t7, $zero, 42
    beq   $t5, $t7, tmoIsOperator
    addi  $t7, $zero, 43
    beq   $t5, $t7, tmoIsOperator
    addi  $t7, $zero, 45
    beq   $t5, $t7, tmoIsOperator
    addi  $t7, $zero, 47
    beq   $t5, $t7, tmoIsOperator
    slti  $t7, $t5, 48
    bne   $t7, $zero, tmoIncr
    slti  $t7, $t5, 58
    beq   $t7, $zero, tmoIncr
tmoIsOperand:
    addi  $t3, $t3, 1
    j     tmoIncr        
tmoIsOperator:
    addi  $t4, $t4, 1             
tmoIncr:    
    addi  $t0, $t0, 1
    j     tmoLoop
tmoCheckValid:
    subu  $t7, $t3, $t4
    addiu $t7, $t7, -1
    blez  $t7, tmoEnd
    add   $t2, $zero, 1   
tmoEnd: 
    lw    $a0, 4($sp)
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t2
    jr    $ra    
