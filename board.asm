# board.asm
.data
    newline: .asciiz "\n"
    horizontal: .asciiz "+-----------------+\n"
    vertical: .asciiz "|"
    space: .asciiz " "
    hidden: .asciiz "?"

.text
# Remove the .globl declarations since they're in globals.asm now
# Just start with your display_board procedure
display_board:
    # Save registers
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    
    # Print top border
    li $v0, 4
    la $a0, horizontal
    syscall
    
    # Initialize counters
    li $s0, 0  # Row counter
    li $s1, 0  # Column counter
    
display_row:
    # Print vertical border
    li $v0, 4
    la $a0, vertical
    syscall
    
    # Print row content
    li $s1, 0  # Reset column counter
    
display_col:
    # Print space
    li $v0, 4
    la $a0, space
    syscall
    
    # Calculate array index
    mul $t0, $s0, 4    # Row * 4
    add $t0, $t0, $s1  # + Column
    
    # Load card state
    la $t1, boardState
    sll $t2, $t0, 2    # Multiply by 4 for word alignment
    add $t1, $t1, $t2
    lw $t3, ($t1)
    
    # If card is hidden, show "?"
    beqz $t3, print_hidden
    
    # Check if we have an equation for this position
    la $t1, equation_ptrs
    add $t1, $t1, $t2
    lw $t4, ($t1)      # Load equation pointer
    
    # If equation pointer is null, show number
    beqz $t4, print_number
    
    # Print equation
    li $v0, 4
    move $a0, $t4
    syscall
    j continue_display
    
print_number:
    # Load and print card value
    la $t1, cardValues
    add $t1, $t1, $t2
    lw $a0, ($t1)
    li $v0, 1
    syscall
    j continue_display
    
print_hidden:
    li $v0, 4
    la $a0, hidden
    syscall

    
continue_display:
    # Print space
    li $v0, 4
    la $a0, space
    syscall
    
    # Increment column counter
    addi $s1, $s1, 1
    blt $s1, 4, display_col
    
    # Print vertical border and newline
    li $v0, 4
    la $a0, vertical
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    # Increment row counter
    addi $s0, $s0, 1
    blt $s0, 4, display_row
    
    # Print bottom border
    li $v0, 4
    la $a0, horizontal
    syscall
    
    # Restore registers and return
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra