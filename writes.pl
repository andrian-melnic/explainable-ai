goliardia_attr(A) :-
	open('attr.txt', append, Out),
	write(Out,A),
	writeln(Out, ' '),
	writeln(Out, ' '),
	close(Out).

goliardia(A):-
	open('goliardia.txt', append, Out),
	write(Out,A),
	writeln(Out, ' '),
	writeln(Out, ' '),
	close(Out).

goliardia_due(A, B):-
	open('goliardia_due.txt', append, Out),
	write(Out,A),
	write(Out,' '),
	write(Out,B),
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
txt(T) :-
	open('output_formattato.txt', append, Out),
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

stampa(Albero):-
	open('output.txt',write,Out),
	write(Out,Albero),
	close(Out).
