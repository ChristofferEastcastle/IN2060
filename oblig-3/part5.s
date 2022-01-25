.text
.global main
.extern printf

expo_mask:	.word 0b01111111100000000000000000000000
deci_mask:	.word 0b00000000011111111111111111111111
lead_one:	.word 0b00000000100000000000000000000000
norm_value:	.word 0b00000001000000000000000000000000

@num1:		.word 0x3F800000
@num2:		.word 0x3F800000
@num1:		.word 0x40000000
@num2: 		.word 0x3F800000
@num1: 		.word 0x40400000
@num2: 		.word 0x40600000
num1: 		.word 0x40000000
num2: 		.word 0x3f010000


main:
	push {lr}
	ldr r0, =num1
	ldr r0, [r0]
	bl get_exponent
	mov r4, r0
	ldr r1, =num2
	ldr r1, [r1]
	mov r0, r1
	bl get_exponent
	mov r6, r0
	
	@ exponents are saved in r4 and r6
	
	ldr r0, =num1
	ldr r0, [r0]
	mov r2, r4
	bl get_decimal
	mov r5, r0

	ldr r1, =num2
	ldr r1, [r1]
	mov r0, r1
	mov r2, r6
	bl get_decimal
	mov r7, r0
	
	@ decimal are saved in r5 and r7
	
	bl move_difference
	mov r8, r0 @ storing largest exponent in r8
	
	
	mov r1, r5
	mov r2, r7
	bl sum @ Adding decimals
	
	ldr r1, =norm_value
	ldr r1, [r1]
	and r2, r0, r1
	
	cmp r1, r2	@ checking if needing to normalize
	
	bne combine	
	lsr r0, r0, #1
	add r8, r8, #1
	
	combine:
	lsl r8, r8, #23 @ moving exponent bits back in correct position
	
	ldr r1, =lead_one
	ldr r1, [r1]
	
	eor r0, r0, r1 @ removing leading one and combine exponent and decimal
	orr r0, r0, r8
	
	bl printBinary
	pop {lr}
	bx lr

sum:
	push {lr}
	add r0, r1, r2
	
	pop {lr}
	bx lr

move_difference:
	push {lr}
	cmp r4, r6
	
	suble r0, r6, r4
	subgt r0, r4, r6
	
	bge move_2
	lsr r5, r5, r0
	mov r0, r6
	b end
	
	move_2:
	lsr r7, r7, r0
	mov r0, r4
	
	end:
	pop {lr}
	bx lr
get_exponent:
	push {lr}
	
	ldr r1, =expo_mask
	ldr r1, [r1]
	and r0, r0, r1
	lsr r0, r0, #23
	pop {lr}
	bx lr

get_decimal:
	push {lr}
	
	ldr r1, =deci_mask
	ldr r1, [r1]
	and r0, r0, r1
	cmp r2, #0
	
	beq exit
	ldr r2, =lead_one
	ldr r2, [r2]
	orr r0, r0, r2

	exit:
	pop {lr}
	bx lr

printBinary:
	push {lr}
	mov r5, r0
    mov r6, #0
        start:
			and r1, r5, #2147483648
			lsr r1, r1, #31
			ldr r0, =printf2
			bl printf
			lsl r5, r5, #1
			add r6, r6, #1
			cmp r6, #32
			blt start
			ldr r0, =printf3
			bl printf
			pop {lr}
			bx lr

printf2: .asciz "%d"
printf3: .asciz "\n"
