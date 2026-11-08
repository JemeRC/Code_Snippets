; ============================================================================
; EXERCIȚIUL 4 (Intermediar): Numărare elemente pozitive cu bit specific setat
;
; CONCEPTE COMBINATE:
;   - Parcurgere vector `dd` (4 octeți per element -> pas de +4 la adrese).
;   - Comparare cu semn (`CMP`, `JLE` / `JG`) pentru a fi număr pozitiv (> 0).
;   - Mascare pe biți (`TEST` / `AND`) pentru verificarea Bitului 2 (mască: 4 = 100b).
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem:
;     v_val dd 12, -4, 5, 14, 0, 7
;     len_v dq 6
;
; PUNCT FINAL (Stare Dorită):
;   - Registrul RAX va conține numărul de elemente care sunt STRICT POZITIVE (> 0)
;     ȘI au Bitul 2 setat pe 1 (valoric, bitul 2 înseamnă 4).
;   - Pentru datele de test:
;       12 = 1100b  (pozitiv, Bit 2 = 1) -> VALID
;       -4          (negativ)           -> IGNORAT
;        5 = 0101b  (pozitiv, Bit 2 = 1) -> VALID
;       14 = 1110b  (pozitiv, Bit 2 = 1) -> VALID
;        0          (nu e > 0)          -> IGNORAT
;        7 = 0111b  (pozitiv, Bit 2 = 1) -> VALID
;     RAX final = 4.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Incrementarea adresei vectorului se face cu +4 (`ADD RSI, 4`).
;   - Verifică mai întâi dacă numărul este <= 0. Dacă da, sari peste.
;   - Verifică bitul 2 folosind `TEST dword ptr [RSI], 4`.
; ============================================================================

.data
    v_val dd 12, -4, 5, 14, 0, 7
    len_v dq 6

.code
main proc
    LEA RSI, v_val
    MOV RCX, len_v
    XOR RAX, RAX

start:
    MOV EBX, [RSI]
    CMP EBX, 0
    JLE skip
    TEST EBX, 4
    JZ skip
    INC EAX
skip:
    ADD RSI, 4
    LOOP start

    ret
main endp
END