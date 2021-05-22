/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * writes.pl
 ***/


% debug per stampare termini "in input" su file 
debug(A):-
	open('debug.txt', append, Out),
	write(Out,A),
	writeln(Out, ' '),
	writeln(Out, ' '),
	close(Out).

% stampa albero formattato su terminale
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

% stampa albero formattato su file
txt(T,File) :-
	exists_file(File),
	delete_file(File),
	txt(T, File).
txt(T, File) :-
	\+ exists_file(File),
	open(File, append, Out),
	txt(Out, T,0),
	close(Out).
txt(Out, null,_) :-
	writeln(Out, ' ==> ???').
txt(Out, l(X),_) :-
	write(Out, ' ==> '), writeln(Out, X).
txt(Out, t(A,L), I) :-
	((I > 0) -> 
	(writeln(Out, ' '),
	tabs(Out, I, 0)); 
	(true)),
	write(Out, '|--- '), write(Out, A),
	writeln(Out, ' '),
	I1 is I+2,
	txtTutto(Out, L, I1).

txtTutto(_, [],_).
txtTutto(Out, [V:T|C], I) :-
	tabs(Out, I-2, 0),
	write(Out, '|--- '), write(Out, V), 
	I1 is I+2,
	txt(Out, T, I1),
	txtTutto(Out, C,I).

tabs(Out, I, Counter) :-
	write(Out, '|'),
	tab(Out, 2),
	Counter2 is Counter+1,
	(I > 0) -> (I2 is I-2, tabs(Out, I2, Counter2)); !.
