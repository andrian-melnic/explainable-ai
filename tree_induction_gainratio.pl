%===============================INIZIO: GainRatio===============================
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
