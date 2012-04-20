          .data
S:        .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

          .text
main:
    addi  $s0, $zero, 4
    addi  $s1, $zero, 80
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    addi  $a0, $zero, 47   
    jal   applyOperator
    add   $s2, $v0, $zero   
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    li    $v0, 10
    syscall
    
Empty:
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    add   $t0, $zero, $zero
    bltz  $s0, eEnd
    addi  $t0, $zero, 1
eEnd:    
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t0
    jr    $ra
    
Full:
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    add   $t0, $zero, $zero
    bne   $s0, $s1, fEnd
    addi  $t0, $zero, 1
fEnd:    
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    add   $v0, $zero, $t0
    jr    $ra
         
Push:
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    addi  $s0, $s0, 4
    add   $t0, $a0, $s0
    sw    $a1, 0($t0)
    lw    $ra, 0($sp)
    addi  $sp, $sp, 4
    jr    $ra    

Pop:
    addi  $sp, $sp, -4
    sw    $ra, 0($sp)
    add   $t0, $a0, $s0
    lw    $v0, 0($t0)
    lw    $ra, 0($sp)
    addi  $s0, $s0, -4    
    addi  $sp, $sp, 4
    jr    $ra
    
applyOperator:
    addi  $sp, $sp, -8
    sw    $ra, 4($sp)
    sw    $a0, 0($sp)    
    add   $t0, $zero, $a0
    addi  $sp, $sp, -4
    sw    $t0, 0($sp)   
    la    $a0, S      
    jal   Empty
    add   $t1, $zero, $v0    
    lw    $t0, 0($sp)
    addi  $sp, $sp, 4
    beq   $t1, $zero, aoNoArgs
    addi  $sp, $sp, -4
    sw    $t0, 0($sp)   
    la    $a0, S      
    jal   Pop
    lw    $t0, 0($sp)
    addi  $sp, $sp, 4
    add   $t2, $zero, $v0
    addi  $sp, $sp, -8
    sw    $t0, 4($sp)
    sw    $t2, 0($sp)      
    la    $a0, S      
    jal   Empty
    add   $t1, $zero, $v0   
    lw    $t2, 0($sp)    
    lw    $t0, 4($sp)
    addi  $sp, $sp, 8
    beq   $t1, $zero, aoOneArgs
    addi  $sp, $sp, -8
    sw    $t0, 4($sp)
    sw    $t2, 0($sp)      
    la    $a0, S      
    jal   Pop
    add   $t3, $zero, $v0    
    lw    $t2, 0($sp)    
    lw    $t0, 4($sp)
    addi  $sp, $sp, 8
    addi  $t4, $zero, 43 
    beq   $t0, $t4, aoAdd
    addi  $t4, $zero, 45
    beq   $t0, $t4, aoSub
    addi  $t4, $zero, 42
    beq   $t0, $t4, aoMult
    addi  $t4, $zero, 47
    beq   $t0, $t4, aoDiv
aoDiv:
    beq   $t2, $zero, aoDiv
    div   $t3, $t2
    mflo  $t5
    j     aoPush    
aoMult:
    mult  $t3, $t2
    mflo  $t5
    j     aoPush                                
aoAdd:
    add   $t5, $t3, $t2
    j     aoPush
aoSub:
    sub   $t5, $t3, $t2
aoPush:
    addi  $sp, $sp, -4
    sw    $t5, 0($sp)      
    la    $a0, S
    add   $a1, $zero, $t5      
    jal   Push
    addi $v0, $zero, 0    
    lw    $t5, 0($sp)    
    addi  $sp, $sp, 4
    j    aoEnd 
aoDiv0:
    addi $v0, $zero, 3
    j    aoEnd      
aoOneArgs:
    addi $v0, $zero, 2
    j    aoEnd           
aoNoArgs:
    addi $v0, $zero, 1  
    j    aoEnd    
aoEnd:        
    lw    $a0, 0($sp)    
    lw    $ra, 4($sp)    
    addi  $sp, $sp, 8
    jr    $ra                   
    
