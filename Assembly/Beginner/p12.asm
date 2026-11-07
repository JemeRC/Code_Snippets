; ============================================================================
; EXERCIȚIUL 12: Afișarea unui text și a unui număr întreg folosind `printf`
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - Declarația externă a funcției C: 
;     extern printf : proc
;   - În .data avem:
;     fmt db "Valoarea calculata este: %d", 0Dh, 0Ah, 0  ; Format ASCIIZ (0 la final)
;     val dd 42                                         ; Valoare pe 32 biți
;
; PUNCT FINAL (Stare Dorită):
;   - Funcția `printf` este apelată corect conform convenției Windows x64.
;   - Consola afișează: Valoarea calculata este: 42
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Pregătește stiva: sub rsp, 40 (sau sub rsp, 32 + aliniere).
;   - Primul parametru (adresa formatului `fmt`) se pune în RCX.
;   - Al doilea parametru (valoarea `val`) se pune în RDX (sau EDX).
;   - Apelează `call printf`.
;   - Restaurează stiva: add rsp, 40.
; ============================================================================

EXTERN printf : PROC

.data
    fmt db "Valoarea calculata este: %d", 0Dh, 0Ah, 0
    val dd 42

.code
main proc

    SUB RSP, 32 + 8     ; 32 Bytes Shadow Area + 8 Bytes Aliniere Stiva

    XOR RDX, RDX        ; RDX <- 0 (singuranta)

    LEA RCX, fmt        ; RCX (Primul Parametru)        <- Adresa Sirului 
    MOV EDX, val        ; EDX (Al doilea Paramentru)    <- Valoarea pentru %d 

    call printf         ; Apel Functie

    ADD RSP, 32 + 8     ; Resetare Pointer al Stivei

    ret
main endp
END