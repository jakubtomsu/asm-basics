
bits 64
default rel

%define NEWLINE	0xd, 0xa

segment .text
	global main
	extern ExitProcess
	extern printf

main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	lea	rcx, [message]
	call	printf

	; exit
	push	rax
	call	ExitProcess


; read-only data section
segment .rodata
	message db "hello world!", NEWLINE, 0
