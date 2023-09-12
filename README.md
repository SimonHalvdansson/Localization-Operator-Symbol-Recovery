# Localization-Operator-Symbol-Recovery
This repository contains an implementation of all the methods detailed in the paper [Five ways to recover the symbol of a non-binary localization operator](https://arxiv.org/abs/2301.11618) in MATLAB. For ease of use, a copy of [LTFAT](https://github.com/ltfat/ltfat) is included in the repository which is the framework we use for the implementation.

The file `main.m` sets up the symbol, window and operator and calls all the different recovery techniques. It is also responsible for plotting, error measurements and deconvolution.

As LTFT is licensed under GPLv3, so is this project. None of the LTFAT files have been changed.
