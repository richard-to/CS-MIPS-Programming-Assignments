            .data
EXPR:       .asciiz "-12 -54 * 78 as 360 343 - 20 /\n"

            .text
main:
    la    $a0, EXPR
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    jal   badSyntax
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $s0, $v0, $zero
    li    $v0, 10
    syscall
    
badSyntax:
    addi  $sp, $sp -8
    sw    $ra, 4($sp)
    sw    $a0, 0($sp)
    add   $t0, $a0, $zero
    addi  $t1, $zero, 10
    addi  $t2, $zero, 32
    addi  $t4, $zero, 0
bsLoop:
    lb    $t3, 0($t0)
    beq   $t3, $t1, bsEnd
    addi  $t7, $zero, 32
    beq   $t3, $t7, bsIncr
    addi  $t7, $zero, 42
    beq   $t3, $t7, bsIsOperator
    addi  $t7, $zero, 43
    beq   $t3, $t7, bsIsOperator
    addi  $t7, $zero, 45
    beq   $t3, $t7, bsIsOperator
    addi  $t7, $zero, 47
    beq   $t3, $t7, bsIsOperator   
    slti  $t7, $t3, 48
    bne   $t7, $zero, bsFailEnd
    slti  $t7, $t3, 58
    beq   $t7, $zero, bsFailEnd
bsIsDigit:
    addi  $t7, $zero, 32
    beq   $t2, $t7, bsIncr
    addi  $t7, $zero, 45
    beq   $t2, $t7, bsIncr
    slti  $t7, $t2, 48
    bne   $t7, $zero, bsFailEnd
    slti  $t7, $t2, 58
    beq   $t7, $zero, bsFailEnd       
    j     bsIncr                 
bsIsOperator:
    addi  $t7, $zero, 32
    bne   $t2, $t7, bsFailEnd          
bsIncr:
    add   $t2, $t3, $zero    
    addi  $t0, $t0, 1
    j     bsLoop
bsFailEnd:
    addi  $t4, $zero, 1    
bsEnd:
    lw    $a0, 0($sp)
    lw    $ra, 4($sp)
    addi  $sp, $sp, 8
    add   $v0, $zero, $t4
    jr    $ra
