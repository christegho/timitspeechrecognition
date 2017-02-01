# timitspeechrecognition

This project is concerned with phone-based continuous speech recognition using Hidden Markov Models (HMMs).

The first part of the practical uses Gaussian and Gaussian mixture models (GMM- HMMs) to form the state output distributions, and the second part investigates the use of Deep Neural Networks (DNNs) in a hybrid configuration to form DNN-HMMs. The aim is to develop a speaker independent phone recognition system for the TIMIT Acoustic-Phonetic speech database based on these types of models.

The project involves training and testing HMMs for the TIMIT corpus and examining various configurations for front-end features including differential coefficients; the use of context independent and context dependent models; and allows the investigation of a number of extensions including the use of phone-level language models instead of a simple phone-loop grammar in recognition.

All training and testing uses the HTK HMM toolkit. A set of private scripts are provided by the Engineering Department, University of Cambridge to help run the experiments.

Full Report: https://github.com/christegho/timitspeechrecognition/blob/master/ASR-HTK.pdf

This repository is used to store all additional files, scripts, and results needed to complete the project.
