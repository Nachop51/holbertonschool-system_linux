BITS 64

  global print_alphabet

  section .text


print_alphabet:

  push rbp
  mov rsp, rbp

              ; Save registers that are gonna be used in this
  push rsi		; procedure, in case they were used before
	push rax
	push rdi
	push rdx

  add rsp, -1		      ; Increase the stack by 1 byte to store a char
	mov byte [rsp], 61h	; Store the ascii value of 'a'

  ; mov cl, 0
  ; mov ax, 41h

  ; Setup 'write' syscall
	mov rax, 1		  ; Write syscall
	mov rdi, 1		  ; write to stdout
	mov rdx, 1		  ; Write 1 byte
	mov rsi, rsp		; Address of the character to be printed (Address of the stack)

  alphabet:
    syscall
    inc byte [rsp]
    cmp byte [rsp], 122	; Compare the value our char to 'z'
	  jle alphabet	; Jump to loop only if our char is lower or equal to 'z'

  mov byte [rsp], 0Ah
  syscall
  add rsp, 1		; Discard our local variable
	pop rdx			  ; Restore used registers
	pop rdi
	pop rax
	pop rsi

	mov rsp, rbp		; Restore previous stack frame
	pop rbp			    ; Those two lines are equivalent to 'leave'

	ret			;
