% DEFINICIÓN DE OPERADORES (PALABRAS RESERVADAS)
:-op(1,fx,neg).
:-op(2,xfx,or).
:-op(2,xfx,and).
:-op(2,xfx,imp).
:-op(2,xfx,dimp).

% CÁLCULO DE SECUENTES INICIALES
% Clausula principal 
checkExpression(F):-
    lpk([], [F], [], []).

% Caso base: Buscar coincidencia en ambas listas
lpk([], [], [H|T], VR):-
    member(H, VR);
    lpk([], [], T, VR).

% Caso recursivo de variable preposisional atómica lado izquierdo
lpk([H|T], R, VL1, VR):-
    atom(H),
    append([H], VL1, VL2),
    lpk(T, R, VL2, VR).

% Caso recursivo de variable preposisional atómica lado derecho
lpk(L, [H|T], VL, VR1):-
    atom(H),
    append([H], VR1, VR2),
    lpk(L, T, VL, VR2).

% Caso recursivo de negación lado izquierdo
lpk([neg F|T], R1, VL, VR):-
    append([F], R1, R2),
    lpk(T, R2, VL, VR).

% Caso recursivo de negación lado derecho
lpk(L1, [neg F|T], VL, VR):-
    append([F], L1, L2),
    lpk(L2, T, VL, VR).

% Caso recursivo de disyunción lado izquierdo 
lpk([F1 or F2|T], R, VL, VR):-
    append([F1], T, L1),
    append([F2], T, L2),
    lpk(L1, R, VL, VR),
    lpk(L2, R, VL, VR).

% Caso recursivo de disyunción lado derecho
lpk(L, [F1 or F2|T], VL, VR):-
    append([F1,F2], T, R),
    lpk(L, R, VL, VR).

% Caso recursivo de conjunción lado izquierdo
lpk([F1 and F2|T], R, VL, VR):-
    append([F1,F2], T, L),
    lpk(L, R, VL, VR).

% Caso recursivo de conjunción lado derecho
lpk(L, [F1 and F2|T], VL, VR):-
    append([F1], T, R1),
    append([F2], T, R2),
    lpk(L, R1, VL, VR),
    lpk(L, R2, VL, VR).

% Caso recursivo de implicación lado izquierdo
lpk([F1 imp F2|T], R1, VL, VR):-
    append([F1], R1, R2),
    append([F2], T, L),
    lpk(T, R2, VL, VR),
    lpk(L, R1, VL, VR).

% Caso recursivo de implicación lado derecho
lpk(L1, [F1 imp F2|T], VL, VR):-
    append([F1], L1, L2),
    append([F2], T, R),
    lpk(L2, R, VL, VR).

% Caso recursivo de doble implicación lado izquierdo
lpk([F1 dimp F2|T], R1, VL, VR):-
    append([F1,F2], R1, R2),
    append([F1,F2], T, L),
    lpk(T, R2, VL, VR),
    lpk(L, R1, VL, VR).

% Caso recursivo de doble implicación lado derecho
lpk(L1, [F1 dimp F2|T], VL, VR):-
    append([F1], L1, L2),
    append([F2], T, R1),
    append([F2], L1, L3),
    append([F1], T, R2),
    lpk(L2, R1, VL, VR),
    lpk(L3, R2, VL, VR).    

/** <examples>
?- checkExpression(((p imp q) and (q imp r)) imp (p imp r)), !.			% true
?- checkExpression(neg (p and q) dimp (neg p or neg q)), !.				% true
?- checkExpression(((p imp q) imp q) imp q), !.							% false
?- checkExpression(((p imp q) imp p) imp q), !. 						% false
?- checkExpression((p or neg (q and r)) imp ((p dimp r) or q)), !.		% false
?- checkExpression((p and q) imp (p or r)), !.							% true
?- checkExpression((p imp q) or (q imp p)), !.							% true
?- checkExpression((p imp q) dimp (neg q imp p)), !.					% false
?- checkExpression(((neg p imp q) and (neg p imp neg q)) imp p), !.		% true
?- checkExpression(((p imp q) imp q) imp p), !.							% false
?- checkExpression(((q imp r) imp (p imp q)) imp (p imp q)), !.			% true
?- checkExpression(p imp (q imp (q imp p))), !.							% true
?- checkExpression((p dimp q) dimp (p dimp (q dimp p))), !.				% false
?- checkExpression(neg (p imp q) imp p), !.								% true
*/
