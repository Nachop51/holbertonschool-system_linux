BITS 64

  global asm_strstr

  ; char *asm_strstr(const char *haystack, const char *needle);

  section .text

asm_strstr:
  ; prologue
  push rbp
  mov rbp, rsp

  push r8
  push r9
  push r10

  mov r8, 0     ; set first iterator to 0
  mov r10, 0

  ; Check if the parameters are null

  null_checks:
    mov al, byte [rdi]
    cmp al, byte [rsi]
    je found
    cmp rdi, 0
    je not_found
    cmp byte [rdi], 0h
    je not_found
    cmp rsi, 0
    je not_found
    cmp byte [rsi], 0h
    je found

  strstr:
    mov r10, r8   ; Last position of first iterator
    mov r9, 0     ; set r9 to 0 in each iteration

    mov al, byte [rdi + r8]
    cmp al, byte [rsi + r9]
    je match

  not_match:
    mov r8, r10              ; Last position of first iterator

    inc r8
    cmp byte [rdi + r8], 0h  ; check if the haystack string ended
    je not_found

    jmp strstr               ; if it is not the end continue

  match:
    cmp byte [rsi + r9 + 1], 0h ; needle ended?
    je found                    ; then return the position

    inc r8    ; increase both registers
    inc r9    ;

    mov al, byte [rdi + r8]     ; move rdi + r8 to al (rax low bites)
    cmp al, byte [rsi + r9]     ; compare rsi + r9 to al
    je match                    ; match? continue
    jmp not_match               ; nope? get back to the first loop

  not_found:
    mov rax, 0
    jmp end

  found:
    mov rax, rdi
    add rax, r10

  end:
    pop r10
    pop r9
    pop r8

    ; epilogue
    mov rsp, rbp
    pop rbp

    ret