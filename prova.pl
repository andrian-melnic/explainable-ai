div(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N).

startt :-
    X = [healthy,healthy,sick,sick,sick],
    occurrences(X, sick, healthy)->(
        write('funza')
    );
    (
        write('nope')

    ).

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
calc_prob_classi(List, X) :-
    aggregate(max(N1, X1), conteggio_elementi(X1, N1, List), max(N1, X)).
conteggio_elementi(X, Count, List) :-
    aggregate(count, member(X, List), Count).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start :-
    div([healthy,healthy,sick,sick],X,Y)->(
        prova(X, Y, Z),
        write(Z)
    );
    (
        write('nope1')
    ).

prova(X, Y, Z) :-
    equal_elements(X, Y)->(
        Z = [healthy, sick]
    );
    (
        Z = healthy
    ).

equal_elements(List1, List2) :-
    sort(List1, Sorted1),
    sort(List2, Sorted2),
    Sorted1 == Sorted2.



/* classe_dominante(X, Y, Z):-
    (equal_elements(X, Y)->(
        %Z = [1,2],
        write('yes2')
    );
    (
        write('nope2')
    ). */
/* classe_dominante(false, Classi, ClasseDominante):- 
	calc_prob_classi(Classi, ClasseDominante). */
    