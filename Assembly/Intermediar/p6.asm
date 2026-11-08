; ============================================================================
; EXERCIȚIUL 6 (Intermediar-Avansat): Calcul Trasă Matrice (Sumă Diagonala Principală)
;
; CONCEPTE COMBINATE:
;   - Adresare matrice liniarizată 3x3 de elemente `dd` (4 octeți).
;   - Formula pentru elementele de pe diagonala principală M[i][i]:
;     Offset = (i * 3 + i) * 4  =>  i * 4 * 4 = i * 16 octeți!
;   - Alinierea stivei `RSP` la 16 octeți + Shadow Space (40 octeți total) înainte de `call printf`.
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem o matrice 3x3 liniarizată pe rânduri:
;     matrice dd 10,  2,  3
;             dd  4, 20,  6
;             dd  7,  8, 30
;     fmt db "Trasa matricei (suma diagonala) este: %d", 0Dh, 0Ah, 0
;
; PUNCT FINAL (Stare Dorită):
;   - Suma diagonalei (10 + 20 + 30 = 60) este calculată și afișată în consolă via `printf`.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Parcurge cele 3 elemente de pe diagonală (indici i = 0, 1, 2).
;   - Adaugă valorile în EAX / RAX.
;   - Pregătește stiva (`SUB RSP, 40`), trece parametrii (`RCX` adresa formatului, `RDX` valoarea 60)
;     și apelează `call printf`.
; ============================================================================

EXTERN printf : PROC

.data
    matrice dd 10,  2,  3
            dd  4, 20,  6
            dd  7,  8, 30
    fmt     db "Trasa matricei (suma diagonala) este: %d", 0Dh, 0Ah, 0

.code
main proc
    LEA RSI, matrice
    XOR RDX, RDX
    
    ADD EDX, dword ptr [RSI + 0]
    ADD EDX, dword ptr [RSI + 16]
    ADD EDX, dword ptr [RSI + 32]

    LEA RCX, fmt

    SUB RSP, 32 + 8

    CALL printf

    ADD RSP, 32 + 8

    ret
main endp
END