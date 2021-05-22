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
|-- indexes_policy
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
<img src="https://latex.codecogs.com/gif.latex?Gain(A)&space;=&space;B\left(\frac{p}{p&plus;n}\right)&space;-&space;\sum_{k=1}^{d}P(TS_k)B(TS_k)!" />

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
carica_dataset(stroke).
```
Unload the dataset:
```
reset_dataset(stroke).
```
Run all the tree inductions:
```
induci.
```
or run a single tree induction for each splitting criteria:
```
induce_albero(gini, Albero).
```
```
induce_albero(gain, Albero).
```
```
induce_albero(gainratio, Albero).
```
Print the Confusion Matrix:
```
stampa_matrice_confusione.
```

## 🔖 Results <a name = "results"></a>

- ### Heart Dataset
  - #### Gini
    ```
    Test effettuati :62
    Test non classificati :0
    Veri Negativi  26   Falsi Positivi 3
    Falsi Negativi 0   Veri Positivi  33
    Accuratezza: 0.9516129032258065
    Errore: 0.048387096774193505
    ```
  - #### Information Gain
    ```
    Test effettuati :62
    Test non classificati :0
    Veri Negativi  26   Falsi Positivi 3
    Falsi Negativi 1   Veri Positivi  32
    Accuratezza: 0.9354838709677419
    Errore: 0.06451612903225812
    ```
  - #### Gain Ratio
    ```
    Test effettuati :62
    Test non classificati :0
    Veri Negativi  27   Falsi Positivi 2
    Falsi Negativi 4   Veri Positivi  29
    Accuratezza: 0.9032258064516129
    Errore: 0.09677419354838712
    ```

- ### Stroke Dataset
  - #### Gini
    ```
    Test effettuati :77
    Test non classificati :5
    Veri Negativi  49   Falsi Positivi 10
    Falsi Negativi 0   Veri Positivi  13
    Accuratezza: 0.8611111111111112
    Errore: 0.13888888888888884
    ```
  - #### Information Gain
    ```
    Test effettuati :77
    Test non classificati :5
    Veri Negativi  47   Falsi Positivi 12
    Falsi Negativi 0   Veri Positivi  13
    Accuratezza: 0.8333333333333334
    Errore: 0.16666666666666663
    ```
  - #### Gain Ratio
    ```
    Test effettuati :77
    Test non classificati :5
    Veri Negativi  51   Falsi Positivi 10
    Falsi Negativi 0   Veri Positivi  11
    Accuratezza: 0.8611111111111112
    Errore: 0.13888888888888884
    ```

## ⛏️ Built Using <a name = "built_using"></a>

- [SWI-Prolog](https://www.swi-prolog.org/)

## ✍️ Authors <a name = "authors"></a>

- Conti Edoardo [@edoardo-conti](https://github.com/edoardo-conti)
- Federici Lorenzo [@lorenzo-federici](https://github.com/lorenzo-federici)
- Melnic Andrian [@andrian-melnic](https://github.com/andrian-melnic)

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [51188] Artificial Intelligence Class - Professor <a href="https://www.dii.univpm.it/aldo.franco.dragoni"><i>Aldo Franco Dragoni</i></a>
