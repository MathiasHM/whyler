; Project Euler 1: sum multiples of 3 or 5 below 1000.
; Returns: RAX = sum
; Registers: RCX = candidate, R8 = sum, R9 = divisor, RDX = remainder
option casemap:none
.code
PUBLIC solve
solve PROC
    mov ecx, 1
    xor r8d, r8d

next_number:
    mov rax, rcx
    xor edx, edx            ; DIV requires the full dividend in RDX:RAX.
    mov r9d, 3
    div r9
    test rdx, rdx
    jz add_number           ; Avoid counting shared multiples twice.

    mov rax, rcx            ; Restore the candidate after DIV overwrites RAX.
    xor edx, edx
    mov r9d, 5
    div r9
    test rdx, rdx
    jnz advance_number

add_number:
    add r8, rcx
advance_number:
    inc rcx
    cmp rcx, 1000
    jb next_number
    mov rax, r8
    ret
solve ENDP
END
