; ============================================================================
; EXERCIȚIUL 3 (Intermediar): SUBrutină de calcul Min/Max și afișare C
;
; CONCEPTE COMBINATE:
;   - Procedură proprie (`PROC`) apelată conform convenției Windows x64.
;   - Alinierea stivei RSP la 16 octeți + Shadow Space (32 octeți).
;   - Căutare Minim/Maxim într-un vector de enteros pe 32 biți (dd).
;   - Apelare funcție externă `printf`.
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - `main` definește vectorul: `v_vals dd 45, 12, 89, 3, 67` (5 elemente).
;   - Format `printf`: `fmt db "Diferenta MAX - MIN este: %d", 0Dh, 0Ah, 0`
;
; PUNCT FINAL (Stare Dorită):
;   - Procedura `ProceseazaVector` primește:
;       RCX = adresa vectorului
;       RDX = numărul de elemente (5)
;   - Procedura găsește MAX (89) și MIN (3), calculează Diferența (89 - 3 = 86).
;   - În interiorul procedurii (sau în main), se apelează `printf` pentru a afișa 86.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Înainte de `call printf`, stiva trebuie aliniată corect: `sub rsp, 40` (sau 48).
; ============================================================================

EXTERN printf : PROC

.data
    v_vals dd 45, 12, 89, 3, 67
    len_v  dq 5
    fmt    db "Diferenta MAX - MIN este: %d", 0Dh, 0Ah, 0

.code

ProceseazaVector proc
    MOV RSI, RCX    ; Adresa Vectorului
    MOV RCX, RDX    ; Contor
    
    MOV EAX, dword ptr [RSI]    ; EAX = MAX = v_vals[0] (45)
    MOV EBX, dword ptr [RSI]    ; EBX = MIN = v_vals[0] (45)

start:
    MOV EDX, dword ptr [RSI]  ; EDX = elementul curent

    CMP EAX, EDX    ; EAX < [RSI] ?
    JNA @F         ; Nu. Ignora
    MOV EAX, EDX    ; Da. EAX = [RSI]
@@:
    CMP EBX, EDX    ; EBX > [RSI] ?
    JNB @F         ; Nu. Ignora
    MOV EBX, EDX    ; Da. EBX = [RSI]
@@:
    ADD RSI, 4      ; Urmatorul element
    loop start

    SUB EAX, EBX    ; Maxim - Minim, valoarea fiind in EAX
    MOVSX RAX, EAX  ; Extindem rezultatul in RAX

    RET
ProceseazaVector endp

main proc
    LEA RCX, v_vals
    MOV RDX, len_v

    call ProceseazaVector

    SUB RSP, 32 + 8

    LEA RCX, fmt
    MOV RDX, RAX

    call printf

    add RSP, 32 + 8

    ret
main endp
END