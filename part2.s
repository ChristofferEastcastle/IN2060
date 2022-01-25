.text
.global main
.extern printf
@ Function that `main` should call
fib:
    @ Fill in the Fibonacci algorithm here
    @ ensure that input arguments and return values
    @ follows the ARM calling convetion, section `6.3.7`
    @ Also note that if you need extra registers it might
    @ be necessary to store previous state on the stack

	push {lr}
	@ Loop will do the main work calculating the Fibonacci sequence
loop:
    CMP r0, #0          @ check if r0 == 0
    BEQ exit            @ if r0 == 0, branch to exit

    MOV r3, r1          @ temporary = current
    ADD r1, r1, r2      @ current = current + prev

    MOV r2, r3          @ previous = temporary
    SUB r0, #1          @ N = N - 1

   	B loop              @ Jump to start of loop
exit:
	pop {lr}
	MOV R0, R1			@ Storing return value in R0
    BX lr

main:
	push {lr}
	@ First load the desired Fibonacci number
    MOV r0, #50 @ N
    @ Initialize the first two numbers in the sequence
    MOV r1, #0  @ current
    MOV r2, #1  @ previous
	@ Calling fib
	BL fib 
	MOV R1, R0	@ saving return value of fib in R1
	@ Calling printf
	LDR r0, =output_string
	BL printf
	pop {lr}
    @ Always return properly to caller (even from main)
	BX lr
@ The 'data' section contains static data for our program
.data
output_string:
    .asciz "%d\n"

