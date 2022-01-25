@ The two numbers 
.text
.global main
.extern printf
main:
push {ip, lr}
ldr r0, =string
ldr r1, [=num1]
bl printf																											
pop {ip, pc}
.data																												
string: .asciz "The number is: %d\n"

num1:   .word   0x3f800000
num2:   .word   0x3f800000

