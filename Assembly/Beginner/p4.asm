; ============================================================================
; EXERCIȚIUL 4: Suma elementelor dintr-un vector de octeți (db)
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem vectorul de octeți:
;     v_bytes db 5, 12, 3, 8, 20
;   - Numărul de elemente este 5.
;
; PUNCT FINAL (Stare Dorită):
;   - Registrul RAX conține suma totală a elementelor în zecimal (48).
;   - Registrul RAX trebuie curățat la început (setat pe 0).
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Parcurgerea se face obligatoriu folosind instrucțiunea LOOP.
;   - Registrul RCX va fi încărcat cu numărul de elemente (5).
;   - NU modifica RCX în interiorul buclei pentru alte scopuri!
;   - Adunarea se face pe 8 biți (AL) sau cu extindere în RAX pentru a evita depășirea.
; ============================================================================

.data
    v_bytes db 5, 12, 3, 8, 20
    len     dq 5

.code
main proc
    XOR rax, rax        ; rax <- 0
    XOR rsi, rsi        ; rsi <- 0
    MOV rcx, len        ; rcx <- 5
    LEA rbx, v_bytes    ; rbx <- adresa lui v_bytes

start:
    MOVSX rdx, [rbx + rsi * 1]      ; rdx <- rax + *(rbx + rsi * 1)
    ADD rax, rdx                    ; rax <- rax + rdx

    INC rsi                     ; rsi++
    LOOP start                  ; if(rcx != 0){ dec rcx ; jmp start }


    ret
main endp
END