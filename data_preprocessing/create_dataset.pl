/***
 * UNIVPM - Intelligenza Artificiale (a.a. 2020/2021)
 * Albero di Decisione binario con diverse politiche di scelta dell'attributo (Gini, Gain, Gainratio)
 * 
 * Conti Edoardo 		-	S1100649@studenti.univpm.it
 * Federici Lorenzo 	- 	S1098086@studenti.univpm.it
 * Andrian Melnic 		- 	S1098384@studenti.univpm.it
 * 
 * create_dataset.pl
 ***/	


% dataset -> stroke 
startt(stroke) :-
    ensure_loaded(data_preprocessing/stroke/stroke_database_elab),
    tell('data_preprocessing/stroke/stroke_dataset.pl'),
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
    starttt(stroke).
% dataset -> stroke one hot encoding
startt(stroke_ohe) :-
    ensure_loaded(data_preprocessing/stroke_ohe/stroke_ohe_database_elab),
    tell('data_preprocessing/stroke_ohe/stroke_ohe_dataset.pl'),
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
    write('a(work_type_children,'), writeq(AttributesWork_type_children), writeln(').'),
    starttt(stroke_ohe).
% dataset -> heart
startt(heart) :-
    ensure_loaded(data_preprocessing/heart/heart_database_elab),
    tell('data_preprocessing/heart/heart_dataset.pl'),
    setof(Age,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,Age,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiAge),
    write('a(age,'), writeq(AttributiAge), writeln(').'),

    setof(Sex,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,Sex,C,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiSex),
    write('a(sex,'), writeq(AttributiSex), writeln(').'),

    setof(Thalach,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,Thalach,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiThalach),
    write('a(thalach,'), writeq(AttributiThalach), writeln(').'),

    setof(Exang,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,Exang,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiExang),
    write('a(exang,'), writeq(AttributiExang), writeln(').'),

    setof(Oldpeak,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,Oldpeak,F,G,H,I,L,M,N,O,P,Q,R),AttributiOldpeak),
    write('a(oldpeak,'), writeq(AttributiOldpeak), writeln(').'),

    setof(Ca,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,Ca,G,H,I,L,M,N,O,P,Q,R),AttributiCa),
    write('a(ca,'), writeq(AttributiCa), writeln(').'),

    setof(Cp_0,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,Cp_0,H,I,L,M,N,O,P,Q,R),AttributiCp_0),
    write('a(cp_0,'), writeq(AttributiCp_0), writeln(').'),

    setof(Cp_1,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,Cp_1,I,L,M,N,O,P,Q,R),AttributiCp_1),
    write('a(cp_1,'), writeq(AttributiCp_1), writeln(').'),

    setof(Cp_2,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,Cp_2,L,M,N,O,P,Q,R),AttributiCp_2),
    write('a(cp_2,'), writeq(AttributiCp_2), writeln(').'),

    setof(Cp_3,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,Cp_3,M,N,O,P,Q,R),AttributiCp_3),
    write('a(cp_3,'), writeq(AttributiCp_3), writeln(').'),

    setof(Slope_0,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,Slope_0,N,O,P,Q,R),AttributiSlope_0),
    write('a(slope_0,'), writeq(AttributiSlope_0), writeln(').'),

    setof(Slope_1,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,Slope_1,O,P,Q,R),AttributiSlope_1),
    write('a(slope_1,'), writeq(AttributiSlope_1), writeln(').'),

    setof(Slope_2,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,Slope_2,P,Q,R),AttributiSlope_2),
    write('a(slope_2,'), writeq(AttributiSlope_2), writeln(').'),

    setof(Thal_1,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Thal_1,Q,R),AttributiThal_1),
    write('a(thal_1,'), writeq(AttributiThal_1), writeln(').'),

    setof(Thal_2,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,Thal_2,R),AttributiThal_2),
    write('a(thal_2,'), writeq(AttributiThal_2), writeln(').'),

    setof(Thal_3,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R,Thal_3),AttributiThal_3),
    write('a(thal_3,'), writeq(AttributiThal_3), writeln(').'),
	starttt(heart).
% dataset -> obesity
startt(obesity) :-
    ensure_loaded(data_preprocessing/obesity/obesity_database_elab),
    tell('data_preprocessing/obesity/obesity_dataset.pl'),
    setof(GENDER,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(GENDER,A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiGENDER),
    write('a(gender,'), writeq(AttributiGENDER), writeln(').'),

    setof(AGE,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,AGE,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiAGE),
    write('a(age,'), writeq(AttributiAGE), writeln(').'),

    setof(HEIGHT,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,HEIGHT,C,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiHEIGHT),
    write('a(height,'), writeq(AttributiHEIGHT), writeln(').'),

    setof(WEIGHT,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,WEIGHT,D,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiWEIGHT),
    write('a(weight,'), writeq(AttributiWEIGHT), writeln(').'),

    setof(FHO,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,FHO,E,F,G,H,I,L,M,N,O,P,Q,R),AttributiFHO),
    write('a(fho,'), writeq(AttributiFHO), writeln(').'),

    setof(FAVC,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,FAVC,F,G,H,I,L,M,N,O,P,Q,R),AttributiFAVC),
    write('a(favc,'), writeq(AttributiFAVC), writeln(').'),

    setof(FCVC,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,FCVC,G,H,I,L,M,N,O,P,Q,R),AttributiFCVC),
    write('a(fcvc,'), writeq(AttributiFCVC), writeln(').'),

    setof(NCP,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,NCP,H,I,L,M,N,O,P,Q,R),AttributiNCP),
    write('a(ncp,'), writeq(AttributiNCP), writeln(').'),

    setof(CAEC,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,CAEC,I,L,M,N,O,P,Q,R),AttributiCAEC),
    write('a(caec,'), writeq(AttributiCAEC), writeln(').'),

    setof(SMOKE,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,SMOKE,L,M,N,O,P,Q,R),AttributiSMOKE),
    write('a(smoke,'), writeq(AttributiSMOKE), writeln(').'),

    setof(CH2O,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,CH2O,M,N,O,P,Q,R),AttributiCH2O),
    write('a(ch20,'), writeq(AttributiCH2O), writeln(').'),

    setof(SCC,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,SCC,N,O,P,Q,R),AttributiSCC),
    write('a(scc,'), writeq(AttributiSCC), writeln(').'),

    setof(FAF,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,FAF,O,P,Q,R),AttributiFAF),
    write('a(faf,'), writeq(AttributiFAF), writeln(').'),

    setof(TUE,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,TUE,P,Q,R),AttributiTUE),
    write('a(tue,'), writeq(AttributiTUE), writeln(').'),

    setof(CALC,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,CALC,Q,R),AttributiCALC),
    write('a(calc,'), writeq(AttributiCALC), writeln(').'),

    setof(MTRANS,A^B^C^D^E^F^G^H^I^L^M^N^O^P^Q^R^aa(A,B,C,D,E,F,G,H,I,L,M,N,O,P,Q,MTRANS,R),AttributiMTRANS),
    write('a(mtrans,'), writeq(AttributiMTRANS), writeln(').'),

	starttt(obesity).

% dataset attributi -> stroke 
starttt(stroke) :-
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
starttt(stroke) :-
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
% dataset attributi -> stroke one hot encoding
starttt(stroke_ohe) :-
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
starttt(stroke_ohe) :-
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
% dataset attributi -> heart
starttt(heart) :-
    aa(0,Age,Sex,Thalach,Exang,Oldpeak,Ca,Cp_0,Cp_1,Cp_2,Cp_3,Slope_0,Slope_1,Slope_2,Thal_1,Thal_2,Thal_3),
    write('e(sano,['),
    write('age = '),writeq(Age), write(', '),
    write('sex = '),writeq(Sex), write(', '),
    write('thalach = '),writeq(Thalach), write(', '),
    write('exang = '),writeq(Exang), write(', '),
    write('oldpeak = '),writeq(Oldpeak), write(', '),
    write('ca = '),writeq(Ca), write(', '),
	write('cp_0 = '),writeq(Cp_0), write(', '),
    write('cp_1 = '),writeq(Cp_1), write(', '),
    write('cp_2 = '),writeq(Cp_2), write(', '),
    write('cp_3 = '),writeq(Cp_3), write(', '),
    write('slope_0 = '),writeq(Slope_0), write(', '),
    write('slope_1 = '),writeq(Slope_1), write(', '),
    write('slope_2 = '),writeq(Slope_2), write(', '),
    write('thal_1 = '),writeq(Thal_1), write(', '),
    write('thal_2 = '),writeq(Thal_2), write(', '),
    write('thal_3 = '),writeq(Thal_3), writeln(']).'),
    fail.
starttt(heart) :-
    aa(1,Age,Sex,Thalach,Exang,Oldpeak,Ca,Cp_0,Cp_1,Cp_2,Cp_3,Slope_0,Slope_1,Slope_2,Thal_1,Thal_2,Thal_3),
    write('e(malato,['),
    write('age = '),writeq(Age), write(', '),
    write('sex = '),writeq(Sex), write(', '),
    write('thalach = '),writeq(Thalach), write(', '),
    write('exang = '),writeq(Exang), write(', '),
    write('oldpeak = '),writeq(Oldpeak), write(', '),
    write('ca = '),writeq(Ca), write(', '),
	write('cp_0 = '),writeq(Cp_0), write(', '),
    write('cp_1 = '),writeq(Cp_1), write(', '),
    write('cp_2 = '),writeq(Cp_2), write(', '),
    write('cp_3 = '),writeq(Cp_3), write(', '),
    write('slope_0 = '),writeq(Slope_0), write(', '),
    write('slope_1 = '),writeq(Slope_1), write(', '),
    write('slope_2 = '),writeq(Slope_2), write(', '),
    write('thal_1 = '),writeq(Thal_1), write(', '),
    write('thal_2 = '),writeq(Thal_2), write(', '),
    write('thal_3 = '),writeq(Thal_3), writeln(']).'),
    fail.
% dataset attributi -> obesity
starttt(obesity) :-
    aa(GENDER,AGE,HEIGHT,WEIGHT,FHO,FAVC,FCVC,NCP,CAEC,SMOKE,CH2O,SCC,FAF,TUE,CALC,MTRANS,0),
    write('e(healthy,['),
    write('gender = '),writeq(GENDER), write(', '),
    write('age = '),writeq(AGE), write(', '),
    write('height = '),writeq(HEIGHT), write(', '),
    write('weight = '),writeq(WEIGHT), write(', '),
    write('fho = '),writeq(FHO), write(', '),
    write('favc = '),writeq(FAVC), write(', '),
	write('fcvc = '),writeq(FCVC), write(', '),
    write('ncp = '),writeq(NCP), write(', '),
    write('caec = '),writeq(CAEC), write(', '),
    write('smoke = '),writeq(SMOKE), write(', '),
    write('ch20 = '),writeq(CH2O), write(', '),
    write('scc = '),writeq(SCC), write(', '),
    write('faf = '),writeq(FAF), write(', '),
    write('tue = '),writeq(TUE), write(', '),
    write('calc = '),writeq(CALC), write(', '),
    write('mtrans = '),writeq(MTRANS), writeln(']).'),
    fail.
starttt(obesity) :-
    aa(GENDER,AGE,HEIGHT,WEIGHT,FHO,FAVC,FCVC,NCP,CAEC,SMOKE,CH2O,SCC,FAF,TUE,CALC,MTRANS,1),
    write('e(sick,['),
    write('gender = '),writeq(GENDER), write(', '),
    write('age = '),writeq(AGE), write(', '),
    write('height = '),writeq(HEIGHT), write(', '),
    write('weight = '),writeq(WEIGHT), write(', '),
    write('fho = '),writeq(FHO), write(', '),
    write('favc = '),writeq(FAVC), write(', '),
	write('fcvc = '),writeq(FCVC), write(', '),
    write('ncp = '),writeq(NCP), write(', '),
    write('caec = '),writeq(CAEC), write(', '),
    write('smoke = '),writeq(SMOKE), write(', '),
    write('ch20 = '),writeq(CH2O), write(', '),
    write('scc = '),writeq(SCC), write(', '),
    write('faf = '),writeq(FAF), write(', '),
    write('tue = '),writeq(TUE), write(', '),
    write('calc = '),writeq(CALC), write(', '),
    write('mtrans = '),writeq(MTRANS), writeln(']).'),
    fail.

% told
starttt(_) :- told.