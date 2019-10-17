; Project Euler 3: largest prime factor of 600851475143.
option casemap:none
include toolkit.inc
.code
PUBLIC solve
solve PROC
    mov rcx, 600851475143
    jmp eu_largest_prime_factor ; Tail call: return directly to the shared runner.
solve ENDP
END
