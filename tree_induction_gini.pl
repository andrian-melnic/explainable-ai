/*
programma per apprendere inducendo Alberi di Decisione testandone
l' efficacia
*/


%:- ensure_loaded(stroke_dataset_tot).
:- ensure_loaded(aa_stroke_dataset).
:- ensure_loaded(aa_training_set).
:- ensure_loaded(aa_test_set).
:- ensure_loaded(classify).
:- ensure_loaded(writes).

:- dynamic alb/1.

induce_albero( Albero ) :-
	findall( e(Classe,Oggetto), e(Classe,  Oggetto), Esempi),
	findall( Att,a(Att,_), Attributi),
	induce_albero( Attributi, Esempi, Albero),
	mostra( Albero ),
	txt( Albero ),
	assert(alb(Albero)),
	stampa(Albero).


/*
induce_albero( +Attributi, +Esempi, -Albero):
l'Albero indotto dipende da questi tre casi:
(1) Albero = null: l'insieme degli esempi è vuoto
(2) Albero = l(Classe): tutti gli esempi sono della stessa classe
(3) Albero = t(Attributo, [Val1:SubAlb1, Val2:SubAlb2, ...]):
    gli esempi appartengono a più di una classe
    Attributo è la radice dell'albero
    Val1, Val2, ... sono i possibili valori di Attributo
    SubAlb1, SubAlb2,... sono i corrispondenti sottoalberi di
    decisione.
(4) Albero = l(Classi): non abbiamo Attributi utili per
	discriminare ulteriormente
*/


induce_albero( _, [], null ) :- !. % (1)

induce_albero( _, [e(Classe,_)|Esempi], l(Classe)) :-           % (2)
	\+ ( member(e(ClassX,_),Esempi), ClassX \== Classe ), !.	% no esempi di altre classi (OK!!)

induce_albero( Attributi, Esempi, t(Attributo,SAlberi) ) :-	    % (3)
	sceglie_attributo( Attributi, Esempi, Attributo), !,	    % implementa la politica di scelta
	del( Attributo, Attributi, Rimanenti ),					    % elimina Attributo scelto
	a( Attributo, Valori ),					 				    % ne preleva i valori
	induce_alberi( Attributo, Valori, Rimanenti, Esempi, SAlberi).

%finiti gli attributi utili (KO!!)
induce_albero( _, Esempi, l(ClasseDominante)) :-
	findall( Classe, member(e(Classe,_), Esempi), Classi),
	verify_occurrences(Classi, ClasseDominante).

verify_occurrences(Classi, X):-
	(occurrences(Classi, sick, healthy)) ->
	(calc_classe_dominante(true, Classi, X));
	(calc_classe_dominante(false, Classi, X)).

calc_classe_dominante(true, _, [sick, healthy]).
calc_classe_dominante(false, Classi, ClasseDominante):-
	calc_prob_classi(Classi, ClasseDominante).

% ################## Utility ##################
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

/*
sceglie_attributo( +Attributi, +Esempi, -MigliorAttributo):
seleziona l'Attributo che meglio discrimina le classi
*/
sceglie_attributo( Attributi, Esempi, MigliorAttributo) :-
	bagof( Dis/At,
		(member(At,Attributi) , disuguaglianza(Esempi,At,Dis)),
		Disis),
		min_dis(Disis, _, MigliorAttributo).

%TODO: verifica cosa fa '=' perche non lo sappiamo
%NON FUNZIONA SU WINDOWS :(
% min_dis([(H/A)|T], Y, Best):-
% 	min_dis(T, X, Best_X),
%     (H > X ->
%     	(H = Y, A = Best);
%     	(Y = X, Best = Best_X)).
% min_dis([(X/A)], X, A).

min_dis([ (X/A) ], X, A).
min_dis([ (H/A)|T ], Y, Best):-
	min_dis(T, X, Best_X),
	(H<X ->
		(H=Y, A = Best);
		(Y=X, Best = Best_X)).
/*
disuguaglianza(+Esempi, +Attributo, -Dis):
Dis è la disuguaglianza combinata dei sottoinsiemi degli esempi
partizionati dai valori dell'Attributo
*/

disuguaglianza( Esempi, Attributo, Dis) :-
	a( Attributo, AttVals),
	somma_pesata( Esempi, Attributo, AttVals, 0, Dis).

/*
somma_pesata( +Esempi, +Attributo, +AttVals, +SommaParziale, -Somma)
restituisce la Somma pesata delle disuguaglianze
Gini = sum from{v} P(v) * sum from{i <> j} P(i|v)*P(j|v)
*/
somma_pesata( _, _, [], Somma, Somma).
somma_pesata( Esempi, Att, [Val|Valori], SommaParziale, Somma) :-
	length(Esempi,N),												% quanti sono gli esempi
	findall(C,														% EsempiSoddisfatti: lista delle classi ..
			(member(e(C,Desc),Esempi) , soddisfa(Desc,[Att=Val])),	% .. degli esempi (con ripetizioni)..
			EsempiSoddisfatti),				     					% .. per cui Att=Val
	length(EsempiSoddisfatti, NVal),	% quanti sono questi esempi
	NVal > 0, !,						% almeno uno!
	findall(P,							% trova tutte le P robabilità
			(bagof(1, member(_,EsempiSoddisfatti), L), length(L,NVC), P is NVC/NVal),
			ClDst),

	gini(ClDst,Gini),
	NuovaSommaParziale is SommaParziale + Gini * (NVal/N),
	somma_pesata(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata(Esempi,Att,Valori,SommaParziale,Somma). 			% nessun esempio soddisfa Att = Val

/*
gini(ListaProbabilità, IndiceGini)
    IndiceGini = SOMMATORIA Pi*Pj per tutti i,j tali per cui i\=j
    E' equivalente a 1 - SOMMATORIA Pi*Pi su tutti gli i
*/
gini(ListaProbabilità,Gini) :-
	somma_quadrati(ListaProbabilità,0,SommaQuadrati),
	Gini is 1-SommaQuadrati.
somma_quadrati([],S,S).
somma_quadrati([P|Ps],PartS,S)  :-
	NewPartS is PartS + P*P,
	somma_quadrati(Ps,NewPartS,S).

/*
induce_alberi(Attributi, Valori, AttRimasti, Esempi, SAlberi):
induce decisioni SAlberi per sottoinsiemi di Esempi secondo i Valori
degli Attributi
*/
induce_alberi(_,[],_,_,[]).    % nessun valore, nessun sotto albero
induce_alberi(Att,[Val1|Valori],AttRimasti,Esempi,[Val1:Alb1|Alberi])  :-
	attval_subset(Att=Val1,Esempi,SottoinsiemeEsempi),
	induce_albero(AttRimasti,SottoinsiemeEsempi,Alb1),
	induce_alberi(Att,Valori,AttRimasti,Esempi,Alberi).

/*
	attval_subset( Attributo = Valore, Esempi, Subset):
	Subset è il sottoinsieme di Examples che soddisfa la condizione
	Attributo = Valore
*/
attval_subset(AttributoValore,Esempi,Sottoinsieme) :-
	findall(e(C,O),
			(member(e(C,O),Esempi),
			soddisfa(O,[AttributoValore])),
			Sottoinsieme).

% soddisfa(Oggetto, Descrizione):
soddisfa(Oggetto,Congiunzione) :-
	\+ (member(Att=Val,Congiunzione),
		member(Att=ValX,Oggetto),
		ValX \== Val).

del(T,[T|C],C) :- !.
del(A,[T|C],[T|C1]) :-
	del(A,C,C1).
