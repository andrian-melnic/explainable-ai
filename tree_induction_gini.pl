% =================================INIZIO: Gini=================================
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
