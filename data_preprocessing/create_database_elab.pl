/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * create_database_elab.pl
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

% database elaborato -> stroke
start(stroke) :-
    ensure_loaded(data_preprocessing/stroke/stroke_database),
    tell('data_preprocessing/stroke/stroke_database_elab.pl'),
    a(Gender,Age,Hypertension,Heart_disease,Ever_married,Work_type,Residence_type,Avg_glucose_level,Bmi,Smoking_status,Target),
    write('aa('), write(Gender),
    write(','),   ( number(Age),           Age =< 30, write('\'0-30\'');
                    number(Age), Age > 30, Age =< 40, write('\'31-40\'');
                    number(Age), Age > 40, Age =< 50, write('\'41-50\'');
                    number(Age), Age > 50, Age =< 60, write('\'51-60\'');
				    number(Age), Age > 60, Age =< 70, write('\'61-70\'');
				    number(Age), Age > 70, Age =< 80, write('\'71-80\'');
				    number(Age), Age > 80,            write('\'81+\'')),  
    write(','),   write(Hypertension),
    write(','),   write(Heart_disease), 
    write(','),   write(Ever_married), 
    write(','),   ( number(Work_type), Work_type == 0, write('\'Never worked\'');
                    number(Work_type), Work_type == 1, write('\'Children\'');
                    number(Work_type), Work_type == 2, write('\'Private\'');
                    number(Work_type), Work_type == 3, write('\'Self employed\'');
				    number(Work_type), Work_type == 4,  write('\'Govt job\'')),  
    write(','),   ( number(Residence_type), Residence_type == 0, write('\'Rural\'');
				    number(Residence_type), Residence_type == 1,  write('\'City\'')), 
    write(','),   ( number(Avg_glucose_level),                          Avg_glucose_level =< 110, write('\'0-110\'');
                    number(Avg_glucose_level), Avg_glucose_level > 110, Avg_glucose_level =< 119, write('\'111-119\'');
                    number(Avg_glucose_level), Avg_glucose_level > 119, Avg_glucose_level =< 125, write('\'120-125\'');
				    number(Avg_glucose_level), Avg_glucose_level > 125,                           write('\'126+\'')),
    write(','),   ( number(Bmi),           Bmi =< 17, write('\'0-18\'');
                    number(Bmi), Bmi > 17, Bmi =< 25, write('\'19-25\'');
                    number(Bmi), Bmi > 25, Bmi =< 30, write('\'26-30\'');
				    number(Bmi), Bmi > 30,            write('\'31+\'')), 
    write(','),   ( number(Smoking_status), Smoking_status == 0, write('\'Never smoked\'');
                    number(Smoking_status), Smoking_status == 1, write('\'Formerly smoked\'');
				    number(Smoking_status), Smoking_status == 2,  write('\'Smokes\'')),  
    write(','),   write(Target),
        writeln(').'),
    fail.

% database elaborato -> stroke_ohe
start(stroke_ohe) :-
    ensure_loaded(data_preprocessing/stroke_ohe/stroke_ohe_database),
    tell('data_preprocessing/stroke_ohe/stroke_ohe_database_elab.pl'),
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
    write(','),   ( number(Bmi),          Bmi == 0, write('\'Unknown\'');
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

% database elaborato -> heart
start(heart) :-
    ensure_loaded(data_preprocessing/heart/heart_database),
    tell('data_preprocessing/heart/heart_database_elab.pl'),
	a(Target,Age,Sex,Thalach,Exang,Oldpeak,Ca,Cp_0,Cp_1,Cp_2,Cp_3,Slope_0,Slope_1,Slope_2,Thal_1,Thal_2,Thal_3),
	write('aa('), write(Target),
	write(','),  ( number(Age), Age =< 40,  write('0-40') ;
                   number(Age), Age > 40, Age =< 50, write('40-50') ;
                   number(Age), Age > 50, Age =< 60, write('50-60') ;
				   number(Age), Age > 60, Age =< 70, write('60-70') ;
				   number(Age), Age > 70, Age =< 80, write('70-80');
				   number(Age), Age > 80, write('80')),
    write(','),  write(Sex),
    write(','),(  number(Thalach), Thalach=<140, write('0-140');
					number(Thalach), Thalach>140, Thalach=<170, write('140-170');
					number(Thalach), Thalach>170, write('170')),
	write(','), write(Exang),
	write(','), (  number(Oldpeak), Oldpeak=<1, write('0-1');
					number(Oldpeak), Oldpeak>1, Oldpeak=<2, write('1-2');
					number(Oldpeak), Oldpeak>2, write('2')),
	write(','), write(Ca),
	write(','), write(Cp_0),
	write(','), write(Cp_1),
	write(','), write(Cp_2),
	write(','), write(Cp_3),
	write(','), write(Slope_0),
	write(','), write(Slope_1),
	write(','), write(Slope_2),
	write(','), write(Thal_1),
	write(','), write(Thal_2),
	write(','), write(Thal_3),
        writeln(').'),
	fail.

% database elaborato -> obesity
start(obesity) :-
    ensure_loaded(data_preprocessing/obesity/obesity_database),
    tell('data_preprocessing/obesity/obesity_database_elab.pl'),
    a(GENDER, AGE, HEIGHT, WEIGHT, FHO, FAVC, FCVC, NCP, CAEC, SMOKE, CH2O, SCC, FAF, TUE, CALC, MTRANS, TARGET),
	write('aa('), write(GENDER),
	write(','),  ( number(AGE), AGE =< 20,  write('\'0-20\'') ;
                   number(AGE), AGE > 20, AGE =< 30, write('\'21-30\'') ;
                   number(AGE), AGE > 30, AGE =< 40, write('\'31-40\'') ;
				   number(AGE), AGE > 40, AGE =< 50, write('\'41-50\'') ;
				   number(AGE), AGE > 50, AGE =< 60, write('\'51-60\'') ;
				   number(AGE), AGE > 60, write('\'61+\'')),
    write(','),  ( number(HEIGHT), HEIGHT =< 1.6,  write('\'0-1.60\'') ;
                   number(HEIGHT), HEIGHT > 1.6, HEIGHT =< 1.7, write('\'1.61-1.70\'') ;
                   number(HEIGHT), HEIGHT > 1.7, HEIGHT =< 1.8, write('\'1.71-1.80\'') ;
				   number(HEIGHT), HEIGHT > 1.8, HEIGHT =< 1.9, write('\'1.81-1.90\'') ;
				   number(HEIGHT), HEIGHT > 1.9, HEIGHT =< 2.0, write('\'1.91-2.00\'') ;
				   number(HEIGHT), HEIGHT > 2.0, write('\'2.01+\'')),
    write(','),  ( number(WEIGHT), WEIGHT =< 40,  write('\'0-40\'') ;
                   number(WEIGHT), WEIGHT > 40, WEIGHT =< 60, write('\'41-60\'') ;
                   number(WEIGHT), WEIGHT > 60, WEIGHT =< 80, write('\'61-80\'') ;
                   number(WEIGHT), WEIGHT > 80, WEIGHT =< 100, write('\'81-100\'') ;
                   number(WEIGHT), WEIGHT > 100, WEIGHT =< 120, write('\'101-120\'') ;
                   number(WEIGHT), WEIGHT > 120, WEIGHT =< 140, write('\'121-140\'') ;
				   number(WEIGHT), WEIGHT > 140, write('\'141+\'')),
    write(','),  write(FHO),
    write(','),  write(FAVC),
    write(','),  write(FCVC),
    write(','),  write(NCP),
    write(','),  write(CAEC),
    write(','),  write(SMOKE),
    write(','),  write(CH2O),
    write(','),  write(SCC),
    write(','),  write(FAF),
    write(','),  write(TUE),
    write(','),  write(CALC),
    write(','),  write(MTRANS),
    write(','),  write(TARGET),
    writeln(').'),
    fail.

% told
start(_) :- told.