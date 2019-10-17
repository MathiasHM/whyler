; Unsigned 64-bit mathematics
; Volatile registers
option casemap:none
.code

; Largest prime factor of unsigned RCX
; returns 0 for inputs below 2 :)
; Slow for large primes.
; RCX = remaining value, R8 = temporary divisor. Returns RAX.
PUBLIC eu_largest_prime_factor
eu_largest_prime_factor PROC
    xor eax, eax
    cmp rcx, 2
    jb factor_done
    mov r8d, 2
factor_loop:
    mov rax, rcx
    xor edx, edx
    div r8
    cmp r8, rax             ; d > n/d is an overflow safe test for d*d > n.
    ja factor_remaining
    test rdx, rdx
    jnz factor_next
    mov rcx, rax            ; remove and retry
    jmp factor_loop
factor_next:
    inc r8
    jmp factor_loop
factor_remaining:
    mov rax, rcx 
factor_done:
    ret
eu_largest_prime_factor ENDP
END

