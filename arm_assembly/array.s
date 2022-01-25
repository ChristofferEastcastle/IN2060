.text
.global main
.extern printf
array:

main:
	push {lr}
	ldr r0, =array
	mov r1, #100
loop:
	
	str r1, [r0, r1, lsl #2]
	subs r1, #1
	bgt loop
	exit:
	mov r1, #100
	
loop2:
	beq done
	push {r0, r1, r2} 
	ldr r0, [r0, r1, lsl #2]
	ldr r1, =string
	bl printf
	pop {r0, r1, r2}
	b loop
	done:
	pop {lr}
	bx lr

.data
	string: .asciz "%d\n"