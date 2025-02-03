# input.asm
.data
    promptMsg: .asciiz "\nEnter card number (1-16): "
    invalidMsg: .asciiz "\nInvalid input. Please try again."
    alreadyRevealedMsg: .asciiz "\nThat card is already revealed. Try another."
    sameCardMsg: .asciiz "\nYou can't select the same card twice. Try another."

.text
# Get and validate player move
get_player_move:
    # Save return address
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
get_first_card:
    # Prompt for first card
    li $v0, 4
    la $a0, promptMsg
    syscall
    
    # Get input
    li $v0, 5
    syscall
    move $t0, $v0  # Save input in $t0
    
    # Validate input (1-16)
    li $t1, 1
    li $t2, 16
    blt $t0, $t1, invalid_input
    bgt $t0, $t2, invalid_input
    
    # Convert to 0-based index
    addi $t0, $t0, -1
    
    # Check if card is already revealed
    la $t1, boardState
    sll $t2, $t0, 2
    add $t1, $t1, $t2
    lw $t3, ($t1)
    bnez $t3, already_revealed
    
    # Store first choice
    sw $t0, firstChoice
    
    # Reveal card
    li $t3, 1
    sw $t3, ($t1)
    
    # Display updated board
    jal display_board
    
get_second_card:
    # Prompt for second card
    li $v0, 4
    la $a0, promptMsg
    syscall
    
    # Get input
    li $v0, 5
    syscall
    move $t0, $v0  # Save input in $t0
    
    # Validate input (1-16)
    li $t1, 1
    li $t2, 16
    blt $t0, $t1, invalid_input_second
    bgt $t0, $t2, invalid_input_second
    
    # Convert to 0-based index
    addi $t0, $t0, -1
    
    # Check if same as first card
    lw $t1, firstChoice
    beq $t0, $t1, same_card
    
    # Check if card is already revealed
    la $t1, boardState
    sll $t2, $t0, 2
    add $t1, $t1, $t2
    lw $t3, ($t1)
    bnez $t3, already_revealed_second
    
    # Store second choice
    sw $t0, secondChoice
    
    # Reveal card
    li $t3, 1
    sw $t3, ($t1)
    
    # Display updated board
    jal display_board
    
    # Check for match
    jal check_match
    
    # Reset choices
    li $t0, -1
    sw $t0, firstChoice
    sw $t0, secondChoice
    
    # Return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

invalid_input:
    li $v0, 4
    la $a0, invalidMsg
    syscall
    j get_first_card

invalid_input_second:
    li $v0, 4
    la $a0, invalidMsg
    syscall
    j get_second_card

already_revealed:
    li $v0, 4
    la $a0, alreadyRevealedMsg
    syscall
    j get_first_card

already_revealed_second:
    li $v0, 4
    la $a0, alreadyRevealedMsg
    syscall
    j get_second_card

same_card:
    li $v0, 4
    la $a0, sameCardMsg
    syscall
    j get_second_card