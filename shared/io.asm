option casemap:none
EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
.code
; Print unsigned RCX in decimal, followed by CR/LF.
; Returns EAX=1 on success, 0 on output failure.
PUBLIC eu_print_u64
eu_print_u64 PROC FRAME
    sub rsp, 88h
    .allocstack 88h
    .endprolog
    ; [rsp..rsp+1fh] shadow space, +20h fifth argument,
    ; +30h bytes written, +38h length, +40h pointer, +50h buffer.
    mov rax, rcx
    lea r8, [rsp+70h]
    mov byte ptr [r8], 13
    mov byte ptr [r8+1], 10
    mov r9d, 2
    mov r10d, 10
format_digit:
    xor edx, edx
    div r10
    add dl, '0'
    dec r8
    mov [r8], dl
    inc r9d
    test rax, rax
    jnz format_digit
    mov [rsp+40h], r8
    mov [rsp+38h], r9d
    mov ecx, -11              ; STD_OUTPUT_HANDLE
    call GetStdHandle
    mov rcx, rax
    mov rdx, [rsp+40h]
    mov r8d, [rsp+38h]
    lea r9, [rsp+30h]
    mov qword ptr [rsp+20h], 0
    call WriteFile
    test eax, eax
    jz print_done
    mov eax, [rsp+30h]
    cmp eax, [rsp+38h]
    sete al
    movzx eax, al
print_done:
    add rsp, 88h
    ret
eu_print_u64 ENDP
END
