; Project Euler 5: smallest positive multiple of every integer from 1 to 20.
; R8 = accumulated LCM, R9 = next integer. Intermediate values fit in 64 bits.
option casemap:none
.code
PUBLIC solve
solve PROC
    mov r8d, 1
    mov r9d, 2
next_integer:
    mov rax, r8
    mov rdx, r9
gcd_loop:
    test rdx, rdx
    jz combine_lcm
    mov r10, rdx
    xor edx, edx
    div r10
    mov rax, r10           ; Euclid: (a, b) becomes (b, a mod b).
    jmp gcd_loop
combine_lcm:
    mov r10, rax
    mov rax, r8
    xor edx, edx
    div r10                ; LCM(a, b) = (a / GCD(a, b)) * b.
    imul rax, r9
    mov r8, rax
    inc r9
    cmp r9, 20
    jbe next_integer
    mov rax, r8
    ret
solve ENDP
END
