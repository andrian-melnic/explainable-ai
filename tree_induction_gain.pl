% =================================INIZIO: Gain=================================
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
