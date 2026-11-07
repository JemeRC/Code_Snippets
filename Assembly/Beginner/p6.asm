; ============================================================================
; EXERCIȚIUL 6: Duplicare de bloc de memorie (String Copy)
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem:
;     src_bytes db 10h, 20h, 30h, 40h, 50h
;     dst_bytes db 5 dup(0)
;
; PUNCT FINAL (Stare Dorită):
;   - Blocul `dst_bytes` conține valorile [10h, 20h, 30h, 40h, 50h].
;   - Copierea se face octet cu octet automat prin procesor.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Folosește CLD pentru a seta direcția de parcurgere.
;   - Încarcă adresa sursă în RSI, adresa destinație în RDI și lungimea (5) în RCX.
;   - Folosește secvența REP MOVSB pentru copiere.
; ============================================================================

.data
    src_bytes db 10h, 20h, 30h, 40h, 50h
    dst_bytes db 5 dup(0)

.code
main proc
    CLD     ; Clear Direction Flag (Citirea de la stanga la dreapta)

    LEA RSI, src_bytes
    LEA RDI, dst_bytes

    MOV RCX, 5

    REP MOVSB ; REPeat  MOVe String Byte


    ret
main endp
END