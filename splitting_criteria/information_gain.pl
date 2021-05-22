/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * tree_induction_gain.pl
 ***/	


/*
 * 	disuguaglianza_gain(+Esempi, +Attributo, -Dis)
 *  +Esempi		->	esempi su cui calcolare la somma pesata
 * 	+Attributo	->	attributo da valutare
 * 	-Dis		->	disuguaglianza combinata dei sottoinsiemi degli esempi partizionati dai valori dell'Attributo
 */
disuguaglianza_gain(Esempi, Attributo, Dis) :-
	a(Attributo, AttVals),
	entropiaDataset(Esempi, EntropiaDataset),
	somma_pesata_shannon(Esempi, Attributo, AttVals, 0, SpShannon),
	Dis is EntropiaDataset - SpShannon.

/*
 * 	entropiaDataset(+Esempi, -EntropiaDataset)
 *  +Esempi				->	esempi su cui calcolare l'entropia
 * 	-EntropiaDataset	-> 	entropia totale del dataset
 */
entropiaDataset(Esempi, EntropiaDataset) :-
	findall(sick, (member(e(sick, _),Esempi)), EsempiSick),
	length(Esempi, N),
	length(EsempiSick, NSick),
	PSick is NSick/N,											% calcolo prob. della classe 'sick' 
	entropia(PSick, EntropiaDataset).

/*
 * entropia(+Classe, -Entropia)
 * +Classe				->	prob. di Classe Q
 * -Entropia			-> 	entropia della Classe 
 * B(Q) = -[(Q)log_2(Q) + (1-Q)log_2(1-Q)]
 */
entropia(1, 0):- !.								% nel caso di prob. 1 l'entropia è uguale a 0
entropia(Q, H):-
	InvQ is 1-Q,
	log2(Q, LogQ),
	log2(InvQ, LogInvQ),
	H is -((Q * LogQ) + (InvQ * LogInvQ)).

/*
 * somma_pesata_shannon(+Esempi, +Attributo, +Valori, +SommaParziale, -Somma)
 * -Somma -> somma pesata delle disuguaglianze 
 */
somma_pesata_shannon( _, _, [], Somma, Somma).
somma_pesata_shannon( Esempi, Att, [Val|Valori], SommaParziale, Somma) :-
	length(Esempi,N),
	findall(C,
			(member(e(C,Desc),Esempi) , soddisfa(Desc,[Att=Val])),
			EsempiSoddisfatti),
	length(EsempiSoddisfatti, NVal),
	findall(P,																				% trova tutte le P probabilità
			(bagof(1, member(sick,EsempiSoddisfatti), L), length(L,NVC), P is NVC/NVal),
			Q),
	nth0(0, Q, Qattr),
    Qattr > 0, !,
	entropia(Qattr, EntropiaAttr),
	NuovaSommaParziale is SommaParziale + (NVal/N) * EntropiaAttr ,
	somma_pesata_shannon(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata_shannon(Esempi,Att,Valori,SommaParziale,Somma).		 					% nessun esempio soddisfa Att = Val       

