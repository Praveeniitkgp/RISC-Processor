    MOVE    R1, R0        a2000000        1010 0010 0000 000 0 3(0000) 0000     // R1 = 0 (Outer loop counter i = 0)
    MOVE    R10, R0       b4000000        1011 0100 000 0000 0 3(0000) 0000

Outer_Loop:
    ADDRI    R1, R1, #1    22200010       0010 0010 0010 3(0000) 0001 0000// i++
    SUBRI    R5, R1, #10   2a2000a1        0010 1010 0010 3(0000) 1010 0001       // R5 = i - 10
    BZ      R5, End        8a0000e3        1000 1010 _0000 0000 0000 0000 1110___ 0011// If i >= 10, exit loop

    LD      R2, 0(R1)      64200000       0110 0100 0010 4(0000) 0000// Load Current = Array[i] into R2
    SUBRI    R3, R1, #1    26200011       0010 0110 0010 3(0000) 0001 0001// R3 = i - 1 (Inner loop counter j = i - 1)
    MOVE    R6, R2         ac400000       1010 1100 0100 0000 3(0000) 0000// Temporary store of current number in R6

Inner_Loop:
    LD      R4, 0(R3)       68600000       0110 1000 0110 4(0000) 0000// Load Array[j] into R4
    SUB     R8, R4, R6      108c0001       0001 0000 1000 1100 3(0000) 0001// Compare Array[j] - Current
    BMI     R8, Found_Pos   90000061       1001 0000 _0000 0000 0000 _0000 0110______  0001// If Array[j] <= Current, position found
    BZ      R8, Found_Pos   90000053       1001 0000 _0000 0000 0000 _0000 0101_______  0011

    //First you swap the Numbers
    ST      R4,1(R3)        68600011       0110 1000 011 3(0000) 0001 0001

    SUBRI     R3,R3,1        26600011      0010 0110 0110 3(0000) 0001 0001
    BMI       R3, Found_Pos   86000021    1000 0110 _0000 0000 0000 0000 0010_______  0001

    BR      Inner_Loop      80ffff90      1000 0000 _1111 1111 1111 1111 1001_______  0000

Found_Pos:       
    ST      R6, 1(R3)      6c600011        0110 1100 0110 3(0000) 0001 0001// Insert current at Array[j + 1]

    BR      Outer_Loop     80ffff10        1000 0000 _1111 1111 1111 1111 0001_______ 0000// Continue outer loop

End:
    MOVE    R1,R0        a2000000          1010 0010 0000 000 0 3(0000) 0000

Display_Loop:
    SUBRI   R5, R1, #10     2a2000a1       0010 1010 0010 3(0000) 1010  0001// R5 = i - 10
    BZ      R5, End        8affffe3        1000 1010 _1111 1111 1111 1111 1110_______ 0011 // If i >= 10, exit loop

    LD      R10, 0(R1)    74200000         0111 0100 0010  4(0000) 0000// Load Array[i] into R2

    ADDRI    R1, R1, #1    22200010        0010 0010 0010 3(0000) 0001 0000// i++
    BR      Display_Loop   80ffffc0       1000 0000 _1111 1111 1111 1111 1100___ 0000// Repeat display loop







memory_initialization_radix=16;
memory_initialization_vector=
a2000000 
b4000000 
22200010 
2a2000a1 
8a0000e3 
64200000 
26200011 
ac400000 
68600000 
108c0001 
90000061 
90000053 
68600011 
26600011 
86000021 
80ffff90 
6c600011 
80ffff10 
a2000000 
2a2000a1 
8affffe3 
74200000 
22200010 
80ffffc0;
