# Seizure Data

Original data from physionet are in edf format in data.zip file. each edf file contains 1 hour of brain signal and more information about data is available in info.txt file.

After loading original data from physionet and feature extraxction, I put them all in all_dat.mat, so you should just load this mat file at the beginning.

For seeing the results of SVM on the data, run test_SVM. It contains both one class SVM and 2class LS SVM.

