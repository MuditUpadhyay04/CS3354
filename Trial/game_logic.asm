


# game_logic.asm
.data
    matchMsg: .asciiz "\nMatch found!"
    noMatchMsg: .asciiz "\nNo match. Try again!"
    pauseTime: .word 1000  # Pause time in milliseconds
    multiply: .asciiz "x"  # Multiplication symbol

# Add these to store equation strings
.data
    .align 2
    equation_buffer: .space 400  # Buffer for storing equation strings
    equation_ptrs: .word 0:16    # Array to store pointers to equations

.text

# Check if the two selected cards match
check_match:
    # Save return address
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Load card indices
    lw $t0, firstChoice
    lw $t1, secondChoice
    
    # Load card values
    la $t2, cardValues
    sll $t3, $t0, 2    # Multiply first index by 4
    sll $t4, $t1, 2    # Multiply second index by 4
    add $t3, $t2, $t3  # Address of first card value
    add $t4, $t2, $t4  # Address of second card value
    lw $t5, ($t3)      # Value of first card
    lw $t6, ($t4)      # Value of second card
    
    # Compare values
    bne $t5, $t6, no_match
    
    # Match found
    li $v0, 4
    la $a0, matchMsg
    syscall
    
    # Increment matches found
    lw $t0, matchesFound
    addi $t0, $t0, 1
    sw $t0, matchesFound
    
    # Add delay for visibility
    li $v0, 32         # Sleep syscall
    lw $a0, pauseTime
    syscall
    
    j check_match_end
    
no_match:
    # Display no match message
    li $v0, 4
    la $a0, noMatchMsg
    syscall
    
    # Add delay for visibility
    li $v0, 32         # Sleep syscall
    lw $a0, pauseTime
    syscall
    
    # Hide cards again
    lw $t0, firstChoice
    lw $t1, secondChoice
    
    la $t2, boardState
    sll $t3, $t0, 2
    sll $t4, $t1, 2
    add $t3, $t2, $t3
    add $t4, $t2, $t4
    
    sw $zero, ($t3)    # Hide first card
    sw $zero, ($t4)    # Hide second card
    
check_match_end:
    # Return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
# Generate multiplication problems with equations
generate_problems:
    # Save registers
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    
    # Initialize array pointers
    la $s0, cardValues     # For storing actual values
    la $s1, equation_ptrs  # For storing equation pointers
    la $s2, equation_buffer # Current position in equation buffer
    li $s3, 0              # Counter for pairs
    
generate_loop:
    # Generate two random numbers 1-9
    li $v0, 42
    li $a1, 9
    syscall
    addi $t0, $a0, 1  # First number
    
    li $v0, 42
    li $a1, 9
    syscall
    addi $t1, $a0, 1  # Second number
    
    # Calculate product
    mul $t2, $t0, $t1
    
    # Store the first pair: equation
    # Create equation string like "5x3"
    move $t3, $s2           # Current buffer position
    
    # Store first number as string
    addi $t4, $t0, 48      # Convert to ASCII
    sb $t4, ($t3)          # Store digit
    addi $t3, $t3, 1
    
    # Store 'x' character
    li $t4, 120            # ASCII for 'x'
    sb $t4, ($t3)
    addi $t3, $t3, 1
    
    # Store second number as string
    addi $t4, $t1, 48      # Convert to ASCII
    sb $t4, ($t3)
    addi $t3, $t3, 1
    
    # Null terminate the string
    sb $zero, ($t3)
    addi $t3, $t3, 1
    
    # Store pointer to equation string
    sw $s2, ($s1)          # Store pointer in equation_ptrs
    addi $s1, $s1, 4
    move $s2, $t3          # Update buffer position
    
    # Store result value for this pair
    sw $t2, ($s0)
    addi $s0, $s0, 4
    
    # Store the second pair: result
    sw $t2, ($s0)          # Store the numerical result
    addi $s0, $s0, 4
    
    # Store null for the equation pointer (indicates show number)
    sw $zero, ($s1)
    addi $s1, $s1, 4
    
    # Increment counter and check if done
    addi $s3, $s3, 1
    blt $s3, 8, generate_loop
    
    # Shuffle both arrays
    jal shuffle_arrays
    
    # Restore registers and return
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    addi $sp, $sp, 20
    jr $ra

# Shuffle both arrays (cardValues and equation_ptrs)
shuffle_arrays:
    # Save registers
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    
    la $s0, cardValues
    la $s1, equation_ptrs
    li $s2, 16  # Array size
    
shuffle_loop:
    # Generate random index
    li $v0, 42
    move $a1, $s2
    syscall
    
    # Calculate addresses
    sll $t0, $a0, 2    # Random index * 4
    sll $t1, $s2, 2    # Current index * 4
    addi $t1, $t1, -4  # Adjust for 0-based indexing
    
    # Swap cardValues elements
    add $t2, $s0, $t0  # Address of random element
    add $t3, $s0, $t1  # Address of current element
    lw $t4, ($t2)
    lw $t5, ($t3)
    sw $t4, ($t3)
    sw $t5, ($t2)
    
    # Swap equation_ptrs elements
    add $t2, $s1, $t0  # Address of random element
    add $t3, $s1, $t1  # Address of current element
    lw $t4, ($t2)
    lw $t5, ($t3)
    sw $t4, ($t3)
    sw $t5, ($t2)
    
    # Decrement counter
    addi $s2, $s2, -1
    bgtz $s2, shuffle_loop
    
    # Restore registers and return
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addi $sp, $sp, 16
    jr $ra
