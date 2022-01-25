.global main

.extern printf

main:
mov r0, #-4
mov r1, #7

cmp r0, #1

addle r0, #1
lslgt r1, #1
push {r0, r1, lr}
ldr r0, =string
bl printf
pop {r0, r1}
mov r1, r0

ldr r0, =string
bl printf
pop {lr}
bx lr


.data
	string: .asciz "%d\n"
