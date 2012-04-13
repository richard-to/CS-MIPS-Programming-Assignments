            .data
EXPR:       .asciiz "-12 -54 * 78 as 360 343 - 20 /\n"

            .text
main:
    la   $a0, EXPR
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    jal  stackUnderflow
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    add  $s0, $v0, $zero
    li   $v0, 10
    syscall
    
stackUnderflow:
