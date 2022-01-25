.text
.global main
.extern printf

main:
	push {lr}
	MOV r1, #0x39
	MOV r2, #0xAC
	AND r0, r1, r2
	bl printBinary
	pop {lr}
	BX LR
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

