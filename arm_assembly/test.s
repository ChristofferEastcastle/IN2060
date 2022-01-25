.text
.global main

.extern printf

main:
	
	mov r2, #0
	mov r0, sp
  for:
	cmp r2, #10
	
	beq printArr
	str r2, [-r0], r2, lsr #2	
	add r2, r2, #1
	b for
	
	
exit:
	pop {lr}
	bx lr


printArr:
	mov r2, #0
	
  print_for:
	cmp r2, #10
	beq exit
	push {lr}
	ldr r0, =string
	ldr r1, [sp, r2]
	add r2, r2, #1
	bl printf
	pop {lr}
	b print_for
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


.data
	string: .asciz "%d\n"
	arr: