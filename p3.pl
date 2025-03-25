% DEFINICIÓN DE OPERADORES (PALABRAS RESERVADAS)
:-op(1,fx,neg).
:-op(2,xfx,or).
:-op(2,xfx,and).
:-op(2,xfx,imp).
:-op(2,xfx,dimp).


% TRANSFORMACIÓN DE EXPRESIÓN LÓGICA EN TÉRMINOS DE DISYUNCIÓN Y NEGACIÓN
% Caso Base: Variables preposisionales atómica
trans(F,F):- atom(F).

% Caso recursivo de negación
trans(neg F, neg G):- trans(F, G).

% Caso recursivo de disyunción
trans(F1 or F2, G1 or G2):-
    trans(F1,G1),
    trans(F2,G2).

% Caso recursivo de conjunción
trans(F1 and F2, neg((neg G1) or (neg G2))):-
    trans(F1,G1),
    trans(F2,G2).

% Caso recursivo de implicación
trans(F1 imp F2, (neg G1) or G2):-
    trans(F1,G1),
    trans(F2,G2).

% Caso recursivo de doble implicación
trans(F1 dimp F2, R):-
    trans((F1 imp F2) and (F2 imp F1),R).
    

% CÁLCULO DE SECUENTES INICIALES
% Clausula principal 
checkExpression(F):-
    trans(F,G),
    lpk([], [G], [], []).

% Caso base: Buscar coincidencia en ambas listas
lpk([], [], [H1|T1], VR):-
    member(H1, VR);
    lpk([], [], T1, VR).

% Caso recursivo de variable preposisional atómica lado izquierdo
lpk([H1|T1], R, VL, VR):-
    atom(H1),
    append([H1], VL, VL2),
    lpk(T1, R, VL2, VR).

% Caso recursivo de variable preposisional atómica lado derecho
lpk(L, [H2|T2], VL, VR):-
    atom(H2),
    append([H2], VR, VR2),
    lpk(L, T2, VL, VR2).

% Caso recursivo de negación lado izquierdo
lpk([neg F|T1], R, VL, VR):-
    append([F], R, R2),
    lpk(T1, R2, VL, VR).

% Caso recursivo de negación lado derecho
lpk(L, [neg F|T2], VL, VR):-
    append([F], L, L2),
    lpk(L2, T2, VL, VR).

% Caso recursivo de disyunción lado derecho
lpk(L, [F1 or F2|T2], VL, VR):-
    append([F1, F2], T2, R2),
    lpk(L, R2, VL, VR).

<<<<<<< HEAD
% Caso recursivo de disyunción lado izquierdo
lpk([F1 or F2|T1], R, VL, VR):-
    append([F1], T1, L1),
    append([F2], T1, L2),
    lpk(L1, R, VL, VR),
=======
% Caso recursivo de disyunción lado izquierdo 1
lpk([F1 or F2|T1], R, VL, VR):-
    append([F1], T1, L1),
    append([F2], T1, L2),
    lpk(L1, L2, R, VL, VR).

% Caso recursivo de disyunción lado izquierdo 2
lpk(L1, L2, R, VL, VR):-
    lpk(L1, R, VL, VR);
>>>>>>> 9c5a8abc1a92364352a294e08bfea7f587a3f64a
    lpk(L2, R, VL, VR).

/** <examples>
?- checkExpression(((p imp q) and (q imp r)) imp (p imp r)), !.			% true
?- checkExpression(neg (p and q) dimp (neg p or neg q)), !.				% true
?- checkExpression(((p imp q) imp q) imp q), !.							% true
?- checkExpression(((p imp q) imp p) imp q), !. 						% false
?- checkExpression((p or neg (q and r)) imp ((p dimp r) or q)), !.		% true
?- checkExpression((p and q) imp (p or r)), !.							% true
?- checkExpression((p and q) or (q imp p)), !.							% true
?- checkExpression((p imp q) dimp (neg q imp p)), !.					% true
?- checkExpression(((neg p imp q) and (neg p imp neg q)) imp p), !.		% true
?- checkExpression(((p imp q) imp q) imp p), !.							% true
?- checkExpression(((q imp r) imp (p imp q)) imp (p imp q)), !.			% true
?- checkExpression(p imp (q imp (q imp p))), !.							% true
?- checkExpression((p dimp q) dimp (p dimp (q dimp p))), !.				% true
?- checkExpression(neg (p imp q) imp p), !.								% true
*/
