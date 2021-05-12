
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a(id, gender, height, weight, ap_hi, ap_lo, cholesterol, gluc, smoke, alco, active, cardio, age).
a(Gender, Age, Hypertension, Heart_disease, Ever_married, Work_type, Residence_type, Avg_glucose_level, Bmi, Smoking_status, Target).

id                   : numerico, indice univoco del paziente
gender               : binario, sesso del paziente (0 = Femmina, 1 = Maschio)
age                  : numerico, età del paziente
hypertension         : binario, presenza di ipertenisone (0 = No, 1 = Si)
heart_disease        : binario, presenza di cardiopatia, malattia caridaca (0 = No, 1 = Si)
ever_married         : binario, sposato (0 = No, 1 = Si)
work_type            : numerico, tipo di lavoro (0 = Never worked, 1= Children, 2 = Private, 3 = Self employed, 4 = Govt job)
residence_type       : binario, dove abita (0 = Campagnia, 1 = Città)
avg_glucose_level    : numerico, livello medio di gluccosio nel sangue, RANGE:
                                                                                X < 110       Rischio Nullo
                                                                                110 < X < 119 Rischio Moderato
                                                                                119 < X < 125 Rischio Alto
				                                                                X > 125       Rischio Molto Alto
bmi                  : numerico, letteralmente body mass index, indice di massa corporea, RANGE:
                                                                                                X < 18  	SOTTOPESO
                                                                                                18 < X < 25	NORMOPESO
                                                                                                25 < X < 30	SOVRAPPESO
                                                                                                X > 30      OBESITÀ
smoking_status       : numerico, tipo di fumatore (0 = Never smoked, 1 = Formerly smoked, 3 = Smokes)
target               : booleano, indica se il passeggero ha avuto un ictus (0 = No, 1 = Si)

es
a(Male,67.0,0,1,Yes,Private,Urban,228.69,36.6,formerly_smoked,1).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/* ['gender', 'height', 'weight', 'ap_hi', 'ap_lo', 'smoke', 'alco', 'active', 
'age', 'gluc_norm', 'gluc_above_norm', 'gluc_wabove_norm', 'chol_norm', 
'chol_above_norm', 'chol_wabove_norm', 'bmi',CARDIO] */

:- ensure_loaded(cardio_database).
start :-
    tell('./data_preprocessing/cardio_data/cardio_database_ela.pl'),
    a(Gender, Height, Weight, ApHi, ApLo, Smoke, Alco, Active, Age, GlucNorm, GlucAboveNorm, GlucWaboveNorm, CholNorm, CholAboveNorm, CholWaboveNorm, Bmi, Cardio),

    write('aa('), write(Gender),

    write(','),   ( number(Height),               Height =< 135, write('\'0-135\'');
                    number(Height), Height > 135, Height =< 145, write('\'136-145\'');
                    number(Height), Height > 145, Height =< 155, write('\'146-155\'');
                    number(Height), Height > 155, Height =< 165, write('\'156-165\'');
				    number(Height), Height > 165, Height =< 175, write('\'166-175\'');
				    number(Height), Height > 175, Height =< 185, write('\'176-185\'');
				    number(Height), Height > 185, Height =< 195, write('\'186-195\'');
				    number(Height), Height > 195, Height =< 200, write('\'196-200\'');
				    number(Height), Height > 200,                write('\'201+\'')),

    write(','),   ( number(Weight),               Weight =< 20,   write('\'0-20\'');
                    number(Weight), Weight > 20,  Weight =< 40,   write('\'21-40\'');
                    number(Weight), Weight > 40,  Weight =< 60,   write('\'41-60\'');
                    number(Weight), Weight > 60,  Weight =< 80,   write('\'61-80\'');
                    number(Weight), Weight > 80,  Weight =< 100,  write('\'81-100\'');
                    number(Weight), Weight > 100, Weight =< 120, write('\'101-120\'');
				    number(Weight), Weight > 120,                write('\'121+\'')), 

    write(','),   ( number(ApHi),             ApHi =< 120, write('\'0-120\'');
                    number(ApHi), ApHi > 120, ApHi =< 130, write('\'121-130\'');
                    number(ApHi), ApHi > 130, ApHi =< 140, write('\'131-140\'');
                    number(ApHi), ApHi > 140, ApHi =< 150, write('\'141-150\'');
                    number(ApHi), ApHi > 150, ApHi =< 160, write('\'151-160\'');
                    number(ApHi), ApHi > 160, ApHi =< 170, write('\'161-170\'');
                    number(ApHi), ApHi > 170, ApHi =< 180, write('\'171-180\'');
				    number(ApHi), ApHi > 180,              write('\'181+\'')), 

    write(','),   ( number(ApLo),             ApLo =< 80,   write('\'0-80\'');
                    number(ApLo), ApLo > 80,  ApLo =< 85,   write('\'81-85\'');
                    number(ApLo), ApLo > 85,  ApLo =< 90,   write('\'86-90\'');
                    number(ApLo), ApLo > 90,  ApLo =< 95,   write('\'91-95\'');
                    number(ApLo), ApLo > 95,  ApLo =< 100,   write('\'96-100\'');
                    number(ApLo), ApLo > 100, ApLo =< 105, write('\'101-105\'');
                    number(ApLo), ApLo > 105, ApLo =< 110, write('\'106-110\'');
				    number(ApLo), ApLo > 110,              write('\'111+\'')), 
                    
    write(','),   write(Smoke),
    write(','),   write(Alco),
    write(','),   write(Active),

    write(','),   ( number(Age),           Age =< 30, write('\'0-30\'');
                    number(Age), Age > 30, Age =< 40, write('\'31-40\'');
                    number(Age), Age > 40, Age =< 50, write('\'41-50\'');
                    number(Age), Age > 50, Age =< 60, write('\'51-60\'');
                    number(Age), Age > 60, Age =< 70, write('\'61-70\'');
                    number(Age), Age > 70, Age =< 80, write('\'71-80\'');
                    number(Age), Age > 80,            write('\'81+\'')),

    write(','),   write(GlucNorm),
    write(','),   write(GlucAboveNorm),
    write(','),   write(GlucWaboveNorm),

    write(','),   write(CholNorm),
    write(','),   write(CholAboveNorm),
    write(','),   write(CholWaboveNorm),

    write(','),   ( number(Bmi),          Bmi == 0.0, write('\'Unknown\'');
                    number(Bmi), Bmi > 0, Bmi =< 15, write('\'0-15\'');
                    number(Bmi), Bmi > 15, Bmi =< 20, write('\'16-20\'');
                    number(Bmi), Bmi > 20, Bmi =< 25, write('\'21-25\'');
                    number(Bmi), Bmi > 25, Bmi =< 30, write('\'26-30\'');
				    number(Bmi), Bmi > 30,            write('\'31+\'')),

    write(','),   write(Cardio),  
        writeln(').'),
    fail.
start :- told.

/*
start :-
    tell('stroke_database_ela.pl'),
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
				    number(Residence_type), Residence_type == 1,  write('\'Urban\'')), 
    write(','),   ( number(Avg_glucose_level),                          Avg_glucose_level =< 110, write('\'0-110\'');
                    number(Avg_glucose_level), Avg_glucose_level > 110, Avg_glucose_level =< 119, write('\'111-119\'');
                    number(Avg_glucose_level), Avg_glucose_level > 119, Avg_glucose_level =< 125, write('\'120-125\'');
				    number(Avg_glucose_level), Avg_glucose_level > 125,                           write('\'126+\'')),
    write(','),   ( number(Bmi),          Bmi == 0.0, write('\'Unknown\'');
                    number(Bmi), Bmi > 0, Bmi =< 17, write('\'0-18\'');
                    number(Bmi), Bmi > 17, Bmi =< 25, write('\'19-25\'');
                    number(Bmi), Bmi > 25, Bmi =< 30, write('\'26-30\'');
				    number(Bmi), Bmi > 30,            write('\'31+\'')), 
    write(','),   ( number(Smoking_status), Smoking_status == 0, write('\'Never smoked\'');
                    number(Smoking_status), Smoking_status == 1, write('\'Formerly smoked\'');
                    number(Smoking_status), Smoking_status == 2, write('\'Smokes\'');
				    number(Smoking_status), Smoking_status == 3,  write('\'Unknown\'')),  
    write(','),   write(Target),
        writeln(').'),
    fail.

start :- told.
*/