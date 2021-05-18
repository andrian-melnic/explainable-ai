/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * tree_induction.pl
 ***/	


% import predicati per gestione politiche di scelta
:- ensure_loaded(indexes_policy/gini_index).
:- ensure_loaded(indexes_policy/information_gain).
:- ensure_loaded(indexes_policy/gain_ratio).
% imports utilities e predicati per la classificazione e verifica dell'accuratezza
:- ensure_loaded(classify).
:- ensure_loaded(writes).
:- ensure_loaded(utility).

:- dynamic alb/1.


/*
 *	carica_dataset(+dataset)
 * 	+dataset = caricamento dataset indicato
 */
carica_dataset(Dataset) :-
	concat_path_dataset(Dataset, PathDataset, PathTraining, PathTest),
	ensure_loaded(PathDataset),
	ensure_loaded(PathTraining),
	ensure_loaded(PathTest).

/*
 *	reset_dataset(+dataset)
 * 	+dataset = rimozione dataset indicato
 */
reset_dataset(Dataset) :-
	concat_path_dataset(Dataset, PathDataset, PathTraining, PathTest),
	unload_file(PathDataset),
	unload_file(PathTraining),
	unload_file(PathTest).

/*
 *	induci_alberi
 * 	predicato per lanciare l'induzione degli alberi in un'unica soluzione
 */
induci :-
	induce_albero(gini, _),
	induce_albero(gain, _),
	induce_albero(gainratio, _).

/*
 *	induce_albero(+Parametro, -Albero) 
 *	+Parametro 	= gini|gain|gainratio -> induzione albero con politica di scelta dell'attributo indicata
 *	-Albero		= albero indotto  
 */
induce_albero(Parametro, Albero) :-
	% Rimozione di 'alb' dal database se precedentemente asserito
	retractall(alb(_)),											
	findall( e(Classe,Oggetto), e(Classe,  Oggetto), Esempi),
	findall( Att,a(Att,_), Attributi),
	induce_albero(Parametro, Attributi, Esempi, Albero),

    % output albero su terminale e assert di quest'ultimo
	% mostra( Albero ),
    assert(alb(Albero)),

    % scrittura albero su file .txt
    atom_concat('./output/tree/tree_', Parametro, PTreeFileName),
    atom_concat(PTreeFileName, '.txt', TreeFileName),
    txt( Albero, TreeFileName ),
	
	% log su terminale
	atom_concat('Albero salvato in /output/tree/', Parametro, LogTree),
	writeln(LogTree),

    % scrittura matrice di confusione su file .txt
    atom_concat('./output/matrix/matrix_', Parametro, PMatrixFileName),
    atom_concat(PMatrixFileName, '.txt', MatrixFileName),
    stampa_matrice_confusione_txt(MatrixFileName),

	% log su terminale
	atom_concat('Matrice di confusione salvata in /output/tree/', Parametro, LogMatrix),
	writeln(LogMatrix), write('\n').


/*
 * 	induce_albero(+Parametro, +Attributi, +Esempi, -Albero):
 *	-Albero = 	(1) null 		-> 	l'insieme degli esempi è vuoto
 *				(2) l(Classe) 	-> 	tutti gli esempi sono della stessa classe
 * 				(3) t(Attributo,
 *	 				[Val1:SubAlb1, Val2:SubAlb2, ...]):
 *					 			-> 	gli esempi appartengono a più di una classe
 *									Attributo è la radice dell'albero
 *									Val1, Val2, ... sono i possibili valori di Attributo
 *   								SubAlb1, SubAlb2,... sono i corrispondenti
 *  								sottoalberi di decisione.
 * 
 *				(4) l(Classi) 	->	non abbiamo Attributi utili per discriminare ulteriormente
 */
induce_albero(_, _, [], null ) :- !. 											% (1)
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
 * sceglie_attributo(+Attributi, +Esempi, -MigliorAttributo):
 * seleziona l'Attributo che meglio discrimina le classi basandosi sul concetto di "disuguaglianza"
 * utilizza il bagof per raccogliere gli attributi con i corrispettivi valori e si seleziona il valore 
 * minore/maggiore in base alla politica di scelta dell'attributo. 
 * (1) sceglie_attributo(gini, ...) 		-> predicato per la scelta dell'attributo secondo indice di C. Gini
 * (2) sceglie_attributo(gain, ...) 		-> predicato per la scelta dell'attributo tramite entropia information gain
 * (3) sceglie_attributo(gainratio, ...) 	-> predicato per la scelta dell'attributo tramite entropia gain ratio
 */
sceglie_attributo(gini, Attributi, Esempi, MigliorAttributo) :-
    bagof(Dis/At, (member(At,Attributi) , disuguaglianza_gini(Esempi,At,Dis)), Disis),			%(1)
    min_dis(Disis, _, MigliorAttributo).
sceglie_attributo(gain, Attributi, Esempi, MigliorAttributo) :-
    bagof(Dis/At, (member(At,Attributi) , disuguaglianza_gain(Esempi,At,Dis)), Disis),			%(2)
    max_dis(Disis, _, MigliorAttributo).
sceglie_attributo(gainratio, Attributi, Esempi, MigliorAttributo) :-
    bagof(Dis/At, (member(At,Attributi) , disuguaglianza_gainratio(Esempi,At,Dis)), Disis),		%(3)
    max_dis(Disis, _, MigliorAttributo).

/*
 *	max_dis(+ListaCoppieValAtt, -ValoreMaggiore, -AttributoMigliore)
 * 	predicato per ricavare il valore maggiore assieme al corrispondente attributo da una lista di coppie valore/attributo
 *  impiegato in gain e gain ratio dato che sono funzioni di massimizzazione 
 */
max_dis([ (X/A) ], X, A).
max_dis([ (H/A)|T ], Y, Best):-
	max_dis(T, X, Best_X),
	(H>=X ->
		(H=Y, A = Best);
		(Y=X, Best = Best_X)).

/*
 *	min_dis(+ListaCoppieValAtt, -ValoreMinore, -AttributoMigliore)
 * 	predicato per ricavare il valore minore assieme al corrispondente attributo da una lista di coppie valore/attributo
 *  impiegato in gini dato che e' una funzione di minimizzazione 
 */
min_dis([ (X/A) ], X, A).
min_dis([ (H/A)|T ], Y, Best):-
	min_dis(T, X, Best_X),
	(H=<X ->
		(H=Y, A = Best);
		(Y=X, Best = Best_X)).

/*
 * induce_alberi(+Parametro, +Attributi, +Valori, +AttRimasti, +Esempi, -SAlberi)
 * induce decisioni SAlberi per sottoinsiemi di Esempi secondo i Valori degli Attributi
 */
induce_alberi(_,_,[],_,_,[]). % nessun valore, nessun sotto albero
induce_alberi(Parametro, Att,[Val1|Valori],AttRimasti,Esempi,[Val1:Alb1|Alberi])  :-
	attval_subset(Att=Val1,Esempi,SottoinsiemeEsempi),
	induce_albero(Parametro,AttRimasti,SottoinsiemeEsempi,Alb1),
	induce_alberi(Parametro,Att,Valori,AttRimasti,Esempi,Alberi).

/*
 * attval_subset(+AttributoValore, +Esempi, -Sottoinsieme):
 * il termine Sottoinsieme è il sottoinsieme di Esempi che soddisfa la condizione Attributo = Valore
 */
attval_subset(AttributoValore,Esempi,Sottoinsieme) :-
	findall(e(C,O),
			(member(e(C,O),Esempi),
			soddisfa(O,[AttributoValore])),
			Sottoinsieme).

soddisfa(Oggetto, Congiunzione) :-
	\+ (member(Att=Val,Congiunzione),
		member(Att=ValX,Oggetto),
		ValX \== Val).
	