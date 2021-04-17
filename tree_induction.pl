/*
programma per apprendere inducendo Alberi di Decisione testandone
l' efficacia
*/

:- ensure_loaded(stroke_dataset).
:- ensure_loaded(stroke_training_set).
:- ensure_loaded(stroke_test_set).

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
induce_albero( _, Esempi, l(Classi)) :-
	findall( Classe, member(e(Classe,_),Esempi), Classi).


/*
sceglie_attributo( +Attributi, +Esempi, -MigliorAttributo):
seleziona l'Attributo che meglio discrimina le classi; si basa sul
concetto della "Gini-disuguaglianza"; utilizza il setof per ordinare
gli attributi in base al valore crescente della loro disuguaglianza
usare il setof per far questo è dispendioso e si può fare di meglio ..
*/
sceglie_attributo( Attributi, Esempi, MigliorAttributo ) :-
	setof( Disuguaglianza/A,
		(member(A,Attributi) , disuguaglianza(Esempi,A,Disuguaglianza)),
		Disuguaglianze),
		last(Disuguaglianze, _/MigliorAttributo).

/*
disuguaglianza(+Esempi, +Attributo, -Dis):
Dis è la disuguaglianza combinata dei sottoinsiemi degli esempi
partizionati dai valori dell'Attributo
*/
disuguaglianza( Esempi, Attributo, Dis) :-
	a( Attributo, AttVals),

	entropiaDataset(Esempi, EntropiaDataset),
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
	length(Esempi,N),												% quanti sono gli esempi
	findall(C,														% EsempiSoddisfatti: lista delle classi ..
			(member(e(C,Desc),Esempi) , soddisfa(Desc,[Att=Val])),	% .. degli esempi (con ripetizioni)..
			EsempiSoddisfatti),				     					% .. per cui Att=Val
	length(EsempiSoddisfatti, NVal),	% quanti sono questi esempi
										% almeno uno!
	findall(P,							% trova tutte le P robabilità
			(bagof(1, member(sick,EsempiSoddisfatti), L), length(L,NVC), P is NVC/NVal),
			Q),
	nth0(0, Q, Qattr),
	entropia(Qattr, EntropiaAttr),
	NuovaSommaParziale is SommaParziale + EntropiaAttr * (NVal/N),	% Entropia attributo
	somma_pesata_shannon(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata_shannon(Esempi,Att,Valori,SommaParziale,Somma). 	% nessun esempio soddisfa Att = Val

goliardia(Q):-
	open('prova.txt', append, Out),
	write(Out,Q),
	writeln(Out, ' '),
	writeln(Out, ' '),
	close(Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

log2(P, Log2ris):-
	log(P,X),
	log(2,Y),
	Log2ris is X/Y.

/* B(q) = -[(q)log_2(q) + (1-q)log_2(1-q)] */
entropia(Q, H):-
	(Q = 1) -> H is 0 ;
	(InvQ is 1-Q,
	log2(Q, LogQ),
	log2(InvQ, LogInvQ),
	H is -((Q * LogQ) + (InvQ * LogInvQ))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
induce_alberi(Attributi, Valori, AttRimasti, Esempi, SAlberi):
induce decisioni SAlberi per sottoinsiemi di Esempi secondo i Valori
degli Attributi
*/
induce_alberi(_,[],_,_,[]).     												% nessun valore, nessun sotto albero
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

mostra(T) :-
	mostra(T,0).
mostra(null,_) :- writeln(' ==> ???').
mostra(l(X),_) :- write(' ==> '),writeln(X).
mostra(t(A,L),I) :-
	nl,tab(I),write(A),nl,I1 is I+2,
	mostratutto(L,I1).

mostratutto([],_).
mostratutto([V:T|C],I) :-
	tab(I),write(V), I1 is I+2,
	mostra(T,I1),
	mostratutto(C,I).

% Stampa albero formattato su file 
txt(T) :-
	open('output_formattato.txt', append, Out),
	txt(Out, T,0),
	close(Out).

txt(Out, null,_) :- 
	writeln(Out, ' ==> ???').
txt(Out, l(X),_) :- 
	write(Out, ' ==> '), writeln(Out, X).
txt(Out, t(A,L),I) :-
	writeln(Out, ' '),
	tab(Out, I), write(Out, A),
	writeln(Out, ' '), 
	I1 is I+2,
	txtTutto(Out, L,I1).

txtTutto(_, [],_).
txtTutto(Out, [V:T|C],I) :-
	tab(Out, I),write(Out, V), I1 is I+2,
	txt(Out, T,I1),
	txtTutto(Out, C,I).


/*
==============================================================================
classifica( +Oggetto, -Classe, t(+Att,+Valori))
	Oggetto: [Attributo1=Valore1, .. , AttributoN=ValoreN]
	Classe: classe a cui potrebbe appartenere un oggetto caratterizzato
			da quelle coppie
	Attributo=Valore

t(-Att,-Valori): Albero di Decisione
presuppone sia stata effettuata l'induzione dell'Albero di Decisione
*/
classifica(Oggetto,nc,t(Att,Valori)) :- % dato t(+Att,+Valori), Oggetto è della Classe
	member(Att=Val,Oggetto),  			% se Att=Val è elemento della lista Oggetto
    member(Val:null,Valori). 			% e Val:null è in Valori

classifica(Oggetto,Classe,t(Att,Valori)) :- % dato t(+Att,+Valori), Oggetto è della Classe
	member(Att=Val,Oggetto),  				% se Att=Val è elemento della lista Oggetto
	member(Val:l(Classe),Valori). 			% e Val:l(Classe) è in Valori

classifica(Oggetto,Classe,t(Att,Valori)) :-
	member(Att=Val,Oggetto),  		% se Att=Val è elemento della lista Oggetto
	delete(Oggetto,Att=Val,Resto),
	member(Val:t(AttFiglio,ValoriFiglio),Valori),
	classifica(Resto,Classe,t(AttFiglio,ValoriFiglio)).

stampa_matrice_di_confusione :-
	alb(Albero),
	findall(Classe/Oggetto,s(Classe,Oggetto),TestSet),
	length(TestSet,N),
	valuta(Albero,TestSet,VN,0,VP,0,FN,0,FP,0,NC,0),
	A is (VP + VN) / (N - NC),							% Accuratezza
	E is 1 - A,											% Errore
	write('Test effettuati :'),  writeln(N),
	write('Test non classificati :'),  writeln(NC),
	write('Veri Negativi  '), write(VN), write('   Falsi Positivi '), writeln(FP),
	write('Falsi Negativi '), write(FN), write('   Veri Positivi  '), writeln(VP),
	write('Accuratezza: '), writeln(A),
	write('Errore: '), writeln(E).

stampa_matrice_di_confusione_txt :-
	open('matrice_di_confusione_shannon.txt', append, Out),
	write(Out, Albero),
	alb(Albero),
	findall(Classe/Oggetto,s(Classe,Oggetto),TestSet),
	length(TestSet,N),
	valuta(Albero,TestSet,VN,0,VP,0,FN,0,FP,0,NC,0),
	A is (VP + VN) / (N - NC),							% Accuratezza
	E is 1 - A,											% Errore
	write(Out, 'Test effettuati :'),  writeln(Out, N),
	write(Out, 'Test non classificati :'),  writeln(Out, NC),
	write(Out, 'Veri Negativi  '), write(Out, VN), write(Out, '   Falsi Positivi '), writeln(Out, FP),
	write(Out, 'Falsi Negativi '), write(Out, FN), write(Out, '   Veri Positivi  '), writeln(Out, VP),
	write(Out, 'Accuratezza: '), writeln(Out, A),
	write(Out, 'Errore: '), writeln(Out, E),
	close(Out).

% testset vuoto -> valutazioni finali
valuta(_,[],VN,VN,VP,VP,FN,FN,FP,FP,NC,NC).            

% prevede correttamente che il paziente � healthy
valuta(Albero,[healthy/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,healthy,Albero), !,      
	VNA1 is VNA + 1,
	valuta(Albero,Coda,VN,VNA1,VP,VPA,FN,FNA,FP,FPA,NC,NCA).

% prevede correttamente che il paziente � sick
valuta(Albero,[sick/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,sick,Albero), !, 
	VPA1 is VPA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA1,FN,FNA,FP,FPA,NC,NCA).

% prevede erroneamente che il paziente � healthy
valuta(Albero,[sick/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,healthy,Albero), !,      
	FNA1 is FNA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA1,FP,FPA,NC,NCA).

% prevede erroneamente che il paziente � sick
valuta(Albero,[healthy/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,sick,Albero), !, 
	FPA1 is FPA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA,FP,FPA1,NC,NCA).

% non classifica
valuta(Albero,[_/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :- 
	classifica(Oggetto,nc,Albero), !, 					% non classificato
	NCA1 is NCA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA1).


stampa(Albero):-
	open('output.txt', append, Out),
	write(Out, Albero),
	close(Out).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


