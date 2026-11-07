; ============================================================================
; EXERCIȚIUL 1: Izolare de biți și ajustare
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În RAX există o valoare de 64 biți (de exemplu: 0x123456789ABCDEAB).
;   - Regula se aplică pe octetul inferior AL (care în binar are o valoare oarecare).
;
; PUNCT FINAL (Stare Dorită):
;   - Registrul BL conține valoarea obținută după următorii pași:
;       1. Izolarea biților 3 și 4 din AL (restul biților devin 0).
;       2. Deplasarea biților izolați la dreapta cu 3 poziții.
;       3. Adăugarea valorii 10 (zecimal) la rezultat.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Folosește: AND, SHR, ADD, MOV.
; ============================================================================

.code
main proc
    MOV rax, 123456789ABCDEABh

    MOV bl, al      ; bl <- ABh = 1010 1011
    AND bl, 18h     ; 1010 1011 AND 0001 1000 -> 000'0 1'000
    SHR bl, 3       ; 0000 1000 -> 0000 0001
    ADD bl, 10      ; 0000 0001 + 0000 1010 -> 0000 1011 = 11 

    ret
main endp

END