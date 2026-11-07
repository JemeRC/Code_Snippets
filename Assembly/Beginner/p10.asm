; ============================================================================
; EXERCIȚIUL 10: Determinarea câtului și restului pentru numere fără semn
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem:
;     deimpartit dq 100
;     impartitor dq 7
;     cat        dq ?
;     rest       dq ?
;
; PUNCT FINAL (Stare Dorită):
;   - Variabila `cat` devine 14.
;   - Variabila `rest` devine 2.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Încarcă `deimpartit` în RAX.
;   - Curăță obligatoriu registrul RDX (XOR rdx, rdx).
;   - Execută DIV cu operandul `impartitor`.
;   - Salvează RAX în `cat` și RDX în `rest`.
; ============================================================================

.data
    deimpartit dq 100
    impartitor dq 7
    cat        dq ?
    rest       dq ?

.code
main proc
    MOV RAX, deimpartit
    XOR RDX, RDX        ; RDX <- 0
    DIV impartitor      ; RDX:RAX / impartitor = cat [RAX], rest [RDX]

    MOV cat, RAX
    MOV rest, RDX

    ret
main endp
END