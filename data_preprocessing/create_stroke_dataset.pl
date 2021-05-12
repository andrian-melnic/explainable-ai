:- ensure_loaded(cardio_database_ela).

% ['gender', 'height', 'weight', 'ap_hi', 'ap_lo', 'smoke', 'alco', 'active', 'age', 'gluc_norm', 'gluc_above_norm', 'gluc_wabove_norm', 'chol_norm', 'chol_above_norm', 'chol_wabove_norm', 'bmi', CARDIO]

startt :-
    tell('cardio_dataset.pl'),
    setof(Gender,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(Gender,A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributesGender),
    write('a(gender,'), writeq(AttributesGender), writeln(').'),

    setof(Height,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,Height,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributesHeight),
    write('a(height,'), writeq(AttributesHeight), writeln(').'),

    setof(Weight,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,Weight,C,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributesWeight),
    write('a(weight,'), writeq(AttributesWeight), writeln(').'),

    setof(ApHi,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,ApHi,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributesApHi),
    write('a(apHi,'), writeq(AttributesApHi), writeln(').'),

    setof(ApLo,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,ApLo,E,F,G,H,I,L,M,N,O,P,Q,R),AttributesApLo),
    write('a(apLo,'), writeq(AttributesApLo), writeln(').'),

    setof(Smoke,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,Smoke,F,G,H,I,L,M,N,O,P,Q,R),AttributesSmoke),
    write('a(smoke,'), writeq(AttributesSmoke), writeln(').'),

    setof(Alco,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,Alco,G,H,I,L,M,N,O,P,Q,R),AttributesAlco),
    write('a(alco,'), writeq(AttributesAlco), writeln(').'),

    setof(Active,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,Active,H,I,L,M,N,O,P,Q,R),AttributesActive),
    write('a(active,'), writeq(AttributesActive), writeln(').'),

    setof(Age,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,Age,I,L,M,N,O,P,Q,R),AttributesAge),
    write('a(age,'), writeq(AttributesAge), writeln(').'),

    setof(GlucNorm,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,GlucNorm,L,M,N,O,P,Q,R),AttributesGlucNorm),
    write('a(glucNorm,'), writeq(AttributesGlucNorm), writeln(').'),

    setof(GlucAboveNorm,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,GlucAboveNorm,M,N,O,P,Q,R),AttributesGlucAboveNorm),
    write('a(glucAboveNorm,'), writeq(AttributesGlucAboveNorm), writeln(').'),

    setof(GlucWaboveNorm,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,GlucWaboveNorm,N,O,P,Q,R),AttributesGlucWaboveNorm),
    write('a(glucWaboveNorm,'), writeq(AttributesGlucWaboveNorm), writeln(').'),

    setof(CholNorm,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,CholNorm,O,P,Q,R),AttributesCholNorm),
    write('a(cholNorm,'), writeq(AttributesCholNorm), writeln(').'),

    setof(CholAboveNorm,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,CholAboveNorm,P,Q,R),AttributesCholAboveNorm),
    write('a(cholAboveNorm,'), writeq(AttributesCholAboveNorm), writeln(').'),

    setof(CholWaboveNorm,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,CholWaboveNorm,Q,R),AttributesCholWaboveNorm),
    write('a(cholWaboveNorm,'), writeq(AttributesCholWaboveNorm), writeln(').'),

    setof(Bmi,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,Bmi,R),AttributesBmi),
    write('a(bmi,'), writeq(AttributesBmi), writeln(').'),

    starttt.

% ['gender', 'height', 'weight', 'ap_hi', 'ap_lo', 'smoke', 'alco', 'active', 'age', 'gluc_norm', 'gluc_above_norm', 'gluc_wabove_norm', 'chol_norm', 'chol_above_norm', 'chol_wabove_norm', 'bmi',CARDIO]

starttt :-
    aa(Gender, Height, Weight, ApHi, ApLo, Smoke, Alco, Active, Age, GlucNorm, GlucAboveNorm, GlucWaboveNorm, CholNorm, CholAboveNorm, CholWaboveNorm, Bmi, 0),
    write('e(healthy,['),
    write('gender = '),             writeq(Gender),             write(', '),
    write('height = '),             writeq(Height),             write(', '),
    write('weight = '),             writeq(Weight),             write(', '),
    write('apHi = '),               writeq(ApHi),               write(', '),
    write('apLo = '),               writeq(ApLo),               write(', '),
    write('glucNorm = '),           writeq(GlucNorm),           write(', '),
    write('glucAboveNorm = '),      writeq(GlucAboveNorm),      write(', '),
    write('glucWaboveNorm = '),     writeq(GlucWaboveNorm),     write(', '),
    write('cholNorm = '),           writeq(CholNorm),           write(', '),
    write('cholAboveNorm = '),      writeq(CholAboveNorm),      write(', '),
    write('cholWaboveNorm = '),     writeq(CholWaboveNorm),     write(', '),
    write('bmi = '),                writeq(Bmi),                write(', '),
    write('smoke = '),              writeq(Smoke),              write(', '),
	write('alco = '),               writeq(Alco),               write(', '),
    write('active = '),             writeq(Active),             write(', '),
    write('age = '),                writeq(Age),                writeln(']).'),
    fail.
starttt :-
    aa(Gender, Height, Weight, ApHi, ApLo, Smoke, Alco, Active, Age, GlucNorm, GlucAboveNorm, GlucWaboveNorm, CholNorm, CholAboveNorm, CholWaboveNorm, Bmi, 1),
    write('e(sick,['),
    write('gender = '),             writeq(Gender),             write(', '),
    write('height = '),             writeq(Height),             write(', '),
    write('weight = '),             writeq(Weight),             write(', '),
    write('apHi = '),               writeq(ApHi),               write(', '),
    write('apLo = '),               writeq(ApLo),               write(', '),
    write('glucNorm = '),           writeq(GlucNorm),           write(', '),
    write('glucAboveNorm = '),      writeq(GlucAboveNorm),      write(', '),
    write('glucWaboveNorm = '),     writeq(GlucWaboveNorm),     write(', '),
    write('cholNorm = '),           writeq(CholNorm),           write(', '),
    write('cholAboveNorm = '),      writeq(CholAboveNorm),      write(', '),
    write('cholWaboveNorm = '),     writeq(CholWaboveNorm),     write(', '),
    write('bmi = '),                writeq(Bmi),                write(', '),
    write('smoke = '),              writeq(Smoke),              write(', '),
	write('alco = '),               writeq(Alco),               write(', '),
    write('active = '),             writeq(Active),             write(', '),
    write('age = '),                writeq(Age),                writeln(']).'),
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