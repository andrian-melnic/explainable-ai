
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

% ['age', 'hypertension', 'heart_disease', 'avg_glucose_level', 'bmi',
%        'gender__Female', 'gender__Male', 'gender__Other',
%        'ever_married__No', 'ever_married__Yes', 'Residence_type__Rural',
%        'Residence_type__Urban', 'smoking_status__Unknown',
%        'smoking_status__formerly smoked', 'smoking_status__never smoked',
%        'smoking_status__smokes', 'work_type__Govt_job',
%        'work_type__Never_worked', 'work_type__Private',
%        'work_type__Self-employed', 'work_type__children','stroke']

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