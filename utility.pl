/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * utility.pl
 ***/	


/*
 *	calc_classe_dominante(+Classi, -ClasseDominante) 
 *	+Classi 			= lista di foglie risultanti (es. [sick, healthy, healthy])
 *	-ClasseDominante	= classe con maggiori occorrenze in Classi (es. healthy)
 *	se non esiste classe dominante (probabilità 1/2) si riporta la foglia [sick, healthy]
 */
calc_classe_dominante(_, [sick, healthy]):-
	occurrences(_, sick, healthy).
calc_classe_dominante(Classi, ClasseDominante):-
	\+ occurrences(Classi, sick, healthy),
	calc_prob_classi(Classi, ClasseDominante).

/*
 *	occurrences(+Classi, -Classe1, -Classe2) 
 * 	verifica le occorrenze delle due classi nella lista di foglie Classi
 */
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

/*
 *	calc_prob_classi(+Lista, -Classe)
 * 	ricava Classe con il maggior numero di occorrenze in Lista
 */
calc_prob_classi(List, X) :-
    aggregate(max(N1, X1), conteggio_elementi(X1, N1, List), max(N1, X)).
% versione con Occorrenze come output
% calc_prob_classi(L, N, X) :-
%    aggregate(max(N1,X1), conteggio_elementi(X1,N1,L), max(N,X)).

/*
 *	conteggio_elementi(-X, -Count, +Lista)
 * 	conta le occorrenze di X in Lista
 */
conteggio_elementi(X, Count, List) :-
    aggregate(count, member(X, List), Count).

/*
 *	log2(+P, -Log2ris)
 * 	predicato per il calcolo del logaritmo in base 2 
 */
log2(P, Log2ris):-
	log(P,X),
	log(2,Y),
	Log2ris is X/Y.

/*
 *	del(-Attributo, -Attributi, -AttributiRimanenti)
 * 	+Attributo			= attributo da rimuovere
 * 	+Attributi 			= lista degli attributi dal quale rimuovere Attributo
 * 	-AttributiRimanenti	= lista degli attributi rimanenti in seguito alla rimozione
 */
del(T,[T|C],C) :- !.
del(A,[T|C],[T|C1]) :-
	del(A,C,C1).