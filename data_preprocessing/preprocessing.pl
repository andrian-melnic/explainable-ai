/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * preprocessing.pl
 ***/	

:- ensure_loaded(data_preprocessing/create_database_elab).
:- ensure_loaded(data_preprocessing/create_dataset).

/*
 * preprocess(+Dataset)
 * +Dataset = (stroke, stroke_ohe, heart, obesity) -> base di dati su cui effettuare data pre-processing 
 */
preprocess(Dataset) :-
    start(Dataset),
    startt(Dataset).
