.text
.global main

main:
	mov r0, #0
  for:
	cmp r0, #11
	beq print
	ldr r1, =arr
	lsl r2, r0, #2
	add r2, r1, r2
	str r0, [r2]
	add r0, r0, #1
	b for
	
  print:
	mov r0, #0
	
  print_for:
	cmp r0, #11
	beq exit
	ldr r3, =arr
	lsl r2, r0, #2
	add r2, r3, r2
	ldr r2, [r2]
	push {r0, lr}
	mov r1, r2
	ldr r0, =string
	bl printf
	pop {r0, lr}
	add r0, r0, #1
	b print_for
	
	exit:
	bx lr

.data
string: .asciz "%d\n"

.balign 4
arr:	.skip 40
