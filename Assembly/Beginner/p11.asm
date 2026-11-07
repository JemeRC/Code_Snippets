; ============================================================================
; EXERCIȚIUL 11: Împărțirea numerelor întregi cu semn
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem:
;     numar    dq -100
;     impartit dq 3
;     cat      dq ?
;     rest     dq ?
;
; PUNCT FINAL (Stare Dorită):
;   - Variabila `cat` devine -33.
;   - Variabila `rest` devine -1.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Încarcă `numar` (-100) în RAX.
;   - Execută instrucțiunea `CQO` (extinde bitul de semn din RAX în RDX).
;   - NU folosi `XOR rdx, rdx` aici! (`XOR` ar distruge semnul negativ).
;   - Execută `IDIV impartit`.
;   - Salvează câtul (RAX) și restul (RDX) în variabilele corespunzătoare.
; ============================================================================

.data
    numar    dq -100
    impartit dq 3
    cat      dq ?
    rest     dq ?

.code
main proc
    MOV RAX, numar
    CQO             ; Bitul de semn din RAX se muta in RDX pentru ca numarul concatenat RDX:RAX sa fie negativ
    IDIV impartit   ; RDX:RAX / impartit = cat [RAX], rest [RDX]

    MOV cat, RAX
    MOV rest, RDX

    ret
main endp
END