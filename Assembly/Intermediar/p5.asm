; ============================================================================
; EXERCIȚIUL 5 (Intermediar): Înlocuirea vocalelor mici cu '*' și contorizare
;
; CONCEPTE COMBINATE:
;   - Parcurgere șir ASCIIZ (octet cu octet, terminat cu 0).
;   - Comparații multiple pentru identificarea vocalelor ('a', 'e', 'i', 'o', 'u').
;   - Modificare directă în memorie (In-Place modification): `MOV byte ptr [RSI], '*'`.
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem:
;     str_text db "arhitectura", 0
;
; PUNCT FINAL (Stare Dorită):
;   - Șirul din memorie `str_text` devine: "*rh*t*ct*r*"
;   - Registrul RAX va conține numărul total de vocale înlocuite (5).
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Parcurge `str_text` folosind `RSI`.
;   - Dacă octetul este `0`, oprește parcurgerea.
;   - Compară `AL` cu fiecare vocală mică ('a', 'e', 'i', 'o', 'u').
;   - Dacă picioarele de potrivire găsesc o vocală, suprascrie în memorie cu `'*'` 
;     și incrementează un registru contor (ex: `RBX`).
; ============================================================================

.data
    str_text db "arhitectura", 0

.code
main proc
    LEA RSI, str_text
    XOR RAX, RAX

start:
    MOV BL, byte ptr [RSI]

    CMP BL, 0
    JZ finish

    CMP BL, 'a'
    JZ vocala
    CMP BL, 'e'
    JZ vocala
    CMP BL, 'i'
    JZ vocala
    CMP BL, 'o'
    JZ vocala
    CMP BL, 'u'
    JZ vocala

    JMP skip
vocala:
    MOV byte ptr [RSI], '*'
    INC RAX
skip:
    INC RSI
    JMP start
finish:

    ret
main endp
END