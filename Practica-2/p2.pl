:-op(1,fx,neg).
:-op(2,xfx,or).
:-op(2,xfx,and).
:-op(2,xfx,imp).
:-op(2,xfx,dimp).

trans(F,F):- atom(F).
trans(neg F, neg G):- trans(F, G).
trans(F1 or F2, G1 or G2):-
    trans(F1,G1),
    trans(F2,G2).
trans(F1 and F2, neg((neg G1) or (neg G2))):-
    trans(F1,G1),
    trans(F2,G2).
trans(F1 imp F2, (neg G1) or G2):-
    trans(F1,G1),
    trans(F2,G2).
trans(F1 dimp F2, R):-
    trans((F1 imp F2) and (F2 imp F1),R).
    
checkModel(F, Model, Value):-
    trans(F, F1),
    eval(F1, Model, Value).

eval(Atom, Model, Value):- member(Atom-Value, Model), !.
    
eval(neg F, Model, 1):-
    eval(F, Model, 0).
eval(neg F, Model, 0):-
    eval(F, Model, 1).

eval(F1 or F2, Model, 1):-
    eval(F1, Model, 1);
    eval(F2, Model, 1).
eval(F1 or F2, Model, 0):-
    eval(F1, Model, 0),
    eval(F2, Model, 0).
