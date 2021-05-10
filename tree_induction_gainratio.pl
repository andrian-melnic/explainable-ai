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
	txt( Albero, './alberi/albero_gainratio.txt' ),
	assert(alb(Albero)),
	stampa_matrice_di_confusione_txt('./matrici/matrice_gainratio.txt').


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
	%sceglie_attributo( Attributi, Esempi, 0, Attributo), !,
	del( Attributo, Attributi, Rimanenti ),					    % elimina Attributo scelto
	a( Attributo, Valori ),					 				    % ne preleva i valori
	induce_alberi( Attributo, Valori, Rimanenti, Esempi, SAlberi).

%finiti gli attributi utili (KO!!)
induce_albero( _, Esempi, l(ClasseDominante)) :-
	findall( Classe, member(e(Classe,_), Esempi), Classi),
	calc_classe_dominante(Classi, ClasseDominante).


/*
sceglie_attributo( +Attributi, +Esempi, -MigliorAttributo):
seleziona l'Attributo che meglio discrimina le classi
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
	somma_pesata_shannon(Esempi, Attributo, AttVals, 0, SpShannon),
	somma_gain_ratio(Esempi, Attributo, AttVals, 0, SpGain),
	Gain is EntropiaDataset - SpShannon,
	controllo(Gain, SpGain, Dis).

% procedura per evitare la divisione con lo 0
% ottenuto nel momento in cui la lista e' vuota
controllo(_, 0.0, 0):- !.
controllo(_, 0, 0):- !.
controllo(Gain, Sp, GainRatio):-
	% Dis is Gain Ratio xP
	GainRatio is Gain/(-Sp).

/* TODO: Da rimuovere ma verifica
controllo(Gain, Sp, GainRatio):-
	(Sp = 0.0) -> GainRatio is 0 ;
	(
		% Dis is Gain Ratio xP
		GainRatio is Gain/(-Sp)
	).
*/

% entropiaDataset(_, EntropiaDataset)
entropiaDataset(Esempi, EntropiaDataset) :-
	findall(sick,
			(member(e(sick, _),Esempi)), EsempiSick),
	length(Esempi, N),
	length(EsempiSick, NSick),
	PSick is NSick/N,
	entropia(PSick, EntropiaDataset).


sommatoria(Esempi, Att, Val, Qattr, P_va):-
	length(Esempi,N),
	findall(C,
			(member(e(C,Desc),Esempi) , soddisfa(Desc,[Att=Val])),
			EsempiSoddisfatti),
	length(EsempiSoddisfatti, NVal),

	findall(P,
			(bagof(1, member(sick,EsempiSoddisfatti), L), length(L,NVC), P is NVC/NVal),
			Q),
	nth0(0, Q, Qattr),
	P_va is (NVal/N).


somma_pesata_shannon( _, _, [], Somma, Somma).
somma_pesata_shannon( Esempi, Att, [Val|Valori], SommaParziale, Somma) :-
	sommatoria(Esempi, Att, Val, Qattr, P_va),
	Qattr > 0, !,

	entropia(Qattr, EntropiaAttr),
	NuovaSommaParziale is SommaParziale + (P_va) * EntropiaAttr ,
	somma_pesata_shannon(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata_shannon(Esempi,Att,Valori,SommaParziale,Somma).

% Sommatoria gain ratio
somma_gain_ratio( _, _, [], Somma_g, Somma_g).
somma_gain_ratio( Esempi, Att, [Val|Valori], SommaParziale_g, Somma_g) :-
	sommatoria(Esempi, Att, Val, Qattr, P_va),
	Qattr > 0, !,

	log2(P_va, X),
	NuovaSommaParziale_g is SommaParziale_g + P_va * X,

	somma_gain_ratio(Esempi,Att,Valori,NuovaSommaParziale_g,Somma_g)
	;
	somma_gain_ratio(Esempi,Att,Valori,SommaParziale_g,Somma_g).

% TODO: IDEA accorpare sommatorie in un unico predicato
% perchè per il momento non è ottimizzato.



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
