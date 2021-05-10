/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * <descrizione progetto>
 * <autori>
 ***/

:- ensure_loaded(classify).
:- ensure_loaded(writes).
:- ensure_loaded(utility).

% :- ensure_loaded(data/old_stroke_dataset).
% :- ensure_loaded(data/old_stroke_training_set).
% :- ensure_loaded(data/old_stroke_test_set).
:- ensure_loaded(data/stroke_dataset).
:- ensure_loaded(data/stroke_training_set).
:- ensure_loaded(data/stroke_test_set).

%:- dynamic alb/1.

/*
 * @Parametro = gini|gain|gainratio -> induzione albero con politica di scelta dell'attributo indicata
*/
induce_albero(Parametro, Albero) :-
	findall( e(Classe,Oggetto), e(Classe,  Oggetto), Esempi),
	findall( Att,a(Att,_), Attributi),
	induce_albero(Parametro, Attributi, Esempi, Albero),

    % output albero su terminale e assert
	mostra( Albero ),
    % TODO: verificare se si può reimplementare l'assert con lo stato attuale del programma
    %assert(alb(Albero)),

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

% #################################################### INIZIO: Gini ####################################################
% da commentare
disuguaglianza_gini(Esempi, Attributo, Dis) :-
	a(Attributo, AttVals),
	somma_pesata(Esempi, Attributo, AttVals, 0, Dis).

% da commentare
somma_pesata(_, _, [], Somma, Somma).
somma_pesata(Esempi, Att, [Val|Valori], SommaParziale, Somma) :-
	length(Esempi,N),												        % quanti sono gli esempi
	findall(C,														        % EsSodd: lista delle classi ..
			(member(e(C,Desc),Esempi) , soddisfa(Desc,[Att=Val])),	        % .. degli esempi (con ripetizioni)..
			EsSodd),				     					                % .. per cui Att=Val
	length(EsSodd, NVal),	                                                % quanti sono questi esempi
	NVal > 0, !,						                                    % almeno uno!
	findall(P,							                                    % trova tutte le P probabilità
			(bagof(1, member(_,EsSodd), L), length(L,NVC), P is NVC/NVal),
			ClDst),
    gini(ClDst,Gini),
	NuovaSommaParziale is SommaParziale + Gini * (NVal/N),
	somma_pesata(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata(Esempi,Att,Valori,SommaParziale,Somma). 			        % nessun esempio soddisfa Att = Val

% da commentare
gini(ListaProbabilità, Gini) :-
	somma_quadrati(ListaProbabilità, 0, SommaQuadrati),
	Gini is 1 - SommaQuadrati.

% da commentare
somma_quadrati([],S,S).
somma_quadrati([P|Ps],PartS,S)  :-
	NewPartS is PartS + P*P,
	somma_quadrati(Ps,NewPartS,S).
% #################################################### FINE: Gini ######################################################



% #################################################### INIZIO: Gain ####################################################
% da commentare
disuguaglianza_gain(Esempi, Attributo, Dis) :-
	a(Attributo, AttVals),
	entropiaDataset(Esempi, EntropiaDataset),
	somma_pesata_shannon(Esempi, Attributo, AttVals, 0, SpShannon),
	Dis is EntropiaDataset - SpShannon.

% da commentare
entropiaDataset(Esempi, EntropiaDataset) :-
	findall(sick, (member(e(sick, _),Esempi)), EsempiSick),
	length(Esempi, N),
	length(EsempiSick, NSick),
	PSick is NSick/N,
	entropia(PSick, EntropiaDataset).

% da commentare
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

% B(q) = -[(q)log_2(q) + (1-q)log_2(1-q)] 
entropia(1, 0):- !.
entropia(Q, H):-
	InvQ is 1-Q,
	log2(Q, LogQ),
	log2(InvQ, LogInvQ),
	H is -((Q * LogQ) + (InvQ * LogInvQ)).
% #################################################### INIZIO: Gain ####################################################



% ################################################## INIZIO: GainRatio #################################################
% da commentare
disuguaglianza_gainratio( Esempi, Attributo, Dis) :-
	a( Attributo, AttVals),
	entropiaDataset(Esempi, EntropiaDataset),
	somma_pesata_shannon_gr(Esempi, Attributo, AttVals, 0, SpShannon),
	somma_gain_ratio(Esempi, Attributo, AttVals, 0, SpGain),
	Gain is EntropiaDataset - SpShannon,
	controllo(Gain, SpGain, Dis).

% procedura per evitare la divisione per zero nell'iterazione in cui la lista risulta vuota
controllo(_, 0.0, 0):- !.
controllo(_, 0, 0):- !.
controllo(Gain, Sp, GainRatio):-
	GainRatio is Gain/(-Sp).

% da commentare
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

% da commentare
somma_pesata_shannon_gr(_, _, [], Somma, Somma).
somma_pesata_shannon_gr(Esempi, Att, [Val|Valori], SommaParziale, Somma) :-
	sommatoria(Esempi, Att, Val, Qattr, P_va),
	Qattr > 0, !,
	entropia(Qattr, EntropiaAttr),
	NuovaSommaParziale is SommaParziale + (P_va) * EntropiaAttr ,
	somma_pesata_shannon_gr(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata_shannon_gr(Esempi,Att,Valori,SommaParziale,Somma).

% da commentare
somma_gain_ratio(_, _, [], Somma_g, Somma_g).
somma_gain_ratio(Esempi, Att, [Val|Valori], SommaParziale_g, Somma_g) :-
	sommatoria(Esempi, Att, Val, Qattr, P_va),
	Qattr > 0, !,
	log2(P_va, X),
	NuovaSommaParziale_g is SommaParziale_g + P_va * X,
	somma_gain_ratio(Esempi,Att,Valori,NuovaSommaParziale_g,Somma_g)
	;
	somma_gain_ratio(Esempi,Att,Valori,SommaParziale_g,Somma_g).
% ################################################## INIZIO: GainRatio #################################################

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


