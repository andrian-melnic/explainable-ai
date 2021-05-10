/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * <descrizione progetto>
 * <autori>
 ***/

:- ensure_loaded(tree_induction_gini).
:- ensure_loaded(tree_induction_gain).
:- ensure_loaded(tree_induction_gainratio).

:- ensure_loaded(classify).
:- ensure_loaded(writes).
:- ensure_loaded(utility).



% :- ensure_loaded(data/old_stroke_dataset).
% :- ensure_loaded(data/old_stroke_training_set).
% :- ensure_loaded(data/old_stroke_test_set).
:- ensure_loaded(data/stroke_dataset).
:- ensure_loaded(data/stroke_training_set).
:- ensure_loaded(data/stroke_test_set).

:- dynamic alb/1.

/*
 * @Parametro = gini|gain|gainratio -> induzione albero con politica di scelta dell'attributo indicata
*/
% Rimozione delle clausole di alb precedentemente asserite
induce_albero(Parametro, Albero) :-
    alb(_),
    retractall(alb(_)),
    induce_albero(Parametro, Albero).

induce_albero(Parametro, Albero) :-
    \+ alb(_),
	findall( e(Classe,Oggetto), e(Classe,  Oggetto), Esempi),
	findall( Att,a(Att,_), Attributi),
	induce_albero(Parametro, Attributi, Esempi, Albero),

    % output albero su terminale e assert
	mostra( Albero ),
    assert(alb(Albero)),

    % scrittura albero su file .txt
    atom_concat('./alberi/albero_', Parametro, PTreeFileName),
    atom_concat(PTreeFileName, '.txt', TreeFileName),
    txt( Albero, TreeFileName ),

    % scrittura matrice di confusione su file .txt
    atom_concat('./matrici/matrice_', Parametro, PMatrixFileName),
    atom_concat(PMatrixFileName, '.txt', MatrixFileName),
    stampa_matrice_confusione_txt(Albero, MatrixFileName).


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
induce_albero(_, _, [], null ) :- !. % (1)
induce_albero(_, _, [e(Classe,_)|Esempi], l(Classe)) :-                         % (2)
	\+ ( member(e(ClassX,_),Esempi), ClassX \== Classe ), !.	                % no esempi di altre classi (OK!!)
induce_albero(Parametro, Attributi, Esempi, t(Attributo,SAlberi) ) :-	        % (3)
	sceglie_attributo(Parametro, Attributi, Esempi, Attributo), !,	            % implementa la politica di scelta
	del( Attributo, Attributi, Rimanenti ),					                    % elimina Attributo scelto
	a( Attributo, Valori ),					 				                    % ne preleva i valori
	induce_alberi( Parametro, Attributo, Valori, Rimanenti, Esempi, SAlberi).
induce_albero(_, _, Esempi, l(ClasseDominante)) :-                              %finiti gli attributi utili (KO!!)
	findall( Classe, member(e(Classe,_), Esempi), Classi),
	calc_classe_dominante(Classi, ClasseDominante).

/*
sceglie_attributo( +Attributi, +Esempi, -MigliorAttributo):
seleziona l'Attributo che meglio discrimina le classi
TODO: verificare se si può fare meglio
*/
sceglie_attributo(gini, Attributi, Esempi, MigliorAttributo) :-
    bagof(Dis/At, (member(At,Attributi) , disuguaglianza_gini(Esempi,At,Dis)), Disis),
    min_dis(Disis, _, MigliorAttributo).
sceglie_attributo(gain, Attributi, Esempi, MigliorAttributo) :-
    bagof(Dis/At, (member(At,Attributi) , disuguaglianza_gain(Esempi,At,Dis)), Disis),
    max_dis(Disis, _, MigliorAttributo).
sceglie_attributo(gainratio, Attributi, Esempi, MigliorAttributo) :-
    bagof(Dis/At, (member(At,Attributi) , disuguaglianza_gainratio(Esempi,At,Dis)), Disis),
    max_dis(Disis, _, MigliorAttributo).

% Gain e GainRation , da commentare
max_dis([ (X/A) ], X, A).
max_dis([ (H/A)|T ], Y, Best):-
	max_dis(T, X, Best_X),
	(H>X ->
		(H=Y, A = Best);
		(Y=X, Best = Best_X)).

% Gini, da commentare
min_dis([ (X/A) ], X, A).
min_dis([ (H/A)|T ], Y, Best):-
	min_dis(T, X, Best_X),
	(H<X ->
		(H=Y, A = Best);
		(Y=X, Best = Best_X)).

/*
induce_alberi(Attributi, Valori, AttRimasti, Esempi, SAlberi):
induce decisioni SAlberi per sottoinsiemi di Esempi secondo i Valori
degli Attributi
*/
induce_alberi(_,_,[],_,_,[]). % nessun valore, nessun sotto albero
induce_alberi(Parametro, Att,[Val1|Valori],AttRimasti,Esempi,[Val1:Alb1|Alberi])  :-
	attval_subset(Att=Val1,Esempi,SottoinsiemeEsempi),
	induce_albero(Parametro,AttRimasti,SottoinsiemeEsempi,Alb1),
	induce_alberi(Parametro,Att,Valori,AttRimasti,Esempi,Alberi).

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


