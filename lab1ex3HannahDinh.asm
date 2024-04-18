.data
array: .word     67,72,74,76,76,        76,74,76,72,72,       72,74,76,77,81,       81,79,77,76,      72,74,76,77,81,       81,79,77,76,72,      67,72,74,76,76,77,74,74,76,72
durations: .word 400,400,400,800,1000, 400,400,400,800,1000, 400,400,400,800,1000, 400,400,400,1600, 400,400,400,800,1000, 400,400,400,800,1000, 400,400,400,800,400,400,800,400,400,1600

.text
main:
    li $s1, 0  # Initialize the index to 0

music:
    lw $t1, array($s1)  # Load pitch of current note into $t1
    lw $t2, durations($s1)  # Load duration of current note into $t2
    
    # Play note
    li $v0, 31  # Audio out syscall
    addi $a0, $t1, 0  # Set pitch (from $t1)
    addi $a1, $t2, 0  # Set duration (from $t2)
    la $a2, 0  # Piano
    la $a3, 100  # Volume (100)
    syscall
    
    # add delay equal to the duration of the note
    li $v0, 32  # Syscall delay
    addi $a0, $t2, 0  # Set delay duration (from $t2)
    syscall

    # Move to thenext note
    addi $s1, $s1, 4  # Increment index by 4 (next word)
    
    # Check if within array
    bgt $s1, 200, exit  # If index > 92, exit program
    j music  # jump back to music label (loop it)

exit:
    # End program