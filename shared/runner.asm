option casemap:none
include toolkit.inc
EXTERN solve:PROC
EXTERN ExitProcess:PROC
.code
main PROC FRAME
    sub rsp, 28h
    .allocstack 28h
    .endprolog
    call solve
    mov rcx, rax
    call eu_print_u64
    xor ecx, ecx
    test eax, eax
    setz cl                  ; Exit 1 if printing failed; otherwise exit 0.
    call ExitProcess
main ENDP
END
