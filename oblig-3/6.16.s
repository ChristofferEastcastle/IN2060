.text
.global main
.extern printf

main:
	push {lr}
	MOV R1, #0x00
	MOV R2, #0x00

	ORR R1, R1, R2
	MVN R1, R1
@	LDR R0,=string

	

@	push {ip, lr}
@	BL printf
@	pop {ip, pc}
	MOV R0, R1
	BL printBinary

	pop {lr}
	BX lr
	
	
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
