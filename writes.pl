debug_attr(A) :-
	open('attr.txt', append, Out),
	write(Out,A),
	writeln(Out, ' '),
	writeln(Out, ' '),
	close(Out).

debug(A):-
	open('debug.txt', append, Out),
	write(Out,A),
	writeln(Out, ' '),
	writeln(Out, ' '),
	close(Out).

debug_due(A, B):-
	open('debug_due.txt', append, Out),
	write(Out,A),
	write(Out,' '),
	write(Out,B),
	writeln(Out, ' '),
	writeln(Out, ' '),
	close(Out).

debug_tre(A, B, C):-
	open('debug_tre.txt', append, Out),
	write(Out,A),
	write(Out,' '),
	write(Out,B),
	write(Out,' '),
	write(Out,C),
	writeln(Out, ' '),
	writeln(Out, ' '),
	close(Out).


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

% Stampa albero formattato su file
/*
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
txt(Out, t(A,L),I) :-
	writeln(Out, ' '),
	tab(Out, I), write(Out, A),
	writeln(Out, ' '),
	I1 is I+2,
	txtTutto(Out, L,I1).

txtTutto(_, [],_).
txtTutto(Out, [V:T|C],I) :-
	tab(Out, I),write(Out, V), I1 is I+2,
	txt(Out, T,I1),
	txtTutto(Out, C,I).
*/

% Stampa albero formattato su file
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
	((1 is mod(Counter,2)) ->
	(
		write(Out, '|'),
		tab(Out, 2),
		Counter2 is Counter+1,
		(I > 0) -> (I2 is I-2, tabs(Out, I2, Counter2)); !);
	(	tab(Out, 2),
		Counter2 is Counter+1,
		(I > 0) -> (I2 is I-2, tabs(Out, I2, Counter2)); !)
	).

% rimozione .txt albero con parametro indicato da 'Version'
deleteTreeFile(Version) :-
	atom_concat('./output/tree/tree_', Version, TempTreeFileName),
    atom_concat(TempTreeFileName, '.txt', EndTreeFileName),
	exists_file(EndTreeFileName),
	delete_file(EndTreeFileName).

% rimozione .txt matrice con parametro indicato da 'Version'
deleteMatrixFile(Version) :-
	atom_concat('./output/matrix/matrix_', Version, TempMatrixFileName),
    atom_concat(TempMatrixFileName, '.txt', EndMatrixFileName),
	exists_file(EndMatrixFileName),
	delete_file(EndMatrixFileName).

/*
TODO: non piu' in uso per il momento
stampa(Albero):-
	open('output.txt', write, Out),
	write(Out, Albero),
	close(Out).
*/
