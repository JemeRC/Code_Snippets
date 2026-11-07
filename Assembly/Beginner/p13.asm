; ============================================================================
; EXERCIȚIUL 13: Scrierea unei subrutine proprii de adunare pe 64 biți
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În `main`, avem două valori pe 64 biți: 15h și 25h.
;
; PUNCT FINAL (Stare Dorită):
;   - O procedură proprie `SumaProc` primește două numere în RCX și RDX,
;     calculează suma lor și o returnează în RAX.
;   - `main` apelează `SumaProc`, iar rezultatul (3A h / 58 dec) ajunge în RBX.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Definește procedura `SumaProc PROC` ... `SumaProc ENDP`.
;   - În `main`: pui 15h în RCX, 25h în RDX și execuți `CALL SumaProc`.
;   - În `SumaProc`: adaugi RCX și RDX, pui rezultatul în RAX și execuți `RET`.
; ============================================================================

.code

SumaProc proc
    MOV RAX, RCX
    ADD RAX, RDX

    ret
SumaProc endp

main proc
    MOV RCX, 15h
    MOV RDX, 25h

    call SumaProc

    MOV RBX, RAX

    ret
main endp
END