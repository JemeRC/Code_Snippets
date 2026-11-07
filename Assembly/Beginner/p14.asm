; ============================================================================
; EXERCIȚIUL 14: Calcularea lungimii unui șir ASCIIZ (terminat cu 0)
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem șirul:
;     str_text db "Arhitectura", 0
;
; PUNCT FINAL (Stare Dorită):
;   - Registrul RAX conține lungimea șirului fără octetul nulat (adică 11).
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Folosește CLD.
;   - Încarcă adresa șirului în RDI.
;   - Setază AL = 0 (caracterul nulat '0' de final pe care îl căutăm).
;   - Setază RCX la o valoare mare (ex: -1 / 0FFFFFFFFFFFFFFFFh) pentru a nu opri scanarea prematur.
;   - Execută `REPNE SCASB`.
;   - Distanța parcursă de RDI raportată la adresa de start minus 1 îți dă lungimea exactă!
; ============================================================================

.data
    str_text db "Arhitectura", 0

.code
main proc
    CLD                 ; Clear Direction Flag
    
    LEA RDI, str_text   ; Adresa Initiala o salvam in RDI
    MOV RBX, RDI        ; Setam in RBX Adresa Initiala
    XOR AL, AL          ; AL <- 0
    MOV RCX, -1         ; RCX <- 0xFFFFFF...

    REPNE SCASB         ; Cauta byte-ul = 0 ('\0' de la finalul sirului)

    MOV RAX, RDI        ; RAX <- RDI Final
    SUB RAX, RBX        ; RAX <- RDI - RBX = Pozitia Finala (+1) - Pozitia Initiala
    DEC RAX             ; RAX <- RAX - 1 (Ignoram Byte-ul 0 de la final)

    ret
main endp
END