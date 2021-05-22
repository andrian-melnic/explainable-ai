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
confusion_matrix :-
	alb(Albero),
	findall(Classe/Oggetto,s(Classe,Oggetto),TestSet),
	length(TestSet,N),
	valuta(Albero,TestSet,VN,0,VP,0,FN,0,FP,0,NC,0),
	ACC is (VP + VN) / (N - NC),							% accuracy
	ERR is 1 - ACC,											% error
	%TPR is VP / (VP + FN),									% true positive rate (TPR)
	%TNR is VN / (VN + FP),									% true negative rate (TNR)
	%PPV is VP / (VP + FP),									% precision (PPV)
	%BA is (TPR + TNR) / 2,									% balanced accuracy
	%FS is 2 * ((PPV * TPR) / (PPV + TPR)),					% harmonic mean of precision (PPV) and sensitivity (TPR)
	write('Performed tests: '),  writeln(N),
	write('Unclassified tests: '),  writeln(NC),
	write('True negative  (TN): '), write(VN), write('\t False positive (FP): '), writeln(FP),
	write('False negative (FN): '), write(FN), write('\t True positive  (TP): '), writeln(VP),
	write('Accuracy (ACC): '), writeln(ACC),
	write('Error: '), writeln(ERR).

% stampa la matrice di confusione in output su file .txt
confusion_matrix_txt(File) :-
	alb(Albero),
	findall(Classe/Oggetto,s(Classe,Oggetto),TestSet),
	length(TestSet,N),
	valuta(Albero,TestSet,VN,0,VP,0,FN,0,FP,0,NC,0),
	ACC is (VP + VN) / (N - NC),							% accuracy
	ERR is 1 - ACC,											% error
	%TPR is VP / (VP + FN),									% true positive rate (TPR)
	%TNR is VN / (VN + FP),									% true negative rate (TNR)
	%PPV is VP / (VP + FP),									% positive predictive value (PPV)
	%BA is (TPR + TNR) / 2,									% balanced accuracy
	%FS is 2 * ((PPV * TPR) / (PPV + TPR)),					% harmonic mean of precision (PPV) and recall (TPR)
	open(File, write, Out),
	write(Out, 'Performed tests: '),  writeln(Out, N),
	write(Out, 'Unclassified tests: '),  writeln(Out, NC),
	write(Out, 'True negative  (TN): '), write(Out, VN), write(Out, '\t False positive (FP): '), writeln(Out, FP),
	write(Out, 'False negative (FN): '), write(Out, FN), write(Out, '\t True positive  (TP): '), writeln(Out, VP),
	write(Out, 'Accuracy (ACC): '), writeln(Out, ACC),
	write(Out, 'Error: '), writeln(Out, ERR),
	close(Out).
