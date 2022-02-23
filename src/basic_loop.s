
bits 64
default rel



; list of all registers:
; 64-bit Register	Lower 32 bits	Lower 16 bits	Lower 8 bits
; rax			eax		ax		al
; rbx			ebx		bx		bl
; rcx			ecx		cx		cl
; rdx			edx		dx		dl
; rsi			esi		si		sil
; rdi			edi		di		dil
; rbp			ebp		bp		bpl // frame pointer
; rsp			esp		sp		spl
; r8			r8d		r8w		r8b
; r9			r9d		r9w		r9b
; r10			r10d		r10w		r10b
; r11			r11d		r11w		r11b
; r12			r12d		r12w		r12b
; r13			r13d		r13w		r13b
; r14			r14d		r14w		r14b
; r15			r15d		r15w		r15b



%define NEWLINE	0xd, 0xa


segment .text
	global main
	extern ExitProcess
	extern printf



main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	mov	ebx, 32 ; message counter, now set to default message count
	print_loop:
		; print message
		lea	rcx, [message]
		call	printf
		; go to start of the loop if counter isn't zero
		sub	ebx, 1 ; subtract
		cmp	ebx, 0 ; changes ZF (zero flag)
		jnz	print_loop ; jump if ZF is zero

	; exit program
	push	rax
	call	ExitProcess



; read-only data section
segment .rodata
	message db "hello loop!", 0xd, 0xa, 0
