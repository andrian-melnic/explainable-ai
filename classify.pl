/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * classify.pl
 ***/	


/*
 * 	classifica(+Oggetto, -Classe, t(+Att,+Valori))
 *  +Oggetto		= 	[Attributo1=Valore1, .. , AttributoN=ValoreN]
 * 	-Classe			->	classe a cui potrebbe appartenere un oggetto caratterizzato da quelle coppie Attributo=Valore
 *	t(-Att,-Valori) -> 	albero di decisione
 * 	presuppone sia stata effettuata l'induzione dell'Albero di Decisione
 */
classifica(Oggetto,nc,t(Att,Valori)) :- 	% dato t(+Att,+Valori), Oggetto è della Classe
	member(Att=Val,Oggetto),  				% se Att=Val è elemento della lista Oggetto
	member(Val:_,Valori).					% e Val:_ -> per soddisfare le occorrenze di 'null' oppure '[sick,healty]'
classifica(Oggetto,Classe,t(Att,Valori)) :- % dato t(+Att,+Valori), Oggetto è della Classe
	member(Att=Val,Oggetto),  				% se Att=Val è elemento della lista Oggetto
	member(Val:l(Classe),Valori). 			% e Val:l(Classe) è in Valori
classifica(Oggetto,Classe,t(Att,Valori)) :-
	member(Att=Val,Oggetto),  		% se Att=Val è elemento della lista Oggetto
	delete(Oggetto,Att=Val,Resto),
	member(Val:t(AttFiglio,ValoriFiglio),Valori),
	classifica(Resto,Classe,t(AttFiglio,ValoriFiglio)).

% testset vuoto -> valutazioni finali
valuta(_,[],VN,VN,VP,VP,FN,FN,FP,FP,NC,NC).
% prevede correttamente che il paziente e' healthy
valuta(Albero,[healthy/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,healthy,Albero), !,
	VNA1 is VNA + 1,
	valuta(Albero,Coda,VN,VNA1,VP,VPA,FN,FNA,FP,FPA,NC,NCA).
% prevede correttamente che il paziente e' sick
valuta(Albero,[sick/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,sick,Albero), !,
	VPA1 is VPA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA1,FN,FNA,FP,FPA,NC,NCA).
% prevede erroneamente che il paziente e' healthy
valuta(Albero,[sick/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,healthy,Albero), !,
	FNA1 is FNA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA1,FP,FPA,NC,NCA).
% prevede erroneamente che il paziente e' sick
valuta(Albero,[healthy/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,sick,Albero), !,
	FPA1 is FPA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA,FP,FPA1,NC,NCA).
/*
 * non classifica 
 * per via dell'assenza di esempi che 
 * (1) non soddisfano la lista di coppie Att/Val
 * (2) la foglia dell'albero indotto non è atomica (es. [sick, healty]) 
 */
valuta(Albero,[_/Oggetto|Coda],VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA) :-
	classifica(Oggetto,nc,Albero), !,	% non classificato
	NCA1 is NCA + 1,
	valuta(Albero,Coda,VN,VNA,VP,VPA,FN,FNA,FP,FPA,NC,NCA1).

% stampa la matrice di confusione su terminale
stampa_matrice_confusione :-
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

% stampa la matrice di confusione in output su file .txt
stampa_matrice_confusione_txt(File) :-
	alb(Albero),
	findall(Classe/Oggetto,s(Classe,Oggetto),TestSet),
	length(TestSet,N),
	valuta(Albero,TestSet,VN,0,VP,0,FN,0,FP,0,NC,0),
	A is (VP + VN) / (N - NC),							% Accuratezza
	E is 1 - A,											% Errore
	open(File, write, Out),
	write(Out, 'Test effettuati :'),  writeln(Out, N),
	write(Out, 'Test non classificati :'),  writeln(Out, NC),
	write(Out, 'Veri Negativi  '), write(Out, VN), write(Out, '   Falsi Positivi '), writeln(Out, FP),
	write(Out, 'Falsi Negativi '), write(Out, FN), write(Out, '   Veri Positivi  '), writeln(Out, VP),
	write(Out, 'Accuratezza: '), writeln(Out, A),
	write(Out, 'Errore: '), writeln(Out, E),
	close(Out).
