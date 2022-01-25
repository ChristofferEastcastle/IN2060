.text
.global main
.extern printf

@ Main function of program
main:
    @ First load the desired Fibonacci number
    MOV r0, #20 @ N
    @ Initialize the first two numbers in the sequence
    MOV r1, #0  @ current
    MOV r2, #1  @ previous

@ Loop will do the main work calculating the Fibonacci sequence
loop:
    CMP r0, #0		@ check if r0 == 0
    BEQ exit		@ if r0 == 0, branch to exit

    MOV r3, r1		@ temporary = current
    ADD r1, r1, r2	@ current = current + prev

    MOV r2, r3		@ previous = temporary
    SUB r0, #1		@ N = N - 1

    B loop		@ Jump to start of loop
    
@ To be a good citizen we branch (and exchange) on the lr register
@ to return to the caller
exit:
	B print_num
    BX lr																	

print_num:
	push {ip, lr}
	LDR r0, =string
	BL printf
	pop {ip, pc}

.data
string: .asciz "The Fibonacci of N: %d\n"
