
bits 64
default rel



; list of all registers:
; 64-bit Register	Lower 32 bits	Lower 16 bits	Lower 8 bits
; rax			eax		ax		al
; rbx			ebx		bx		bl
; rcx			eax		cx		cl
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
%define LOOP_WIDTH 10
%define SLEEP_TIME_MS 20

segment .text
	global main
	extern ExitProcess ; WinAPI
	extern Sleep ; WinAPI
	extern printf

main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	push	0 ; push line counter onto the stack

	outer_loop:
		pop	rcx ; read line
		cmp	rcx, LOOP_WIDTH
		jg	rcx_set_zero ; jump if greater than LOOP_WIDTH
		_rcx_set_zero_return:
		inc	rcx ; increment
		push	rcx

		mov	rbx, rcx

		; print
		print_loop:
			lea	rcx, [print_message]
			call	printf
			dec	rbx ; decrement by 1
			cmp	rbx, 0 ; changes ZF (zero flag)
			jnz	print_loop ; jump if ZF is not zero

		; print end
		lea	rcx, [end_print_message] ; set the first function parameter to `end_print_message` adress
		call	printf

		; sleep
		mov	rcx, SLEEP_TIME_MS ; set `Sleep` time parameter
		call Sleep

		jmp	outer_loop

	rcx_set_zero:
		mov	rcx, 0
		jmp	_rcx_set_zero_return

_exit:
	push	rax
	call	ExitProcess


; read-only data section
segment .rodata
	print_message db "#", 0
	end_print_message db "\", NEWLINE, 0
