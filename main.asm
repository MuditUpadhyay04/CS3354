# main.asm
.include "SysCalls.asm"

.data
    welcomeMsg: .asciiz "\n=== Math Match Game ===\n\n"
    newGameMsg: .asciiz "\n1. Start New Game\n2. Exit\nChoice: "
    timeMsg: .asciiz "\nTime: "
    remainingMsg: .asciiz "\nCards Remaining: "
    winMsg: .asciiz "\n\nWell Done! You finished in "
    minutesMsg: .asciiz " minutes and "
    secondsMsg: .asciiz " seconds!\n"
    pressEnterMsg: .asciiz "\nPress Enter to continue..."

.data
.globl boardState
.globl cardValues
.globl firstChoice
.globl secondChoice
.globl matchesFound
.globl startTime
.globl currentTime
    boardState: .word 0:16  # Array to store card states (0=hidden, 1=revealed)
    cardValues: .word 0:16  # Array to store multiplication values
    firstChoice: .word -1   # Store first card selection
    secondChoice: .word -1  # Store second card selection
    matchesFound: .word 0   # Counter for matches found
    startTime: .word 0      # Store game start time
    currentTime: .word 0    # Store current time
    buffer: .space 2        # Buffer for Enter key press

.text
.globl main
main:
    # Print welcome message
    li $v0, 4
    la $a0, welcomeMsg
    syscall

game_menu:
    # Display menu
    li $v0, 4
    la $a0, newGameMsg
    syscall
    
    # Get user choice
    li $v0, 5
    syscall
    
    # Menu logic
    beq $v0, 1, start_game
    beq $v0, 2, exit_game
    j game_menu

start_game:
    # Initialize game state
    sw $zero, matchesFound
    li $t0, -1
    sw $t0, firstChoice
    sw $t0, secondChoice
    
    # Initialize game board (this will also initialize the timer now)
    jal init_board
    
game_loop:
    # Display game state
    jal display_board
    jal display_stats
    
    # Get player move
    jal get_player_move
    
    # Check if game is won
    lw $t0, matchesFound
    beq $t0, 8, display_win_screen  # 8 matches = 16 cards
    
    j game_loop



display_win_screen:
    # Display win message
    li $v0, 4
    la $a0, winMsg
    syscall
    
    # Calculate total time
    jal get_system_time
    lw $t0, startTime
    sub $t0, $v0, $t0   # Get elapsed time in milliseconds
    
    # Convert to seconds
    div $t0, $t0, 1000
    
    # Calculate minutes and seconds
    div $t0, $t0, 60
    mflo $t1  # Minutes in $t1
    mfhi $t2  # Seconds in $t2
    
    # Display minutes
    move $a0, $t1
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, minutesMsg
    syscall
    
    # Display seconds
    move $a0, $t2
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, secondsMsg
    syscall
    
    # Wait for Enter key
    li $v0, 4
    la $a0, pressEnterMsg
    syscall
    
    # Read Enter key
    li $v0, 8
    la $a0, buffer
    li $a1, 2
    syscall
    
    j game_menu

exit_game:
    li $v0, 10
    syscall

# Get current system time
get_system_time:
    li $v0, 30
    syscall
    jr $ra

# Display time elapsed and cards remaining
display_stats:
    # Save registers
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    
    # Display remaining cards
    li $v0, 4
    la $a0, remainingMsg
    syscall
    
    li $t0, 16
    lw $t1, matchesFound
    sll $t1, $t1, 1
    sub $t0, $t0, $t1
    
    li $v0, 1
    move $a0, $t0
    syscall
    
    # Display time
    li $v0, 4
    la $a0, timeMsg
    syscall
    
    # Calculate elapsed time
    jal get_system_time
    lw $t0, startTime
    sub $t0, $v0, $t0
    
    # Convert to seconds
    div $t0, $t0, 1000
    
    # Display minutes and seconds
    div $t0, $t0, 60
    mflo $a0  # Minutes
    li $v0, 1
    syscall
    
    li $v0, 11
    li $a0, ':'
    syscall
    
    mfhi $a0  # Seconds
    li $v0, 1
    syscall
    
    # Restore registers and return
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    addi $sp, $sp, 8
    jr $ra

.include "init_board.asm"
.include "board.asm"
.include "game_logic.asm"
.include "input.asm"