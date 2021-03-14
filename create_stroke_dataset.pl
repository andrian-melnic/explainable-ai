:- ensure_loaded(stroke_database_ela).

startt :-
    tell('stroke_dataset.pl'),
    setof(Gender,A^B^C^D^E^F^G^H^I^L^aa(A,Gender,B,C,D,E,F,G,H,I,L),AttributesGender),
    write('a(gender,'), writeq(AttributesGender), writeln(').'),

    setof(Age,A^B^C^D^E^F^G^H^I^L^aa(A,B,Age,C,D,E,F,G,H,I,L),AttributesAge),
    write('a(age,'), writeq(AttributesAge), writeln(').'),

    setof(Hypertension,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,Hypertension,D,E,F,G,H,I,L),AttributesHypertension),
    write('a(hypertension,'), writeq(AttributesHypertension), writeln(').'),

    setof(Heart_disease,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,Heart_disease,E,F,G,H,I,L),AttributesHeart_disease),
    write('a(heart_disease,'), writeq(AttributesHeart_disease), writeln(').'),

    setof(Ever_married,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,Ever_married,F,G,H,I,L),AttributesEver_married),
    write('a(ever_married,'), writeq(AttributesEver_married), writeln(').'),

    setof(Work_type,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,Work_type,G,H,I,L),AttributesWork_type),
    write('a(work_type,'), writeq(AttributesWork_type), writeln(').'),

    setof(Residence_type,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,Residence_type,H,I,L),AttributesResidence_type),
    write('a(residence_type,'), writeq(AttributesResidence_type), writeln(').'),

    setof(Avg_glucose_level,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,H,Avg_glucose_level,I,L),AttributesAvg_glucose_level),
    write('a(avg_glucose_level,'), writeq(AttributesAvg_glucose_level), writeln(').'),

    setof(Bmi,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,H,I,Bmi,L),AttributesBmi),
    write('a(bmi,'), writeq(AttributesBmi), writeln(').'),

    setof(Smoking_status,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,H,I,L,Smoking_status),AttributesSmoking_status),
    write('a(smoking_status,'), writeq(AttributesSmoking_status), writeln(').'),
    starttt.

/*
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

starttt :-
    aa(Gender,Age,Hypertension,Heart_disease,Ever_married,Work_type,Residence_type,Avg_glucose_level,Bmi,Smoking_status,0),
    write('e(['),
    write('gender = '),             writeq(Gender),             write(', '),
    write('age = '),                writeq(Age),                write(', '),
    write('hypertension = '),       writeq(Hypertension),       write(', '),
    write('heart_disease = '),      writeq(Heart_disease),      write(', '),
    write('ever_married = '),       writeq(Ever_married),       write(', '),
    write('work_type = '),          writeq(Work_type),          write(', '),
    write('residence_type = '),     writeq(Residence_type),     write(', '),
    write('avg_glucose_level = '),  writeq(Avg_glucose_level),  write(', '),
	write('bmi = '),                writeq(Bmi),                write(', '),
    write('smoking_status = '),     writeq(Smoking_status),     writeln('],healthy).'),
    fail.
starttt :-
    aa(Gender,Age,Hypertension,Heart_disease,Ever_married,Work_type,Residence_type,Avg_glucose_level,Bmi,Smoking_status,1),
    write('e(['),
    write('gender = '),             writeq(Gender),             write(', '),
    write('age = '),                writeq(Age),                write(', '),
    write('hypertension = '),       writeq(Hypertension),       write(', '),
    write('heart_disease = '),      writeq(Heart_disease),      write(', '),
    write('ever_married = '),       writeq(Ever_married),       write(', '),
    write('work_type = '),          writeq(Work_type),          write(', '),
    write('residence_type = '),     writeq(Residence_type),     write(', '),
    write('avg_glucose_level = '),  writeq(Avg_glucose_level),  write(', '),
	write('bmi = '),                writeq(Bmi),                write(', '),
    write('smoking_status = '),     writeq(Smoking_status),     writeln('],sick).'),
    fail.
starttt :- told.