.data
    debugStartTimeMsg: .asciiz "\nStart Time: "
    debugCurrentTimeMsg: .asciiz "\nCurrent Time: "

.text
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
    
    # Get current time
    li $v0, 30
    syscall            # Time in milliseconds in $a0

    # Calculate elapsed time
    lw $t0, startTime
    subu $t1, $a0, $t0     # Time difference
    
    # Handle wraparound (if time goes negative)
    bltz $t1, wraparound_handler
    j continue_time_calc

wraparound_handler:
    # Adjust for wraparound: calculate (0xFFFFFFFF - startTime) + currentTime + 1
    li $t2, 0xFFFFFFFF
    subu $t1, $t2, $t0   # (0xFFFFFFFF - startTime)
    addu $t1, $t1, $a0    # Add currentTime
    addu $t1, $t1, 1      # Account for the +1 on wraparound

continue_time_calc:
    # Convert to seconds
    li $t2, 1000
    divu $t1, $t2         # Dividing by 1000 to convert ms to seconds
    mflo $t1              # Result is in seconds
    
    # Limit to 1 hour (3600 seconds max)
    li $t3, 3600
    bltu $t1, $t3, calculate_display
    li $t1, 3600           # Cap to 1 hour if greater
    
calculate_display:
    # Calculate minutes and seconds
    li $t2, 60
    divu $t1, $t2
    mflo $a0              # Minutes in $a0
    mfhi $s1              # Seconds in $s1

    # Print minutes
    li $v0, 1
    syscall

    # Print colon
    li $v0, 11
    li $a0, 58            # ASCII for ':'
    syscall

    # Print seconds
    li $v0, 1
    move $a0, $s1
    syscall
    
    # Restore registers and return
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    addi $sp, $sp, 8
    jr $ra


init_timer:
    li $v0, 30
    syscall
    sw $a0, startTime
    jr $ra