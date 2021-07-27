write_tree(Albero) :-
    alb(Albero),
	open('Tree.txt', write, Out),
	write(Out, Albero),
	close(Out).

get_leaf(_).

get_leaf(T) :-
	alb(T),
	get_leaf(t(_,_),X),
	write(X).

get_leaf(t(Attribute,Values), X):-
	member(Val:l(X), Values),
	write('Leaf: '), writeln(X),
	\+member(Val:t(AttributeChild,ValuesChild), Values),
	get_leaf(t(AttributeChild,ValuesChild),X).
	
/* get_leaf(X,t(_,Values)):-
	\+ member(Val:t, Values) t(_,[_|_:t]),
	t(_,[_:l(X)]),
	write('Leaf: ', t),
	get_leaf(t).
	 */



/* [tree_induction].
[tree_pruning].
load_dataset(stroke_ohe_v2).
induce.
get_leaf(Albero). */

% TODO
% Provare con member