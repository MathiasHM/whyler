; Project Euler 7: find the 10001st prime.
; RCX = candidate, R8 = prime count, R9 = trial divisor.
option casemap:none
.code
PUBLIC solve
solve PROC
    mov r8d, 1             ; Count 2 separately, all after are odd.
    mov ecx, 3
next_candidate:
    mov r9d, 3
try_divisor:
    mov rax, rcx
    xor edx, edx
    div r9
    cmp r9, rax            ; No factor at or below the square root remains
    ja prime_found
    test rdx, rdx
    jz composite
    add r9, 2
    jmp try_divisor
prime_found:
    inc r8
    cmp r8, 10001
    je finished
composite:
    add rcx, 2
    jmp next_candidate
finished:
    mov rax, rcx
    ret
solve ENDP
END
