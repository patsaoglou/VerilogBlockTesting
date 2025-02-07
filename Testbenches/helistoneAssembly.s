0    load r0, n       // Load initial value of n into r0
1    load r2, 1       // Load constant 1 into r2
2    load r4, 2       // used for logical shift

loop:
3    move r1, r0      // Copy r0 to r1
3    move r15, r0     // Copy r0 to r1
4    sub r1, r1, r2   // r1 = r1 - 1
5    bnz r1, 7        // If r1 is zero, exit the loop (n == 1)
6    bnz r2, 15 	
7    and r3, r0, r2   // r3 = r0 AND r2 (check if odd)
8   bnz r3, 10        // If r3 != 0, n is odd

even_case:
8    lsr r0, r0, r4   // r0 = r0 / 2 (n is even)
9    bnz r2, 3        // Branch back to the loop unconditionally

odd_case:
10  move r5, r0
11  add r0, r0, r5    // r0 = r0 + r0
12  add r0, r0, r5    // r0 = 2r0 + r0 (epi tria)
    
13  add r0, r0, r2    // r0 = r0 + 1 (3n + 1)
14  bnz r2, 3         // Branch back to the loop unconditionally

loop_end:
15    halt            // Exit the program
