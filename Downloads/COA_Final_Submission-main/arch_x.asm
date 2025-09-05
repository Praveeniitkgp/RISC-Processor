# Initialize
LOAD R1, 0(R0)         62000000    # Load multiplicand into R1
LOAD R2, 1(R0)         64000010             # Load multiplier into R2
MOVE R3, R0            A6000000   # Clear accumulator (R3 = 0)
MOVE R4, R2            A8400000   # Copy multiplier to R4 (lower product bits)
MOVE R5, R0            AA000000  # Initialize Q-1 to 0
ADDRI R6, R0, 32       2C000200  # Set loop counter to 32 for 32-bit multiplication

# Booth's Algorithm Loop
LOOP: 
    ANDRI R7, R4, 1      2E800012  # Check Q0 (least significant bit of R4)
    XOR R7, R7, R5       0EEA0004  # Compare Q0 and Q-1 (R7 = Q0 ^ Q-1)
    BZ R7 SKIP_ADD       8E000113   # If R7 == 0, skip addition

    # Perform subtraction or addition based on Q0 and Q-1
    BZ R5, SUBTRACT        8A000033   # If Q0 = 0, Q-1 = 1, do R3 = R3 - R1
    ADD R3, R3, R1         06620000  # Else, R3 = R3 + R1
    BR SHIFT               80000020

SUBTRACT:
    SUB R3, R3, R1        06620001 

# Arithmetic Right Shift R3, R4, R5
SHIFT:
    ADDRI R10, R0, 1       34000010     # Get the value 1 in R10
    AND R10, R10, R4       15480002  # Get the LSB of R4 in R10
    MOVE R5, R10           AB400000  # Store it in R10 

    ADDRI R10, R0, 1       34000010   # Get the value 1 
    AND R10, R10, R3        15460002   # Get the LSB of R3 in R10
    SLRI R10, R10, 31     354001F7   # Shift it by 31 Position to Right
    SRLRI R4, R4, 1      28800018  # Shift R4 by 1 Position to Right
    OR R4, R4, R10      08940003    # Or and Store it in R4

    SRARI R3, R3, 1       26600019    # Shift accumulator right by 1
    
    # Decrement loop counter
    SUBRI R6, R6, 1         2CC00011    # R6 = R6 - 1
    BPL R6, LOOP          8CFFFEF2      # If loop counter > 0, repeat

# End of Booth's Algorithm
HALT  C0000000

SKIP_ADD:
    BR SHIFT          80FFFF40   # Skip addition and proceed to shift
