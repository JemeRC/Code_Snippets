; ============================================================================
; EXERCIȚIUL 7: Swapping de valori folosind proprietatea LIFO a stivei
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem variabilele pe 64 biți:
;     val1 dq 1111h
;     val2 dq 9999h
;
; PUNCT FINAL (Stare Dorită):
;   - val1 devine 9999h, iar val2 devine 1111h.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - NU folosi regiștri intermediari diferiți pentru interschimbare (ex: MOV RAX, val1; MOV RBX, val2).
;   - Folosește PUSH și POP pentru a trece valorile prin stivă.
;   - Atenție la ordinea extrasă din stivă (Last In, First Out)!
; ============================================================================

.data
    val1 dq 1111h
    val2 dq 9999h

.code
main proc
    PUSH val1
    PUSH val2
    
    POP val1
    POP val2

    ret
main endp
END