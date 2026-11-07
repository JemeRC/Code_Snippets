; ============================================================================
; EXERCIȚIUL 3: Swapping în vector (Adresare bazată cu index scalat)
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - În .data avem vectorul de DWORD-uri:
;     v_dw DWORD 100h, 200h, 300h, 400h, 500h
;
; PUNCT FINAL (Stare Dorită):
;   - Vectorul din memorie devine: 100h, 400h, 300h, 200h, 500h
;   - (Elementul de la indexul 1 - adică 200h - s-a interschimbat cu elementul
;      de la indexul 3 - adică 400h).
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Trebuie să folosești sintaxa de adresare indirectă cu factor de scalare:
;     [bază + index * 4]  (unde scala este 4, deoarece elementele sunt DWORD).
;   - Folosește un registru de bază pentru adresa vectorului (ex. RBX) 
;     și registre de index/temporare pentru permutare.
; ============================================================================

.data
    v_dw dd 100h, 200h, 300h, 400h, 500h

.code
main proc
    LEA rbx, v_dw

    MOV eax, [rbx + 1 * 4]
    MOV edx, [rbx + 3 * 4]
    
    MOV [rbx + 1 * 4], edx
    MOV [rbx + 3 * 4], eax

    ret
main endp
END