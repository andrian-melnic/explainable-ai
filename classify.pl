/*
classifica( +Oggetto, -Classe, t(+Att,+Valori))
	Oggetto: [Attributo1=Valore1, .. , AttributoN=ValoreN]
	Classe: classe a cui potrebbe appartenere un oggetto caratterizzato
			da quelle coppie
	Attributo=Valore

t(-Att,-Valori): Albero di Decisione
presuppone sia stata effettuata l'induzione dell'Albero di Decisione
*/

/*
classifica(Oggetto,nc,t(Att,Valori)) :- % dato t(+Att,+Valori), Oggetto è della Classe

	member(Att=Val,Oggetto),  			% se Att=Val è elemento della lista Oggetto
	% write(' { '),
	% write(Valori),
	% write(' } '),
	member(Val:null,Valori);			% e Val:null è in Valori
	%  stampa_matrice_di_confusione dava false perché incontrava dei valori con
	%  [healthy, sick]
	member(Val:l([_,_]), Valori). 			
*/

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
	% write('valuto'),
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
	% write('0 -> ').           

% prevede correttamente che il paziente � healthy
valuta(Albero,[healthy/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	% write('1 -> '),
	classifica(Oggetto,healthy,Albero), !,
	VNA1 is VNA + 1,
	valuta(Albero,Coda,VN,VNA1,VP,VPA,FN,FNA,FP,FPA,NC,NCA).

% prevede correttamente che il paziente � sick
valuta(Albero,[sick/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	% write('2 -> '),
	classifica(Oggetto,sick,Albero), !, 
	VPA1 is VPA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA1,FN,FNA,FP,FPA,NC,NCA).

% prevede erroneamente che il paziente � healthy
valuta(Albero,[sick/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	% write('3 -> '),
	classifica(Oggetto,healthy,Albero), !,      
	FNA1 is FNA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA1,FP,FPA,NC,NCA).

% prevede erroneamente che il paziente � sick
valuta(Albero,[healthy/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	% write('4 -> '),
	classifica(Oggetto,sick,Albero), !, 
	FPA1 is FPA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA,FP,FPA1,NC,NCA).

% non classifica
%valuta(Albero,[_/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :- 
valuta(Albero,[_/_|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :- 
	% classifica(Oggetto,nc,Albero), !, 					% non classificato
	NCA1 is NCA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA1).

