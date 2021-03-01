# EEG-Classification-SVM

This project contains different types of Support Vector Machine classifiers written in matlab and applied to three datasets.
This repository contains 4 folders as follows:

## SVM

This folder contains the m files for different types of SVMs all written from scratch without using any library:
1. C-SVM
2. LS-SVM
3. One class SVM
4. RBF kernel SVM
5. nu SVM
6. Multiclass kernel based SVM

## BCI Competition III Dataset II
This folder contains the code for P300 speller problem. SVMs are applied to the dataset to predict whether or not the p300 evoke potential has been occured in EEG signal.
The dataset is availabel in the BCI competition [website](http://www.bbci.de/competition/iii/#datasets) and should be downloaded and copied into the project folder before running the files.

## BCI Competition III Dataset IIIa
This folder contains the code for motor imagery problem. The written multiclass kernel SVMs are applied to the dataset to predict which direction the subject was intended to move towards to.
The dataset is available in the BCI competition [website](http://www.bbci.de/competition/iii/#datasets) and should be downloaded and copied into the project folder before running the files.


## Seizure Data
This folder contains the code for determining the seizure moments in EEG signals. It applie the written one class SVM to the dataset.
The dataset is available in [physionet](https://physionet.org/content/chbmit/1.0.0/) and should be downloaded and copied into the project folder before running the files.
