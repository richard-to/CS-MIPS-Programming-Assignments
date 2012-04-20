          .data
EXPR:     .asciiz "7998"

          .text
main:
    la    $a0, EXPR
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    jal   getNumber
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $s0, $v0, $zero
    li    $v0, 10
    syscall
    
getNumber:
    addi  $sp, $sp, -8
    sw    $ra, 4($sp)
    sw    $a0, 0($sp)
    add   $t0, $a0, $zero
    add   $t1, $zero, $zero
    addi  $t4, $zero, 10
gnLoop:
    lb    $t2, 0($t0)
    beq   $t2, $zero, gnEnd
    mult  $t1, $t4
    mflo  $t1
    addi  $t3, $t2, -48
    add   $t1, $t1, $t3
    addi  $t0, $t0, 1
    j     gnLoop    
gnEnd:
    lw    $a0, 0($sp)
    lw    $ra, 4($sp)
    addi  $sp, $sp, 8
    add   $v0, $zero, $t1
    jr    $ra        
