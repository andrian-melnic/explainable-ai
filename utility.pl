
% ================================== Utility ==================================

verify_occurrences(Classi, X):-
	(occurrences(Classi, sick, healthy)) ->
	(calc_classe_dominante(true, Classi, X));
	(calc_classe_dominante(false, Classi, X)).


calc_classe_dominante(true, _, [sick, healthy]).
calc_classe_dominante(false, Classi, ClasseDominante):-
	calc_prob_classi(Classi, ClasseDominante).


% versione con Occorrenze come output
%calc_prob_classi(L, N, X) :-
%   aggregate(max(N1,X1), conteggio_elementi(X1,N1,L), max(N,X)).



% ricava l'istanza con il maggior numero di occorrenze di X in una lista
calc_prob_classi(List, X) :-
    aggregate(max(N1, X1), conteggio_elementi(X1, N1, List), max(N1, X)).


% conteggio del numero di istanze Count di X in una lista
conteggio_elementi(X, Count, List) :-
    aggregate(count, member(X, List), Count).



occurrences([],_A,_B,N,N).
occurrences([H|T],A,B,N0,M0) :-
	elem_x_count(H,A,N1,N0),
	elem_x_count(H,B,M1,M0),
	occurrences(T,A,B,N1,M1).
occurrences(List,A,B) :-
	dif(A,B),
	occurrences(List,A,B,0,0).



elem_x_count(X,X,(Old+1),Old):- !.
elem_x_count(_,_,Old,Old):- !.
