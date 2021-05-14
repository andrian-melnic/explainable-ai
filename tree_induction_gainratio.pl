/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * tree_induction_gainratio.pl
 ***/


/*
 * 	disuguaglianza_gainratio(+Esempi, +Attributo, -Dis)
 *  +Esempi		->	esempi su cui calcolare la somma pesata
 * 	+Attributo	->	attributo da valutare
 * 	-Dis		->	disuguaglianza combinata dei sottoinsiemi degli esempi partizionati dai valori dell'Attributo
 */
disuguaglianza_gainratio( Esempi, Attributo, Dis) :-
	a( Attributo, AttVals),
	entropiaDataset(Esempi, EntropiaDataset),
	somma_pesata_shannon_gr(Esempi, Attributo, AttVals, 0, SpShannon),
	somma_gain_ratio(Esempi, Attributo, AttVals, 0, SpGain),
	Gain is EntropiaDataset - SpShannon,
	zerodivisor(Gain, SpGain, Dis).

/*
 * 	zerodivisor(+Gain, +SommapesataGain, -GainRatio)
 * 	procedura per evitare la divisione per zero nell'iterazione in cui la lista risulta vuota
 */
zerodivisor(_, 0.0, 0):- !.
zerodivisor(_, 0, 0):- !.
zerodivisor(Gain, SpGain, GainRatio):-
	GainRatio is Gain / (-SpGain).

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

/*
 * somma_pesata_shannon_gr(+Esempi, +Attributo, +Valori, +SommaParziale, -Somma)
 * -Somma -> somma pesata delle disuguaglianze 
 */
somma_pesata_shannon_gr(_, _, [], Somma, Somma).
somma_pesata_shannon_gr(Esempi, Att, [Val|Valori], SommaParziale, Somma) :-
	sommatoria(Esempi, Att, Val, Qattr, P_va),
	Qattr > 0, !,
	entropia(Qattr, EntropiaAttr),
	NuovaSommaParziale is SommaParziale + (P_va) * EntropiaAttr ,
	somma_pesata_shannon_gr(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata_shannon_gr(Esempi,Att,Valori,SommaParziale,Somma).

/*
 * somma_pesata_shannon_g(+Esempi, +Attributo, +Valori, +SommaParziale, -SommaPesataGainRatio)
 * -SommaGainRatio = -> somma pesata per la normalizzazione della quantita' di informazione
 * −∑P(vA)*log2(P(vA))
 */
somma_gain_ratio(_, _, [], Somma_g, Somma_g).
somma_gain_ratio(Esempi, Att, [Val|Valori], SommaParziale_g, Somma_g) :-
	sommatoria(Esempi, Att, Val, Qattr, P_va),
	Qattr > 0, !,
	log2(P_va, X),
	NuovaSommaParziale_g is SommaParziale_g + P_va * X,
	somma_gain_ratio(Esempi,Att,Valori,NuovaSommaParziale_g,Somma_g)
	;
	somma_gain_ratio(Esempi,Att,Valori,SommaParziale_g,Somma_g).
