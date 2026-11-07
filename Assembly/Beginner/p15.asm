; ============================================================================
; EXERCIȚIUL 15: Verificarea egalității a două șiruri de text
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem două șiruri de câte 4 caractere:
;     str1 db "MASM"
;     str2 db "MASM"
;     len  dq 4
;
; PUNCT FINAL (Stare Dorită):
;   - Registrul RAX devine 1 dacă șirurile sunt identice, sau 0 dacă difere.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Execută CLD.
;   - Încarcă adresa `str1` în RSI, adresa `str2` în RDI și `len` în RCX.
;   - Execută `REPE CMPSB`.
;   - Verifică indicatorul ZF (Zero Flag): 
;     dacă ZF == 1 (toate caracterele au fost egale), pui 1 în RAX; 
;     altfel pui 0 în RAX.
; ============================================================================

.data
    str1 db "MASM"
    str2 db "MASM"
    len  dq 4

.code
main proc
    CLD

    LEA RSI, str1
    LEA RDI, str2
    MOV RCX, len

    REPE CMPSB
    JNZ else
    MOV RAX, 1
    JMP done
else:
    MOV RAX, 0
done:

    ret
main endp
END