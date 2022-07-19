; Project Euler 9: product abc where a < b < c, a+b+c = 1000,
; and a*a + b*b = c*c.
; R8 = a, R9 = b, R10 = c. Returns zero if no triplet is found.
option casemap:none
.code
PUBLIC solve
solve PROC
    mov r8d, 1
next_a:
    lea r9, [r8+1]
next_b:
    mov r10d, 1000
    sub r10, r8
    sub r10, r9            ; Derive c from the required sum.
    cmp r9, r10
    jae advance_a          ; Increasing b further would violate b < c.

    mov rax, r8
    imul rax, r8
    mov rdx, r9
    imul rdx, r9
    add rax, rdx
    mov r11, r10
    imul r11, r10
    cmp rax, r11
    je found
    inc r9
    jmp next_b
advance_a:
    inc r8
    cmp r8, 333            ; a < 1000/3 because a is the smallest side.
    jbe next_a
    xor eax, eax
    ret
found:
    mov rax, r8
    imul rax, r9
    imul rax, r10
    ret
solve ENDP
END
