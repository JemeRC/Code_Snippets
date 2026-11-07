; ============================================================================
; EXERCIȚIUL 9: Înmulțire a două valori dd (32 biți) cu salvare pe dq (64 biți)
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem:
;     val1 dd 100000      ; 100,000 (32 biți)
;     val2 dd 200000      ; 200,000 (32 biți)
;     rez  dq ?           ; Locație pe 64 biți
;
; PUNCT FINAL (Stare Dorită):
;   - Variabila `rez` conține valoarea 20,000,000,000 (20 miliarde).
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Încarcă `val1` în EAX.
;   - Execută `MUL val2` (operația se face EAX * val2).
;   - Rezultatul pe 64 biți este salvat automat de procesor în perechea EDX:EAX.
;   - Unește EDX și EAX într-un registru pe 64 biți (ex: RAX) sau folosește 
;     înmulțirea directă pe 64 biți extinzând operanzii.
; ============================================================================

.data
    val1 dd 100000
    val2 dd 200000
    rez  dq ?

.code
main proc
    XOR RAX, RAX    ; RAX <- 0
    XOR RDX, RDX    ; RDX <- 0

    MOV EAX, val1   ; EAX <- val1
    MUL val2        ; EDX:EAX <- val1 * val2
    SHL RDX, 32     ; EDX shiftat pe ceilalti 32 de biti ai registrului RDX 
    ADD RAX, RDX    ; RAX contine EDX:EAX de la inmultire

    MOV rez, RAX    

    ret
main endp
END