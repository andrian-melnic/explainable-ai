/*
programma per apprendere inducendo Alberi di Decisione testandone
l' efficacia
*/

:- ensure_loaded(stroke_dataset).
%:- ensure_loaded(stroke_training_set).
%:- ensure_loaded(stroke_test_set).

:- dynamic alb/1.

induce_albero( Albero ) :-
	findall( e(Classe,Oggetto), e(Classe,Oggetto), Esempi),
        findall( Att,a(Att,_), Attributi),
        induce_albero( Attributi, Esempi, Albero),
	mostra( Albero ),
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
    SubAlb1, SubAlb2,... sono i corrispondenti sottoalberi di decisione.
(4) Albero = l(Classi): non abbiamo Attributi utili per
    discriminare ulteriormente
*/


induce_albero( _, [], null ) :- !.			                            % (1)
induce_albero( _, [e(Classe,_)|Esempi], l(Classe)) :-	                % (2)
	\+ ( member(e(ClassX,_),Esempi), ClassX \== Classe ),!.             % no esempi di altre classi (OK!!)
induce_albero( Attributi, Esempi, t(Attributo,SAlberi) ) :-	            % (3)
	sceglie_attributo( Attributi, Esempi, Attributo), !,                % implementa la politica di scelta
	del( Attributo, Attributi, Rimanenti ),			                    % elimina Attributo scelto
	a( Attributo, Valori ),					                            % ne preleva i valori
	induce_alberi( Attributo, Valori, Rimanenti, Esempi, SAlberi).
induce_albero( _, Esempi, l(Classi)) :-                                 % finiti gli attributi utili (KO!!)
	findall( Classe, member(e(Classe,_),Esempi), Classi).


/*
sceglie_attributo( +Attributi, +Esempi, -MigliorAttributo):
seleziona l'Attributo che meglio discrimina le classi; si basa sul
concetto della "Gini-disuguaglianza"; utilizza il setof per ordinare
gli attributi in base al valore crescente della loro disuguaglianza
usare il setof per far questo è dispendioso e si può fare di meglio ..
sceglie_attributo( Attributi, Esempi, MigliorAttributo )  :-
	setof( Disuguaglianza/A,
	      (member(A,Attributi) , disuguaglianza(Esempi,A,Disuguaglianza)),
	      [MinorDisuguaglianza/MigliorAttributo|_] ).

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
	length(Esempi,N),                                               % quanti sono gli esempi
	findall( C,						                                % EsempiSoddisfatti: lista delle classi ..
		 (member(e(C,Desc),Esempi) , soddisfa(Desc,[Att=Val])),     % .. degli esempi (con ripetizioni)..
		 EsempiSoddisfatti ),				                        % .. per cui Att=Val
	length(EsempiSoddisfatti, NVal),			                    % quanti sono questi esempi
	NVal > 0, !,                                                    % almeno uno!
	findall(P,			                                            % trova tutte le P robabilità
                (bagof(1,		           
                       member(_,EsempiSoddisfatti),
                       L),
                 length(L,NVC),
                 P is NVC/NVal),
                ClDst),
        gini(ClDst,Gini),
	NuovaSommaParziale is SommaParziale + Gini*NVal/N,
	somma_pesata(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata(Esempi,Att,Valori,SommaParziale,Somma). % nessun esempio soddisfa Att = Val

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
induce_alberi(_,[],_,_,[]).     % nessun valore, nessun sottoalbero
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
	findall(e(C,O),(member(e(C,O),Esempi),soddisfa(O,[AttributoValore])),Sottoinsieme).

/soddisfa(Oggetto, Descrizione):/
soddisfa(Oggetto,Congiunzione)  :-
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


/*
================================================================================
  classifica( +Oggetto, -Classe, t(+Att,+Valori))
  Oggetto: [Attributo1=Valore1, .. , AttributoN=ValoreN]
  Classe: classe a cui potrebbe appartenere un oggetto caratterizzato da quelle coppie
  Attributo=Valore
  t(-Att,-Valori): Albero di Decisione
presuppone sia stata effettuata l'induzione dell'Albero di Decisione
*/
classifica(Oggetto,nc,t(Att,Valori)) :-                 % dato t(+Att,+Valori), Oggetto è della Classe
	member(Att=Val,Oggetto),                            % se Att=Val è elemento della lista Oggetto
        member(Val:null,Valori).                        % e Val:null è in Valori

classifica(Oggetto,Classe,t(Att,Valori)) :-             % dato t(+Att,+Valori), Oggetto è della Classe
	member(Att=Val,Oggetto),                            % se Att=Val è elemento della lista Oggetto
        member(Val:l(Classe),Valori).                   % e Val:l(Classe) è in Valori

classifica(Oggetto,Classe,t(Att,Valori)) :-
	member(Att=Val,Oggetto),                            % se Att=Val è elemento della lista Oggetto
	delete(Oggetto,Att=Val,Resto),
	member(Val:t(AttFiglio,ValoriFiglio),Valori),
	classifica(Resto,Classe,t(AttFiglio,ValoriFiglio)).


stampa_matrice_di_confusione :-
	alb(Albero),
	findall(Classe/Oggetto,s(Classe,Oggetto),TestSet),
	length(TestSet,N),
	valuta(Albero,TestSet,VN,0,VP,0,FN,0,FP,0,NC,0),
	A is (VP + VN) / (N - NC), % Accuratezza
	E is 1 - A,		   % Errore
	write('Test effettuati :'),  writeln(N),
	write('Test non classificati :'),  writeln(NC),
	write('Veri Negativi  '), write(VN), write('   Falsi Positivi '), writeln(FP),
	write('Falsi Negativi '), write(FN), write('   Veri Positivi  '), writeln(VP),
	write('Accuratezza: '), writeln(A),
	write('Errore: '), writeln(E).

valuta(_,[],VN,VN,VP,VP,FN,FN,FP,FP,NC,NC).                                     % testset vuoto -> valutazioni finali
valuta(Albero,[sano/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,sano,Albero), !,                                         % prevede correttamente che il paziente � sano
	VNA1 is VNA + 1,
	valuta(Albero,Coda,VN,VNA1,VP,VPA,FN,FNA,FP,FPA,NC,NCA).
valuta(Albero,[malato/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,malato,Albero), !,                                       % prevede correttamente che il paziente � malato
	VPA1 is VPA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA1,FN,FNA,FP,FPA,NC,NCA).
valuta(Albero,[malato/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,sano,Albero), !,                                         % prevede erroneamente che il paziente � sano
	FNA1 is FNA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA1,FP,FPA,NC,NCA).
valuta(Albero,[sano/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,malato,Albero), !,                                       % prevede erroneamente che il paziente � malato
	FPA1 is FPA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA,FP,FPA1,NC,NCA).
valuta(Albero,[_/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-           % non classifica
	classifica(Oggetto,nc,Albero), !,                                           % non classificato
	NCA1 is NCA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA1).


stampa(Albero):-
  open('output.txt',write,Out),
  write(Out,Albero),
  close(Out).
