<p align="center">
  <a href="" rel="noopener">
  <img width=200px height=200px src="https://i.imgur.com/yINaKw4.png" alt="Project logo"></a>
  <div><sub>Icon made by <a href="https://www.flaticon.com/authors/kiranshastry" title="Kiranshastry">Kiranshastry</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></sub></div>
</p>

<h1 align="center">Artificial Intelligence Project</br><sub>Decision Tree - PROLOG Implementation</sub></h1>

<div align="center">

![Status](https://img.shields.io/badge/status-active-success.svg)
![Swi-Prolog](https://img.shields.io/badge/environment-SWI--Prolog-orange)
![UNIVPM](https://img.shields.io/badge/organization-UNIVPM-red)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/SasageyoOrg/ia-decision-tree)
![GitHub](https://img.shields.io/github/license/SasageyoOrg/ia-decision-tree?color=blue)

</div>

---

## 👷‍♂️ Work in Progress... <a name = "wip"></a>

<img width=300 src="https://i.imgur.com/AUljOwd.jpg" />

## 📝 Table of Contents
- [About](#about)
- [Project Topology](#project-topology)
- [Splitting Criteria](#splitting-criteria)
- [Usage](#usage)
- [Results](#results)
- [Built Using](#built_using)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 📋 About <a name = "about"></a>

This is a PROLOG implementation of a Decision Tree with multiple splitting criterias. The criteria used for measuring the goodness of split conditions are information gain, gain ratio and gini index.

Datasets sources:
- <a href="https://www.kaggle.com/fedesoriano/stroke-prediction-dataset">Brain Stroke</a>
- <a href="https://www.kaggle.com/johnsmith88/heart-disease-dataset">Ischemic Heart Disease</a>

## 🗂 Project Topology <a name="project-topology"></a>
```
|-- data_preprocessing
|   |-- heart/...
|   |-- stroke/...
|   |-- create_database_elab.pl
|   |-- create_dataset.pl
|   |-- preprocessing.pl
|   |-- stroke_dataset.csv
|
|-- data
|   |-- heart/...
|   |-- stroke/...
|   
|-- splitting_criteria
|   |-- gini_index.pl
|   |-- information_gain.pl
|   |-- gain_ratio.pl
|
|-- output
|   |-- matrix
|   |   |-- matrix_gini.txt
|   |   |-- matrix_gain.txt
|   |   |-- matrix_gainratio.txt
|   |   
|   |-- tree
|   |   |-- tree_gini.txt
|   |   |-- tree_gain.txt
|   |   |-- tree_gainratio.txt
|   
|-- utility.pl
|-- writes.pl
|-- classify.pl
|-- tree_induction.pl
```

## 📊 Splitting Criteria <a name="splitting-criteria"></a>

### Gini Index
<img src="https://latex.codecogs.com/gif.latex?Gini(A)&space;=&space;\sum_{v}P(v)\sum_{i&space;\neq&space;j}P(i|v)P(j|v)" />

### Information Gain
<img src="https://latex.codecogs.com/gif.latex?Gain(A)&space;=&space;B\left(\frac{p}{p&plus;n}\right)&space;-&space;\sum_{k=1}^{d}P(TS_k)B(TS_k)" />

### Gain Ratio
<img src="https://latex.codecogs.com/gif.latex?GainRatio(A)&space;=&space;\frac{Gain(A)}{&space;-&space;\sum_{v_{A}}P(v_{A})\log_2P(v_{A})}" />

## 👩‍💻 Usage <a name="usage"></a>
Start <b>SWI-Prolog</b>: 
```
$ swipl
```
Load the tree induction program:
```
[tree_induction].
```
Load the avaiable dataset:
```
load_dataset(stroke).
```
Unload the dataset:
```
unload_dataset(stroke).
```
Run all the tree inductions:
```
induce.
```
or run a single tree induction for each splitting criteria:
```
induce_tree(gini, Tree).
```
```
induce_tree(gain, Tree).
```
```
induce_tree(gainratio, Tree).
```
Print the Confusion Matrix:
```
confusion_matrix.
```

## 🔖 Results <a name = "results"></a>

- ### Heart Dataset
  - #### Gini
    ```
    Performed tests: 62
    Unclassified tests: 0
    True negative  (TN): 26	 False positive (FP): 3
    False negative (FN): 0	 True positive  (TP): 33
    Accuracy (ACC): 0.9516129032258065
    Error: 0.048387096774193505
    ```
  - #### Information Gain
    ```
    Performed tests: 62
    Unclassified tests: 0
    True negative  (TN): 26	 False positive (FP): 3
    False negative (FN): 1	 True positive  (TP): 32
    Accuracy (ACC): 0.9354838709677419
    Error: 0.06451612903225812
    ```
  - #### Gain Ratio
    ```
    Performed tests: 62
    Unclassified tests: 0
    True negative  (TN): 27	 False positive (FP): 2
    False negative (FN): 4	 True positive  (TP): 29
    Accuracy (ACC): 0.9032258064516129
    Error: 0.09677419354838712
    ```

- ### Stroke Dataset
  - #### Gini
    ```
    Performed tests: 77
    Unclassified tests: 5
    True negative  (TN): 49	 False positive (FP): 10
    False negative (FN): 0	 True positive  (TP): 13
    Accuracy (ACC): 0.8611111111111112
    Error: 0.13888888888888884
    ```
  - #### Information Gain
    ```
    Performed tests: 77
    Unclassified tests: 5
    True negative  (TN): 47	 False positive (FP): 12
    False negative (FN): 0	 True positive  (TP): 13
    Accuracy (ACC): 0.8333333333333334
    Error: 0.16666666666666663
    ```
  - #### Gain Ratio
    ```
    Performed tests: 77
    Unclassified tests: 5
    True negative  (TN): 51	 False positive (FP): 10
    False negative (FN): 0	 True positive  (TP): 11
    Accuracy (ACC): 0.8611111111111112
    Error: 0.13888888888888884
    ```

## ⛏️ Built Using <a name = "built_using"></a>

- [SWI-Prolog](https://www.swi-prolog.org/)

## ✍️ Authors <a name = "authors"></a>

- Conti Edoardo [@edoardo-conti](https://github.com/edoardo-conti)
- Federici Lorenzo [@lorenzo-federici](https://github.com/lorenzo-federici)
- Melnic Andrian [@andrian-melnic](https://github.com/andrian-melnic)

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [51188] Artificial Intelligence Class - Professor <a href="https://www.dii.univpm.it/aldo.franco.dragoni"><i>Aldo Franco Dragoni</i></a>
