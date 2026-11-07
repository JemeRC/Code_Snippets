; ============================================================================
; EXERCIȚIUL 5: Contorizare valori strict pozitive (> 0) dintr-un vector dd
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem un vector de 4 dublu-cuvinte cu semn (dd):
;     v_nums dd 15, -4, 0, 8
;
; PUNCT FINAL (Stare Dorită):
;   - Registrul EBX conține numărul de elemente strict mai mari decât 0 (adică 2).
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Parcurge vectorul folosind un registru de index (ex: RSI sau RDI).
;   - Folosește CMP [bază + index * 4], 0 pentru a compara fiecare element.
;   - Folosește instrucțiunea de salt condiționat JLE (Jump if Less or Equal) 
;     pentru a sări peste incrementarea contorului dacă numărul este <= 0.
; ============================================================================

.data
    v_nums dd 15, -4, 0, 8

.code
main proc
    LEA rsi, v_nums

    XOR ebx, ebx    ; ebx <- 0
    XOR rdi, rdi    ; rsi <- 0
    MOV rcx, 4      ; rcx <- lungimea v_nums
start:
    CMP dword ptr [rsi + rdi * 4], 0
    JLE @F          ; if(*(rsi + rcx * 4) <= 0) jmp @F
    INC ebx         ; ebx++
@@:
    INC rdi
    loop start

    ret
main endp
END