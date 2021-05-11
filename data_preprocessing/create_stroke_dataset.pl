:- ensure_loaded(cardio_database_ela).

startt :-
    tell('cardio_dataset.pl'),
    setof(Gender,A^B^C^D^E^F^G^H^I^L^M^aa(Gender,A,B,C,D,E,F,G,H,I,L,M),AttributesGender),
    write('a(gender,'), writeq(AttributesGender), writeln(').'),

    setof(Height,A^B^C^D^E^F^G^H^I^L^M^aa(A,Height,B,C,D,E,F,G,H,I,L,M),AttributesHeight),
    write('a(height,'), writeq(AttributesHeight), writeln(').'),

    setof(Weight,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,Weight,C,D,E,F,G,H,I,L,M),AttributesWeight),
    write('a(weight,'), writeq(AttributesWeight), writeln(').'),

    setof(ApHi,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,C,ApHi,D,E,F,G,H,I,L,M),AttributesApHi),
    write('a(apHi,'), writeq(AttributesApHi), writeln(').'),

    setof(ApLo,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,C,D,ApLo,E,F,G,H,I,L,M),AttributesApLo),
    write('a(apLo,'), writeq(AttributesApLo), writeln(').'),

    setof(Cholesterol,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,C,D,E,Cholesterol,F,G,H,I,L,M),AttributesCholesterol),
    write('a(cholesterol,'), writeq(AttributesCholesterol), writeln(').'),

    setof(Gluc,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,C,D,E,F,Gluc,G,H,I,L,M),AttributesGluc),
    write('a(gluc,'), writeq(AttributesGluc), writeln(').'),

    setof(Smoke,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,C,D,E,F,G,Smoke,H,I,L,M),AttributesSmoke),
    write('a(smoke,'), writeq(AttributesSmoke), writeln(').'),

    setof(Alco,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,C,D,E,F,G,H,Alco,I,L,M),AttributesAlco),
    write('a(alco,'), writeq(AttributesAlco), writeln(').'),

    setof(Active,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,C,D,E,F,G,H,I,Active,L,M),AttributesActive),
    write('a(active,'), writeq(AttributesActive), writeln(').'),

    setof(Age,A^B^C^D^E^F^G^H^I^L^M^aa(A,B,C,D,E,F,G,H,I,L,Age,M),AttributesAge),
    write('a(age,'), writeq(AttributesAge), writeln(').'),
    starttt.

starttt :-
    aa(Gender, Height, Weight, ApHi, ApLo, Cholesterol, Gluc, Smoke, Alco, Active, Age, 0),
    write('e(healthy,['),
    write('gender = '),             writeq(Gender),          write(', '),
    write('height = '),             writeq(Height),          write(', '),
    write('weight = '),             writeq(Weight),          write(', '),
    write('apHi = '),               writeq(ApHi),            write(', '),
    write('apLo = '),               writeq(ApLo),            write(', '),
    write('cholesterol = '),        writeq(Cholesterol),     write(', '),
    write('gluc = '),               writeq(Gluc),            write(', '),
    write('smoke = '),              writeq(Smoke),           write(', '),
	write('alco = '),               writeq(Alco),            write(', '),
    write('active = '),             writeq(Active),          write(', '),
    write('age = '),                writeq(Age),             writeln(']).'),
    fail.
starttt :-
    aa(Gender, Height, Weight, ApHi, ApLo, Cholesterol, Gluc, Smoke, Alco, Active, Age, 1),
    write('e(sick,['),
    write('gender = '),             writeq(Gender),          write(', '),
    write('height = '),             writeq(Height),          write(', '),
    write('weight = '),             writeq(Weight),          write(', '),
    write('apHi = '),               writeq(ApHi),            write(', '),
    write('apLo = '),               writeq(ApLo),            write(', '),
    write('cholesterol = '),        writeq(Cholesterol),     write(', '),
    write('gluc = '),               writeq(Gluc),            write(', '),
    write('smoke = '),              writeq(Smoke),           write(', '),
    write('alco = '),               writeq(Alco),            write(', '),
    write('active = '),             writeq(Active),          write(', '),
    write('age = '),                writeq(Age),             writeln(']).'),
    fail.
starttt :- told.


/*
startt :-
    tell('stroke_dataset.pl'),
    setof(Gender,A^B^C^D^E^F^G^H^I^L^aa(Gender,A,B,C,D,E,F,G,H,I,L),AttributesGender),
    write('a(gender,'), writeq(AttributesGender), writeln(').'),

    setof(Age,A^B^C^D^E^F^G^H^I^L^aa(A,Age,B,C,D,E,F,G,H,I,L),AttributesAge),
    write('a(age,'), writeq(AttributesAge), writeln(').'),

    setof(Hypertension,A^B^C^D^E^F^G^H^I^L^aa(A,B,Hypertension,C,D,E,F,G,H,I,L),AttributesHypertension),
    write('a(hypertension,'), writeq(AttributesHypertension), writeln(').'),

    setof(Heart_disease,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,Heart_disease,D,E,F,G,H,I,L),AttributesHeart_disease),
    write('a(heart_disease,'), writeq(AttributesHeart_disease), writeln(').'),

    setof(Ever_married,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,Ever_married,E,F,G,H,I,L),AttributesEver_married),
    write('a(ever_married,'), writeq(AttributesEver_married), writeln(').'),

    setof(Work_type,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,Work_type,F,G,H,I,L),AttributesWork_type),
    write('a(work_type,'), writeq(AttributesWork_type), writeln(').'),

    setof(Residence_type,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,Residence_type,G,H,I,L),AttributesResidence_type),
    write('a(residence_type,'), writeq(AttributesResidence_type), writeln(').'),

    setof(Avg_glucose_level,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,Avg_glucose_level,H,I,L),AttributesAvg_glucose_level),
    write('a(avg_glucose_level,'), writeq(AttributesAvg_glucose_level), writeln(').'),

    setof(Bmi,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,H,Bmi,I,L),AttributesBmi),
    write('a(bmi,'), writeq(AttributesBmi), writeln(').'),

    setof(Smoking_status,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,H,I,Smoking_status,L),AttributesSmoking_status),
    write('a(smoking_status,'), writeq(AttributesSmoking_status), writeln(').'),
    starttt.

starttt :-
    aa(Gender,Age,Hypertension,Heart_disease,Ever_married,Work_type,Residence_type,Avg_glucose_level,Bmi,Smoking_status,0),
    write('e(healthy,['),
    write('gender = '),             writeq(Gender),             write(', '),
    write('age = '),                writeq(Age),                write(', '),
    write('hypertension = '),       writeq(Hypertension),       write(', '),
    write('heart_disease = '),      writeq(Heart_disease),      write(', '),
    write('ever_married = '),       writeq(Ever_married),       write(', '),
    write('work_type = '),          writeq(Work_type),          write(', '),
    write('residence_type = '),     writeq(Residence_type),     write(', '),
    write('avg_glucose_level = '),  writeq(Avg_glucose_level),  write(', '),
	write('bmi = '),                writeq(Bmi),                write(', '),
    write('smoking_status = '),     writeq(Smoking_status),     writeln(']).'),
    fail.
starttt :-
    aa(Gender,Age,Hypertension,Heart_disease,Ever_married,Work_type,Residence_type,Avg_glucose_level,Bmi,Smoking_status,1),
    write('e(sick,['),
    write('gender = '),             writeq(Gender),             write(', '),
    write('age = '),                writeq(Age),                write(', '),
    write('hypertension = '),       writeq(Hypertension),       write(', '),
    write('heart_disease = '),      writeq(Heart_disease),      write(', '),
    write('ever_married = '),       writeq(Ever_married),       write(', '),
    write('work_type = '),          writeq(Work_type),          write(', '),
    write('residence_type = '),     writeq(Residence_type),     write(', '),
    write('avg_glucose_level = '),  writeq(Avg_glucose_level),  write(', '),
	write('bmi = '),                writeq(Bmi),                write(', '),
    write('smoking_status = '),     writeq(Smoking_status),     writeln(']).'),
    fail.
starttt :- told.
*/