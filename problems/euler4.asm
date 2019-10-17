; Project Euler 4: largest palindrome formed by two three-digit factors.
; R8 = first factor, R9 = second factor, R10 = best product.
option casemap:none
.const
decimal_base QWORD 10
.code
PUBLIC solve
solve PROC
    xor r10d, r10d
    mov r8d, 999
outer_loop:
    mov r9, r8             ; Search each unordered pair once.
inner_loop:
    mov r11, r8
    imul r11, r9
    cmp r11, r10
    jbe next_factor        ; Smaller second factors cannot improve the result.

    mov rax, r11
    xor ecx, ecx
reverse_digits:
    xor edx, edx
    div decimal_base       ; Extract the last decimal digit into RDX.
    imul rcx, rcx, 10
    add rcx, rdx
    test rax, rax
    jnz reverse_digits
    cmp rcx, r11
    jne next_pair
    mov r10, r11
    jmp next_factor
next_pair:
    dec r9
    cmp r9, 100
    jae inner_loop
next_factor:
    dec r8
    cmp r8, 100
    jae outer_loop
    mov rax, r10
    ret
solve ENDP
END
