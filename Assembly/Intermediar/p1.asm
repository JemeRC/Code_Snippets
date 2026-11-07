; ============================================================================
; EXERCIȚIUL 1 (Intermediar): Procesare vector de structuri cu împărțire cu semn
;
; CONCEPTE COMBINATE:
;   - Structuri (STRUCT) și adresare indirectă scalată.
;   - Testare de biți (TEST / AND) pentru paritate.
;   - Extindere de semn (MOVSX / CQO) și împărțire cu semn (IDIV).
;   - Bucle și acumulare pe 64 de biți.
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - Definită structura `Nod`:
;       val    dw ?    (valoare pe 16 biți cu semn)
;       factor dw ?    (împărțitor pe 16 biți cu semn)
;   - Vector în .data cu 3 elemente de tip Nod:
;       v_noduri Nod <-40, 2>, Nod <15, 3>, Nod <50, 5>
;
; PUNCT FINAL (Stare Dorită):
;   - Registrul RAX conține suma câturilor pentru nodurile unde `factor` este IMPAR (bitul 0 = 1).
;   - Calcul per nod valid: Cat = val / factor.
;   - Pentru datele de test:
;       Nod 0: factor = 2 (par) -> Se ignoră.
;       Nod 1: factor = 3 (impar) -> 15 / 3 = 5
;       Nod 2: factor = 5 (impar) -> 50 / 5 = 10
;       RAX final = 5 + 10 = 15 (0Fh).
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Folosește `TEST factor, 1` sau `AND` pentru a verifica dacă factorul este impar.
;   - Extinde `val` pe 64 biți în RAX (`MOVSX`), apoi pregătește RDX (`CQO`) înainte de `IDIV`.
; ============================================================================

Nod STRUCT
    val    dw ?
    factor dw ?
Nod ENDS

.data
    v_noduri Nod <-40, 2>, <15, 3>, <50, 5>
    len_nod  dq 3

.code
main proc
    XOR RBX, RBX        ; RAX <- 0
    LEA RSI, v_noduri   ; RSI <- Adresa Vectorului de Structuri
    MOV RCX, len_nod    ; RCX <- Lungimea Vectorului

start:
    TEST word ptr [RSI].Nod.factor, 1   ; Este par?
    JZ skip                             ; Nu. Dai skip
        MOVSX RAX, word ptr [RSI].Nod.val   ; Mutam valoarea pe 2 bytes in registru pe 8 bytes
        CQO                                 ; Pregatim RDX pentru Impartire
        MOVSX R8, word ptr [RSI].Nod.factor

        IDIV R8         ; RDX:RAX / factor 
        ADD RBX, RAX    ; Adunam catul la RBX
skip:
    ADD RSI, 4          ; Urmatorul Nod
    LOOP start

    MOV RAX, RBX        ; Mutam in RAX valoarea din RBX pentru cerinta Enuntului

    ret
main endp
END