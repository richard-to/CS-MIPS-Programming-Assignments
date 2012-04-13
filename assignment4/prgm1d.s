                  .data
INPUT_PROMPT:     .asciiz "Enter a postfix expression: "
CONTINUE_PROMPT:  .asciiz "Enter another postfix expression? (Y/n): "
BAD_SYNTAX:       .asciiz "Error: Bad Syntax.\n"
STACK_UNDERFLOW:  .asciiz "Error: Stack Underflow.\n"
TOO_MANY_OPS:     .asciiz "Error: Too many operands.\n" 
CONTINUE:         .space 80
INPUT:            .space 80

                  .text
main:
    la  $a0, INPUT_PROMPT
    jal putString
    la  $a0, INPUT
    jal getString    
    li      $v0, 10                        
    syscall    

putString:
    li      $v0, 4                         
    syscall
    jr       $ra

getString:
    addi    $a1, $zero, 80                         
    li      $v0, 8                         
    syscall
    jr      $ra
       
