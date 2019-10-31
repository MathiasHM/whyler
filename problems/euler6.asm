; Project Euler 6: square of the sum minus sum of squares, 1 through 100.
; RCX = term, R8 = sum, R9 = sum of squares.
option casemap:none
.code
PUBLIC solve
solve PROC
    mov ecx, 1
    xor r8d, r8d
    xor r9d, r9d
next_term:
    add r8, rcx
    mov rax, rcx
    imul rax, rcx
    add r9, rax
    inc rcx
    cmp rcx, 100
    jbe next_term
    mov rax, r8
    imul rax, rax
    sub rax, r9
    ret
solve ENDP
END
