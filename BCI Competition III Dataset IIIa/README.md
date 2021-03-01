# BCI Competition III Dataset IIIa

First, run p1.m, or you can just load data_k3_ar_no_artifact.mat instead.

In p2_test_multiclass.m line 7, you can change parameters beta, epoch numbers(en) and gamma in case that you use RBF_kernel version of multiclass SVM.
you can see the result of multiclass SVM by runnign this file.

You can also see the resluts for one versus all by running p2_test_ova.m. in line 8 you can choose the rane for parameter C and see the results.

You can use the forementioned SVMs with various kernels like RBF and polynomial by any paramater by using Multiclass_kernel_SVM.m and Multiclass_polykernel_SVM.m in multiclass case and RBF_Kernel_SVM.m and polyn_kernel.m in one versus all case.
