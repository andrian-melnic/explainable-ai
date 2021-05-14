/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * tree_induction_gini.pl
 ***/	


/*
 * 	disuguaglianza_gini(+Esempi, +Attributo, -Dis)
 *  +Esempi		->	esempi su cui calcolare la somma pesata
 * 	+Attributo	->	attributo da valutare
 * 	-Dis		->	disuguaglianza combinata dei sottoinsiemi degli esempi partizionati dai valori dell'Attributo
 */
disuguaglianza_gini(Esempi, Attributo, Dis) :-
	a(Attributo, AttVals),
	somma_pesata(Esempi, Attributo, AttVals, 0, Dis).

/*
 * 	somma_pesata(+Esempi, +Attributo, +Valori, +SommaParziale, -Somma)
 *	-Somma 	-> somma pesata delle disuguaglianze 
 *	Gini(A) = ∑P(v) * ∑P(i∣v) * P( j∣v)
 */
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
    gini(ClDst, Gini),
	NuovaSommaParziale is SommaParziale + Gini * (NVal/N),
	somma_pesata(Esempi,Att,Valori,NuovaSommaParziale,Somma)
	;
	somma_pesata(Esempi,Att,Valori,SommaParziale,Somma). 			        % nessun esempio soddisfa Att = Val

/*
 * 	gini(+ListaProbabilita, -Gini)
 *	+ListaProbabilita	->	probabilita' degli esempi soddisfatti per Att=Val
 *	-Gini				->	indice di Gini risultante
 * 	sommatoria Pi*Pj per tutti i,j tali per cui i\=j
 */
gini(ListaProbabilita, Gini) :-
	somma_quadrati(ListaProbabilita, 0, SommaQuadrati),
	Gini is 1 - SommaQuadrati.

somma_quadrati([],S,S).
somma_quadrati([P|Ps],PartS,S)  :-
	NewPartS is PartS + P*P,
	somma_quadrati(Ps,NewPartS,S).
