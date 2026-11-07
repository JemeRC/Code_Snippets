; ============================================================================
; EXERCIȚIUL 8: Modificarea câmpurilor unei structuri în memorie
;
; PUNCT DE ÎNCEPUT (Stare Inițială):
;   - Se definește structura `Punct2D` având câmpurile:
;     x dw ?
;     y dw ?
;   - În .data se instanțiază o variabilă:
;     p1 Punct2D <100, 200>
;
; PUNCT FINAL (Stare Dorită):
;   - Câmpurile variabilei p1 sunt inversate: p1.x devine 200, iar p1.y devine 100.
;
; RESTRICȚII / INSTRUCȚIUNI CHEIE:
;   - Încarcă adresa variabilei p1 într-un registru de bază (ex: RBX).
;   - Accesează câmpurile structurii folosind sintaxa: [rbx].Punct2D.x și [rbx].Punct2D.y
;     (sau direct prin offseturi raportate la dimensiunea `dw`).
; ============================================================================

Punct2D STRUCT
    x dw ?
    y dw ?
Punct2D ENDS

.data
    p1 Punct2D <100, 200>

.code
main proc
    LEA RBX, p1
    
    PUSH [rbx].Punct2D.x 
    PUSH [rbx].Punct2D.y

    POP [rbx].Punct2D.x
    POP [rbx].Punct2D.y

    ret
main endp
END