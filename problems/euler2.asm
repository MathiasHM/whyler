; Project Euler 2: sum even Fibonacci terms not exceeding 4,000,000.
; Registers: RCX = current term, RDX = next term, RAX = sum, R8 = temporary.
option casemap:none
.code
PUBLIC solve
solve PROC
    mov ecx, 1
    mov edx, 2
    xor eax, eax

next_term:
    cmp rcx, 4000000
    ja finished
    test rcx, 1             ; Low bit is 0 for even numbers, 1 for odd.
    jnz advance_term
    add rax, rcx

advance_term:
    mov r8, rcx             ; Preserve the sum before advancing the term pair.
    add r8, rdx
    mov rcx, rdx
    mov rdx, r8
    jmp next_term

finished:
    ret
solve ENDP
END
