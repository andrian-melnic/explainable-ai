:- ensure_loaded(stroke_database_ela).


startt :-
    tell('stroke_dataset.pl'),
    setof(Age,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(Age,A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesAge),
    write('a(age,'), writeq(AttributesAge), writeln(').'),
    
    setof(Hypertension,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,Hypertension,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesHypertension),
    write('a(hypertension,'), writeq(AttributesHypertension), writeln(').'),
    
    setof(Heart_disease,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,Heart_disease,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesHeart_disease),
    write('a(heart_disease,'), writeq(AttributesHeart_disease), writeln(').'),
    
    setof(Avg_glucose_level,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,Avg_glucose_level,D,E,F,G,H,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesAvg_glucose_level),
    write('a(avg_glucose_level,'), writeq(AttributesAvg_glucose_level), writeln(').'),
    
    setof(Bmi,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,Bmi,E,F,G,H,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesBmi),
    write('a(bmi,'), writeq(AttributesBmi), writeln(').'),
    
    setof(Gender_female,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,Gender_female,F,G,H,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesGender_female),
    write('a(gender_female,'), writeq(AttributesGender_female), writeln(').'),
    
    setof(Gender_male,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,Gender_male,G,H,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesGender_male),
    write('a(gender_male,'), writeq(AttributesGender_male), writeln(').'),
    
    setof(Gender_other,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,Gender_other,H,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesGender_other),
    write('a(gender_other,'), writeq(AttributesGender_other), writeln(').'),
    
    setof(Ever_married_no,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,Ever_married_no,I,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesEver_married_no),
    write('a(ever_married_no,'), writeq(AttributesEver_married_no), writeln(').'),
    
    setof(Ever_married_yes,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,Ever_married_yes,L,M,N,O,P,Q,R,S,T,U,V,W),AttributesEver_married_yes),
    write('a(ever_married_yes,'), writeq(AttributesEver_married_yes), writeln(').'),
    
    setof(Residence_type_rural,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,Residence_type_rural,M,N,O,P,Q,R,S,T,U,V,W),AttributesResidence_type_rural),
    write('a(residence_type_rural,'), writeq(AttributesResidence_type_rural), writeln(').'),
    
    setof(Residence_type_urban,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,Residence_type_urban,N,O,P,Q,R,S,T,U,V,W),AttributesResidence_type_urban),
    write('a(residence_type_urban,'), writeq(AttributesResidence_type_urban), writeln(').'),
    
    setof(Smoking_status_unknown,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,Smoking_status_unknown,O,P,Q,R,S,T,U,V,W),AttributesSmoking_status_unknown),
    write('a(smoking_status_unknown,'), writeq(AttributesSmoking_status_unknown), writeln(').'),
    
    setof(Smoking_status_formerly_smoked,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,Smoking_status_formerly_smoked,P,Q,R,S,T,U,V,W),AttributesSmoking_status_formerly_smoked),
    write('a(smoking_status_formerly_smoked,'), writeq(AttributesSmoking_status_formerly_smoked), writeln(').'),
    
    setof(Smoking_status_never_smoked,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Smoking_status_never_smoked,Q,R,S,T,U,V,W),AttributesSmoking_status_never_smoked),
    write('a(smoking_status_never_smoked,'), writeq(AttributesSmoking_status_never_smoked), writeln(').'),
    
    setof(Smoking_status_smokes,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,Smoking_status_smokes,R,S,T,U,V,W),AttributesSmoking_status_smokes),
    write('a(smoking_status_smokes,'), writeq(AttributesSmoking_status_smokes), writeln(').'),
    
    setof(Work_type_govt_job,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,Work_type_govt_job,S,T,U,V,W),AttributesWork_type_govt_job),
    write('a(work_type_govt_job,'), writeq(AttributesWork_type_govt_job), writeln(').'),
    
    setof(Work_type_never_worked,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,S,Work_type_never_worked,T,U,V,W),AttributesWork_type_never_worked),
    write('a(work_type_never_worked,'), writeq(AttributesWork_type_never_worked), writeln(').'),
    
    setof(Work_type_private,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,S,T,Work_type_private,U,V,W),AttributesWork_type_private),
    write('a(work_type_private,'), writeq(AttributesWork_type_private), writeln(').'),
    
    setof(Work_type_self_employed,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,S,T,U,Work_type_self_employed,V,W),AttributesWork_type_self_employed),
    write('a(work_type_self_employed,'), writeq(AttributesWork_type_self_employed), writeln(').'),
    
    setof(Work_type_children,A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,S,T,U,V,Work_type_children,W),AttributesWork_type_children),
    write('a(work_type_children,'), writeq(AttributesWork_type_children), writeln(').').
    

starttt :-
    aa(Age,Hypertension,Heart_disease,Avg_glucose_level,Bmi,Gender_female,Gender_male,Gender_other,Ever_married_no,Ever_married_yes,Residence_type_rural,Residence_type_urban,Smoking_status_unknown,Smoking_status_formerly_smoked,Smoking_status_never_smoked,Smoking_status_smokes,Work_type_govt_job,Work_type_never_worked,Work_type_private,Work_type_self_employed,Work_type_children,0),
    write('e(healthy,['),
    write('age = '),                                writeq(Age),                                write(', '),
    write('hypertension = '),                       writeq(Hypertension),                       write(', '),
    write('heart_disease = '),                      writeq(Heart_disease),                      write(', '),
    write('avg_glucose_level = '),                  writeq(Avg_glucose_level),                  write(', '),
	write('bmi = '),                                writeq(Bmi),                                write(', '),
    write('gender_female = '),                      writeq(Gender_female),                      write(', '),       
    write('gender_male = '),                        writeq(Gender_male),                        write(', '),
    write('gender_other = '),                       writeq(Gender_other),                       write(', '),       
    write('ever_married_no = '),                    writeq(Ever_married_no),                    write(', '),
    write('ever_married_yes = '),                   writeq(Ever_married_yes),                   write(', '),
    write('residence_type_rural = '),               writeq(Residence_type_rural),               write(', '),
    write('residence_type_urban = '),               writeq(Residence_type_urban),               write(', '),
    write('smoking_status_unknown = '),             writeq(Smoking_status_unknown),             write(', '),
    write('smoking_status_formerly_smoked = '),     writeq(Smoking_status_formerly_smoked),     write(', '),
    write('smoking_status_never_smoked = '),        writeq(Smoking_status_never_smoked),        write(', '),
    write('smoking_status_smokes = '),              writeq(Smoking_status_smokes),              write(', '),
    write('work_type_govt_job = '),                 writeq(Work_type_govt_job),                 write(', '),
    write('work_type_never_worked = '),             writeq(Work_type_never_worked),             write(', '),
    write('work_type_private = '),                  writeq(Work_type_private),                  write(', '),
    write('work_type_self_employed = '),            writeq(Work_type_self_employed),            write(', '),
    write('work_type_children = '),                 writeq(Work_type_children),                 writeln(']).'),
    fail.

starttt :-
    aa(Age,Hypertension,Heart_disease,Avg_glucose_level,Bmi,Gender_female,Gender_male,Gender_other,Ever_married_no,Ever_married_yes,Residence_type_rural,Residence_type_urban,Smoking_status_unknown,Smoking_status_formerly_smoked,Smoking_status_never_smoked,Smoking_status_smokes,Work_type_govt_job,Work_type_never_worked,Work_type_private,Work_type_self_employed,Work_type_children,1),
    write('e(sick,['),
    write('age = '),                                writeq(Age),                                write(', '),
    write('hypertension = '),                       writeq(Hypertension),                       write(', '),
    write('heart_disease = '),                      writeq(Heart_disease),                      write(', '),
    write('avg_glucose_level = '),                  writeq(Avg_glucose_level),                  write(', '),
	write('bmi = '),                                writeq(Bmi),                                write(', '),
    write('gender_female = '),                      writeq(Gender_female),                      write(', '),       
    write('gender_male = '),                        writeq(Gender_male),                        write(', '),
    write('gender_other = '),                       writeq(Gender_other),                       write(', '),       
    write('ever_married_no = '),                    writeq(Ever_married_no),                    write(', '),
    write('ever_married_yes = '),                   writeq(Ever_married_yes),                   write(', '),
    write('residence_type_rural = '),               writeq(Residence_type_rural),               write(', '),
    write('residence_type_urban = '),               writeq(Residence_type_urban),               write(', '),
    write('smoking_status_unknown = '),             writeq(Smoking_status_unknown),             write(', '),
    write('smoking_status_formerly_smoked = '),     writeq(Smoking_status_formerly_smoked),     write(', '),
    write('smoking_status_never_smoked = '),        writeq(Smoking_status_never_smoked),        write(', '),
    write('smoking_status_smokes = '),              writeq(Smoking_status_smokes),              write(', '),
    write('work_type_govt_job = '),                 writeq(Work_type_govt_job),                 write(', '),
    write('work_type_never_worked = '),             writeq(Work_type_never_worked),             write(', '),
    write('work_type_private = '),                  writeq(Work_type_private),                  write(', '),
    write('work_type_self_employed = '),            writeq(Work_type_self_employed),            write(', '),
    write('work_type_children = '),                 writeq(Work_type_children),                 writeln(']).'),
    fail.

starttt :- told.


% startt :-
%     tell('stroke_dataset.pl'),
%     setof(Gender,A^B^C^D^E^F^G^H^I^L^aa(Gender,A,B,C,D,E,F,G,H,I,L),AttributesGender),
%     write('a(gender,'), writeq(AttributesGender), writeln(').'),

%     setof(Age,A^B^C^D^E^F^G^H^I^L^aa(A,Age,B,C,D,E,F,G,H,I,L),AttributesAge),
%     write('a(age,'), writeq(AttributesAge), writeln(').'),

%     setof(Hypertension,A^B^C^D^E^F^G^H^I^L^aa(A,B,Hypertension,C,D,E,F,G,H,I,L),AttributesHypertension),
%     write('a(hypertension,'), writeq(AttributesHypertension), writeln(').'),

%     setof(Heart_disease,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,Heart_disease,D,E,F,G,H,I,L),AttributesHeart_disease),
%     write('a(heart_disease,'), writeq(AttributesHeart_disease), writeln(').'),

%     setof(Ever_married,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,Ever_married,E,F,G,H,I,L),AttributesEver_married),
%     write('a(ever_married,'), writeq(AttributesEver_married), writeln(').'),

%     setof(Work_type,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,Work_type,F,G,H,I,L),AttributesWork_type),
%     write('a(work_type,'), writeq(AttributesWork_type), writeln(').'),

%     setof(Residence_type,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,Residence_type,G,H,I,L),AttributesResidence_type),
%     write('a(residence_type,'), writeq(AttributesResidence_type), writeln(').'),

%     setof(Avg_glucose_level,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,Avg_glucose_level,H,I,L),AttributesAvg_glucose_level),
%     write('a(avg_glucose_level,'), writeq(AttributesAvg_glucose_level), writeln(').'),

%     setof(Bmi,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,H,Bmi,I,L),AttributesBmi),
%     write('a(bmi,'), writeq(AttributesBmi), writeln(').'),

%     setof(Smoking_status,A^B^C^D^E^F^G^H^I^L^aa(A,B,C,D,E,F,G,H,I,Smoking_status,L),AttributesSmoking_status),
%     write('a(smoking_status,'), writeq(AttributesSmoking_status), writeln(').'),
%     starttt.

% starttt :-
%     aa(Gender,Age,Hypertension,Heart_disease,Ever_married,Work_type,Residence_type,Avg_glucose_level,Bmi,Smoking_status,0),
%     write('e(healthy,['),
%     write('gender = '),             writeq(Gender),             write(', '),
%     write('age = '),                writeq(Age),                write(', '),
%     write('hypertension = '),       writeq(Hypertension),       write(', '),
%     write('heart_disease = '),      writeq(Heart_disease),      write(', '),
%     write('ever_married = '),       writeq(Ever_married),       write(', '),
%     write('work_type = '),          writeq(Work_type),          write(', '),
%     write('residence_type = '),     writeq(Residence_type),     write(', '),
%     write('avg_glucose_level = '),  writeq(Avg_glucose_level),  write(', '),
% 	write('bmi = '),                writeq(Bmi),                write(', '),
%     write('smoking_status = '),     writeq(Smoking_status),     writeln(']).'),
%     fail.
% starttt :-
%     aa(Gender,Age,Hypertension,Heart_disease,Ever_married,Work_type,Residence_type,Avg_glucose_level,Bmi,Smoking_status,1),
%     write('e(sick,['),
%     write('gender = '),             writeq(Gender),             write(', '),
%     write('age = '),                writeq(Age),                write(', '),
%     write('hypertension = '),       writeq(Hypertension),       write(', '),
%     write('heart_disease = '),      writeq(Heart_disease),      write(', '),
%     write('ever_married = '),       writeq(Ever_married),       write(', '),
%     write('work_type = '),          writeq(Work_type),          write(', '),
%     write('residence_type = '),     writeq(Residence_type),     write(', '),
%     write('avg_glucose_level = '),  writeq(Avg_glucose_level),  write(', '),
% 	write('bmi = '),                writeq(Bmi),                write(', '),
%     write('smoking_status = '),     writeq(Smoking_status),     writeln(']).'),
%     fail.
% starttt :- told.