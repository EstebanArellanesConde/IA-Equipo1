% sumlist
sumlist([],0).
sumlist([H|T],R0):- sumlist(T,R1),
                    R0 is H + R1.

% find(X,L) is true if X is in list L.
find(X,[X|_]).
find(X,[_|T]):- find(X,T).

% Factorial de un numero

factorial(0,1).
factorial(1,1).
factorial(N,R):-
    N0 is N - 1,
    factorial(N0,R0),
    R is N*R0.

% Producto cartesiano

pc([H1],[H2],[[H1,H2]]).
pc([H1],[H2|T1],[[H1,H2]|T2]):-
    pc([H1],T1,T2).
pc([H1|T1],L2,R3):-
    pc([H1],L2,R1),
    pc(T1,L2,R2),
    append(R1,R2,R3).
