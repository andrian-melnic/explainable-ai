/*
programma per apprendere inducendo Alberi di Decisione testandone
l' efficacia
*/

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

induce_albero( Albero ) :-
	findall( e(Classe,Oggetto), e(Classe,  Oggetto), Esempi),
	findall( Att,a(Att,_), Attributi),
	induce_albero( Attributi, Esempi, Albero),
	mostra( Albero ),
	txt( Albero, './alberi/albero_gain.txt' ),
	assert(alb(Albero)),
    stampa_matrice_di_confusione_txt('./matrici/matrice_gain.txt').


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
	calc_classe_dominante(Classi, ClasseDominante).


/*
sceglie_attributo( +Attributi, +Esempi, -MigliorAttributo):
seleziona l'Attributo che meglio discrimina le classi; si basa sul
concetto della "Gini-disuguaglianza"; utilizza il setof per ordinare
gli attributi in base al valore crescente della loro disuguaglianza
usare il setof per far questo è dispendioso e si può fare di meglio ..
*/

sceglie_attributo( Attributi, Esempi, MigliorAttributo) :-
	bagof( Dis/At,
		(member(At,Attributi) , disuguaglianza(Esempi,At,Dis)),
		Disis),
		max_dis(Disis, _, MigliorAttributo).

max_dis([ (X/A) ], X, A).
max_dis([ (H/A)|T ], Y, Best):-
	max_dis(T, X, Best_X),
	(H>X ->
		(H=Y, A = Best);
		(Y=X, Best = Best_X)).

/*
disuguaglianza(+Esempi, +Attributo, -Dis):
Dis è la disuguaglianza combinata dei sottoinsiemi degli esempi
partizionati dai valori dell'Attributo
*/
disuguaglianza( Esempi, Attributo, Dis) :-
	a( Attributo, AttVals),
	entropiaDataset(Esempi, EntropiaDataset),
	% fino a qui va bene arriva tutto
	somma_pesata_shannon(Esempi, Attributo, AttVals, 0, SpShannon),
	Dis is EntropiaDataset - SpShannon.

% entropiaDataset(_, EntropiaDataset)
entropiaDataset(Esempi, EntropiaDataset) :-
	findall(sick,
			(member(e(sick, _),Esempi)), EsempiSick),
	length(Esempi, N),
	length(EsempiSick, NSick),
	PSick is NSick/N,
	entropia(PSick, EntropiaDataset).


somma_pesata_shannon( _, _, [], Somma, Somma).
somma_pesata_shannon( Esempi, Att, [Val|Valori], SommaParziale, Somma) :-

	length(Esempi,N),
	findall(C,
			(member(e(C,Desc),Esempi) , soddisfa(Desc,[Att=Val])),
			EsempiSoddisfatti),
	length(EsempiSoddisfatti, NVal),

	findall(P,
			(bagof(1, member(sick,EsempiSoddisfatti), L), length(L,NVC), P is NVC/NVal),
			Q),
	nth0(0, Q, Qattr),
	Qattr > 0, !,
	entropia(Qattr, EntropiaAttr),

	NuovaSommaParziale is SommaParziale + (NVal/N) * EntropiaAttr ,
	somma_pesata_shannon(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata_shannon(Esempi,Att,Valori,SommaParziale,Somma).

/* B(q) = -[(q)log_2(q) + (1-q)log_2(1-q)] */
entropia(1, 0):- !.
entropia(Q, H):-
	InvQ is 1-Q,
	log2(Q, LogQ),
	log2(InvQ, LogInvQ),
	H is -((Q * LogQ) + (InvQ * LogInvQ)).


/*
induce_alberi(Attributi, Valori, AttRimasti, Esempi, SAlberi):
induce decisioni SAlberi per sottoinsiemi di Esempi secondo i Valori
degli Attributi
*/
induce_alberi(_,[],_,_,[]).   % nessun valore, nessun sotto albero
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
