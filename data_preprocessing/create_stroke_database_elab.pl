/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * create_stroke_database_elab.pl
 ***/	


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a(  Gender,Age,Hypertension,Heart_disease,Ever_married,Work_type,
    Residence_type,Avg_glucose_level,Bmi,Smoking_status,Target).

gender               : sesso del paziente (Female, Male, Other)
age                  : età del paziente
hypertension         : presenza di ipertenisone (0 = No, 1 = Si)
heart_disease        : presenza di cardiopatia, malattia caridaca (0 = No, 1 = Si)
ever_married         : sposato (0 = No, 1 = Si)
work_type            : tipo di lavoro (Never worked, Children, Private, Self employed, Govt job)
residence_type       : residenza (Rural, Urban)
avg_glucose_level    : livello medio di glucosio nel sangue, range:
                        X < 110         Rischio Nullo
                        110 < X < 119   Rischio Moderato
                        119 < X < 125   Rischio Alto
                        X > 125         Rischio Molto Alto
bmi                  : indice di massa corporea (body mass index), range:
                        X < 18  	    Sottopeso
                        18 < X < 25	    Normopeso
                        25 < X < 30	    Sovrappeso
                        X > 30          Obesita'
smoking_status       : tipo di fumatore (Never smoked, Formerly smoked, Smokes)
target               : indica se il paziente ha avuto un ictus (0 = No, 1 = Si)

Nota:   Attraverso un processo di One Hot Encoding si sono generati nuovi 
        attributi dummy a partire dalle features con valori categorici. 
        es. gender(Female, Male, Other) -> Gender_female(0,1) , Gender_male(0,1) , Gender_other(0,1)
       
a(  Age,Hypertension,Heart_disease,Avg_glucose_level,Bmi,Gender_female,Gender_male,Gender_other,
    Ever_married_no,Ever_married_yes,Residence_type_rural,Residence_type_urban,
    Smoking_status_unknown,Smoking_status_formerly_smoked,Smoking_status_never_smoked,Smoking_status_smokes,
    Work_type_govt_job,Work_type_never_worked,Work_type_private,Work_type_self_employed,Work_type_children,Target).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

:- ensure_loaded(stroke_database).

start :-
    tell('stroke_database_ela.pl'),
    a(Age,Hypertension,Heart_disease,Avg_glucose_level,Bmi,Gender_female,Gender_male,Gender_other,Ever_married_no,Ever_married_yes,Residence_type_rural,Residence_type_urban,Smoking_status_unknown,Smoking_status_formerly_smoked,Smoking_status_never_smoked,Smoking_status_smokes,Work_type_govt_job,Work_type_never_worked,Work_type_private,Work_type_self_employed,Work_type_children,Target),
    write('aa('),   ( number(Age),           Age =< 30, write('\'0-30\'');
                    number(Age), Age > 30, Age =< 40, write('\'31-40\'');
                    number(Age), Age > 40, Age =< 50, write('\'41-50\'');
                    number(Age), Age > 50, Age =< 60, write('\'51-60\'');
				    number(Age), Age > 60, Age =< 70, write('\'61-70\'');
				    number(Age), Age > 70, Age =< 80, write('\'71-80\'');
				    number(Age), Age > 80,            write('\'81+\'')),  
    write(','),   write(Hypertension),
    write(','),   write(Heart_disease),
    write(','),   ( number(Avg_glucose_level),                          Avg_glucose_level =< 110, write('\'0-110\'');
                    number(Avg_glucose_level), Avg_glucose_level > 110, Avg_glucose_level =< 119, write('\'111-119\'');
                    number(Avg_glucose_level), Avg_glucose_level > 119, Avg_glucose_level =< 125, write('\'120-125\'');
				    number(Avg_glucose_level), Avg_glucose_level > 125,                           write('\'126+\'')),
    write(','),   ( number(Bmi),          Bmi == 0.0, write('\'Unknown\'');
                    number(Bmi), Bmi > 0, Bmi =< 17, write('\'0-18\'');
                    number(Bmi), Bmi > 17, Bmi =< 25, write('\'19-25\'');
                    number(Bmi), Bmi > 25, Bmi =< 30, write('\'26-30\'');
				    number(Bmi), Bmi > 30,            write('\'31+\'')),
    write(','),   write(Gender_female),
    write(','),   write(Gender_male),
    write(','),   write(Gender_other),
    write(','),   write(Ever_married_no),
    write(','),   write(Ever_married_yes),
    write(','),   write(Residence_type_rural),
    write(','),   write(Residence_type_urban),
    write(','),   write(Smoking_status_unknown),
    write(','),   write(Smoking_status_formerly_smoked),
    write(','),   write(Smoking_status_never_smoked),
    write(','),   write(Smoking_status_smokes),
    write(','),   write(Work_type_govt_job),
    write(','),   write(Work_type_never_worked),
    write(','),   write(Work_type_private),
    write(','),   write(Work_type_self_employed),
    write(','),   write(Work_type_children),
    write(','),   write(Target),
        writeln(').'),
    fail.

start :- told.