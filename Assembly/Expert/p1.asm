; ============================================================================
; EXERCIȚIUL EXPERT: Scurtă descriere a fluxului complet
;
; CONCEPTE COMBINATE (TOATE CAPITOLELE):
;   1. Structuri (STRUCT) & Adresare pe vector de structuri.
;   2. Lungime șir ASCIIZ via `SCASB` sau parcurgere manuală.
;   3. Măști pe biți (`TEST` / `AND`) pentru filtrarea flag-urilor.
;   4. Extindere de semn pe 64 biți (`MOVSX`), `CQO` și împărțire cu semn (`IDIV`).
;   5. Inversarea rezultatelor valide folosind STIVA pe 64 biți (`PUSH` / `POP`).
;   6. Procedură proprie (`ProceseazaDate PROC`) apelată cu parametri x64 (RCX, RDX).
;   7. Apel de funcție externă `printf` cu alinierea stivei RSP la 16 octeți.
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - Definită structura `Record`:
;       eticheta db 16 dup(0)    ; Șir de caractere ASCIIZ (ex: "Senzor1", 0)
;       valoare  dw ?            ; Valoare cu semn (-100, 45, etc.)
;       status   db ?            ; Octet de flag-uri (Bit 0 = Activ, Bit 1 = Valid)
;       pad      db ?            ; Octet de aliniere (padding la 20 octeți per structură)
;
;   - Vector în .data cu 3 elemente Record:
;       rec1 Record <"ALPHA", -60, 3, 0>   ; status = 3 (0000 0011b -> Bitis 0 și 1 sunt 1 = VALID)
;       rec2 Record <"BETA",   40, 1, 0>   ; status = 1 (0000 0001b -> Bit 1 este 0 = INVALID)
;       rec3 Record <"GAMMA", 150, 3, 0>   ; status = 3 (0000 0011b -> Bitis 0 și 1 sunt 1 = VALID)
;
; PUNCT FINAL (Stare Dorită):
;   - Procedura `ProceseazaDate` parcurge vectorul:
;       1. Filtrează doar elementele cu `status` VALID: ambii biți 0 și 1 trebuie să fie 1! 
;          (Folosește TEST status, 3 -> dacă ambele sunt 1, masca 3h dă rezultat 3h).
;       2. Pentru elementele valide:
;          Calcul = valoare / lungime_eticheta
;          - rec1: "ALPHA" are 5 caractere. -60 / 5 = -12
;          - rec2: INVALID (bit 1 e 0) -> Ignorat.
;          - rec3: "GAMMA" are 5 caractere. 150 / 5 = 30
;       3. Salvează câturile valide pe STIVĂ (PUSH).
;       4. Extrage câturile din stivă (POP) pentru a le aduna în ordine inversă.
;   - Procedura returnează Suma Câturilor Valide în RAX: (-12 + 30 = 18).
;   - În `main`, suma din RAX este afișată pe consolă folosind `printf`.
; ============================================================================

EXTERN printf : PROC

Record STRUCT
    eticheta db 16 dup(0)
    valoare  dw ?
    status   db ?
    pad      db ?
Record ENDS

.data
    v_rec Record <"ALPHA", -60, 3, 0>, \
                 <"BETA",   40, 1, 0>, \
                 <"GAMMA", 150, 3, 0>
    len_r dq 3
    fmt   db "Suma finala a caturilor procesate este: %d", 0Dh, 0Ah, 0

.code

; ----------------------------------------------------------------------------
; Procedura: ProceseazaDate
; Intrare: RCX = adresa vector de structuri Record
;          RDX = numărul de elemente (3)
; Ieșire:  RAX = suma câturilor calculate pentru record-urile valide
; ----------------------------------------------------------------------------
ProceseazaDate PROC
    MOV RSI, RCX
    MOV RCX, RDX
    XOR R8, R8

start:
    MOV BL, byte ptr [RSI].Record.status
    AND BL, 3h
    CMP BL, 3h
    JNZ skip
        LEA R10, [RSI].Record.eticheta
        LEA R11, [RSI].Record.eticheta

    start_length:
        CMP byte ptr [R10], 0
        JE stop_length
        INC R10
        JMP start_length
    stop_length:
        SUB R10, R11    ; R10 <- Lungimea Sirului

        MOVSX RAX, word ptr [RSI].Record.valoare
        CQO
        IDIV R10        ; RAX <- Cat-ul impartirii

        PUSH RAX        ; Trimis pe stiva
        INC R8          ; Numar elemente pe stiva
skip:
    ADD RSI, 20
    LOOP start

    XOR RAX, RAX
    MOV RCX, R8
    CMP RCX, 0
    JZ pop_end
pop_loop:
    POP R10
    ADD RAX, R10

    LOOP pop_loop
pop_end:

    RET
ProceseazaDate ENDP

; ----------------------------------------------------------------------------
; Functia Principala (main)
; ----------------------------------------------------------------------------
main PROC
    LEA RCX, v_rec
    MOV RDX, len_r

    CALL ProceseazaDate

    SUB RSP, 32 + 8

    LEA RCX, fmt
    MOV RDX, RAX

    CALL printf

    ADD RSP, 32 + 8

    RET
main ENDP
END