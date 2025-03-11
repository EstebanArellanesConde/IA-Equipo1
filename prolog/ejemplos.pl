% sumlist
sumlist([],0).
sumlist([H|T],R0):- sumlist(T,R1),
                    R0 is H + R1.

% find(X,L) is true if X is in list L.
find(X,[X|_]).
find(X,[_|T]):- find(X,T).
