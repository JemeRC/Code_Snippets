; ============================================================================
; EXERCIȚIUL 2 (Intermediar): Filtrare cifre ASCII și inversare prin Stivă
;
; CONCEPTE COMBINATE:
;   - Parcurgere șir ASCIIZ (terminat cu 0).
;   - Salturi condiționate duble (verificare interval ASCII '0'..'9').
;   - Operarea cu Stiva pe 64 biți (PUSH/POP) pentru inversarea ordinii.
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem:
;     src_str db "A1b2C3d4!", 0     ; Conține cifrele '1', '2', '3', '4'
;     dst_str db 10 dup(0)          ; Spațiu pentru rezultatul inversat
;
; PUNCT FINAL (Stare Dorită):
;   - `dst_str` va conține doar cifrele extrasă în ordine INVERSĂ, urmate de 0:
;     dst_str -> "4321", 0
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Pas 1: Parcurge `src_str` octet cu octet. Dacă un caracter este >= '0' (30h) 
;     ȘI <= '9' (39h), extinde-l pe 64 biți și pune-l pe stivă (PUSH). Păstrează un contor.
;   - Pas 2: Extrage din stivă (POP) direct în `dst_str` folosind un pointer/index 
;     și adaugă octetul `0` la finalul noului șir.
; ============================================================================

.data
    src_str db "A1b2C3d4!", 0
    dst_str db 10 dup(0)

.code
main proc
    LEA RSI, src_str
    XOR RCX, RCX

start:
    MOV AL, [RSI]
    CMP AL, 0       ; Final de Sir?
    JZ finish       ; Da. Termina
        CMP AL, '0'     ; AL < 0 ?
        JB skip         ; Da. Skip
        CMP AL, '9'     ; AL > 9 ?
        JA skip         ; Da. Skip

        ; Nu. Punel pe stiva
        MOVSX RAX, AL
        PUSH RAX
        INC RCX         ; RCX++. Cate cifre sunt pe Stiva
    skip:
    INC RSI         ; Urmatorul caracter
    JMP start
finish:

    LEA RDI, dst_str    ; Adresa Sirului pe care il cream
    CMP RCX, 0
    JE pop_end
pop_loop:
    POP RAX             ; Extragem Cifra
    MOV [RDI], AL       ; Salvam Cifra pe Stiva

    INC RDI             ; Crestem Adresa
    LOOP pop_loop
pop_end:
    MOV byte ptr [RDI], 0   ; Adaugam finalul sirului '\0'

    ret
main endp
END