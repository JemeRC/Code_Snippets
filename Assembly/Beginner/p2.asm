; ============================================================================
; EXERCIȚIUL 2: Conversie de semn și calcul optimizat
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - O variabilă `val_16` în .data definită ca SWORD cu valoarea -25.
;   - O variabilă `rezultat` în .data definită ca SQWORD (neinițializată / 0).
;
; PUNCT FINAL (Stare Dorită):
;   - Memoria variabilei `rezultat` conține valoarea finală -218 (pe 64 biți).
;   - Calculul efectuat trebuie să fie: rezultat = (9 * val_16) + 7
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - NU ai voie să folosești MUL sau IMUL!
;   - Folosește MOVSX pentru extinderea pe 64 biți în RAX.
;   - Folosește instrucțiunea LEA pentru a înmulți cu 9 și a adăuga 7.
; ============================================================================

; 25 = 16 + 8 + 1
; 0001 1001

.data
    val_16    dw -25    ; 2 octeti      1111 1111 | 1110 0111
    rezultat  dq ?      ; 8 octeti      

.code
main proc
    MOVSX rax, val_16   ; rax <- 0xFFFFFFE7 = -25 Complement fata de 2 pe 8 octeti

    MOV rbx, rax        ; rbx <- rax
    ADD rbx, 7          ; rbx + 7
    SHL rax, 3          ; rax * 2^3 = rax * 8
    
    ADD rax, rbx        ; rax + rbx = val_16 * 8 + val_16 + 7 = 9 * val_16 + 7
    
    ; ALTERNATIV
    ;   LEA rax, [rax + rax * 8 + 7]
    
    MOV rezultat, rax   ; resultat <- (9 * val_16) + 7

    ret
main endp
END