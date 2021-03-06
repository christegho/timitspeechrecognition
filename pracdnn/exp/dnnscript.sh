###################################################################
#CI - supply frame level alignment of training data - DONE
###################################################################
for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/mono hmm84 \ $file/align-mono-hmm84
done


for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/mono hmm164 \ $file/align-mono-hmm164
done

#DNN Training CI
cd ~/MLSALT2/pracdnn/exp

for file in MFC_E_D_A_Z_Init20   MFC_E_D_A_Z_Flatstart20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -USEGPUID 0 ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/$file
../tools/steps/step-dnntrain -USEGPUID 0 ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm164/align/timit_train.mlf $pracgmmexp/mono/hmm164/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm164/$file
done

for file in FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -USEGPUID 0 ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/$file
../tools/steps/step-dnntrain -USEGPUID 0 ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm164/align/timit_train.mlf $pracgmmexp/mono/hmm164/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm164/$file
done

for hmm in hmm164 hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
	do	
	echo $hmm $file >> dnn.txt
	grep -A7 -P 'Epoch 12' MHO/dnntrain/$hmm/$file/dnn7.finetune/LOG >> dnn.txt
done
done

#Test model - DONE
../tools/steps/step-decode $PWD/MHO/dnntrain dnn7.finetune MHO/decode-dnn7.finetune

for hmm in hmm164 hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
	do	
	echo $hmm $file >> dnntest.txt
	echo $hmm $file
	../tools/steps/step-decode $PWD/MHO/dnntrain/$hmm/$file dnn7.finetune MHO/decode-dnn7.finetune/$hmm/$file
	grep -A2 -P 'SENT' MHO/decode-dnn7.finetune/$hmm/$file/test/LOG >> dnntest.txt
done
done

for hmm in hmm164 hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
	do	
	echo $hmm $file >> dnntest.txt
	grep -A2 -P 'SENT' MHO/decode-dnn7.finetune/$hmm/$file/test/LOG >> dnntest.txt
done
done

###################################################################
#CI - Single Hidden Layer - Varying Context Shift
###################################################################
#must change HTE.dnntrain before - done
for CS in 3 4 5
do
for file in MFC_E_D_A_Z_Init20   MFC_E_D_A_Z_Flatstart20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain1HCS${CS}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_1H_CS${CS}

../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain1HCS${CS} ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm164/align/timit_train.mlf $pracgmmexp/mono/hmm164/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm164/${file}_1H_CS${CS}
done
done
for CS in 3 4 5
do
for file in FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain1HCS${CS}  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_1H_CS${CS}
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain1HCS${CS}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm164/align/timit_train.mlf $pracgmmexp/mono/hmm164/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm164/${file}_1H_CS${CS}
done
done

#Done
for CS in 3 4 5
do
for hmm in hmm164 hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
	do	
	echo $hmm ${file} -CS 4 -H 1 -N 500 >> dnntrain.txt
	grep -A7 -P 'Epoch 12' MHO/dnntrain/$hmm/${file}_1H_CS${CS}/dnn3.finetune/LOG >> dnntrain.txt
done
done
done

#Done
#Test model
for CS in 3 4 5
do
for hmm in hmm164 hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
	do	
	echo $hmm $file -CS $CS -H 1 -N 500 >> dnntest.txt
	echo $hmm $file
	../tools/steps/step-decode $PWD/MHO/dnntrain/$hmm/${file}_1H_CS${CS} dnn3.finetune MHO/decode-dnn3.finetune/$hmm/${file}_1H_CS${CS}
	grep -A2 -P 'SENT' MHO/decode-dnn3.finetune/$hmm/${file}_1H_CS${CS}/test/LOG >> dnntest.txt
done
done
done

###################################################################
#CI -Varying Structure
###################################################################
#done
for H in 3 7
do
for file in MFC_E_D_A_Z_Init20 FBK_D_A_Z_Init20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_${H}H_CS4
done
done

#done
for N in 400 650
do
for file in MFC_E_D_A_Z_Init20 FBK_D_A_Z_Init20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain5HCS4N${N}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_5H_CS4_N${N}

pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain7HCS4N${N}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_7H_CS4_N${N}
done
done

#Done
#test
for i in 5 7
do
H=$i
dnnft=$(expr $i + 2)
for N in 400 650
do
for hmm in  hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 
	do	
	echo $hmm ${file} -CS 4 -H $H -N $N >> dnntrain.txt
	grep -A7 -P 'Epoch 12' MHO/dnntrain/$hmm/${file}_${H}H_CS4_N${N}/dnn${dnnft}.finetune/LOG >> dnntrain.txt
	echo $hmm $file -CS 4 -H $H -N 500 >> dnntest.txt
	echo $hmm $file -H $H -N $N 
	../tools/steps/step-decode $PWD/MHO/dnntrain/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}
	grep -A2 -P 'SENT' MHO/decode-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}/test/LOG >> dnntest.txt

done
done
done
done

#DONE
for i in 3 7
do
H=$i
dnnft=$(expr $i + 2)
for hmm in  hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20
	do	
	echo $hmm ${file} -CS 4 -H $H -N 500 >> dnntrain.txt
	grep -A7 -P 'Epoch 12' MHO/dnntrain/$hmm/${file}_1H_CS${CS}/dnn${dnnft}.finetune/LOG >> dnntrain.txt
	echo $hmm $file -CS 4 -H $H -N 500 >> dnntest.txt
	echo $hmm $file
	../tools/steps/step-decode $PWD/MHO/dnntrain/$hmm/${file}_${H}H_CS4 dnn${dnnft}.finetune MHO/decode-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4
	grep -A2 -P 'SENT' MHO/decode-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4/test/LOG >> dnntest.txt
done
done
done
done

###################################################################
#CD TRI -Varying Structure
###################################################################
#Done
#Step Align
cd ~/MLSALT2/pracgmm/exp

for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/xwtri/RO100/TB4000 hmm84 \ $file/align-tri-hmm84
done


for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/xwtri/RO100/TB4000 hmm164 \ $file/align-tri-hmm164
done

#Dnn Train
#Done
for N in 400 650
do
for H in 5 7
do
for file in MFC_E_D_A_Z_Init20 FBK_D_A_Z_Init20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-tri-hmm84/align/timit_train.mlf $pracgmmexp/xwtri/RO100/TB4000/hmm84/MMF \ $pracgmmexp/xwtri/RO100/TB4000/hmms.mlist MHO/dnntraintri/hmm84/${file}_${H}H_CS4_N${N}

../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-tri-hmm164/align/timit_train.mlf $pracgmmexp/xwtri/RO100/TB4000/hmm164/MMF \ $pracgmmexp/xwtri/RO100/TB4000/hmms.mlist MHO/dnntraintri/hmm164/${file}_${H}H_CS4_N${N}

done
done
done

#Done
for N in 500
do
for H in 3 5 7
do
for file in MFC_E_D_A_Z_Init20 FBK_D_A_Z_Init20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-tri-hmm84/align/timit_train.mlf $pracgmmexp/xwtri/RO100/TB4000/hmm84/MMF \ $pracgmmexp/xwtri/RO100/TB4000/hmms.mlist MHO/dnntraintri/hmm84/${file}_${H}H_CS4_N${N}

../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-tri-hmm164/align/timit_train.mlf $pracgmmexp/xwtri/RO100/TB4000/hmm164/MMF \ $pracgmmexp/xwtri/RO100/TB4000/hmms.mlist MHO/dnntraintri/hmm164/${file}_${H}H_CS4_N${N}

done
done
done
done


#test
#Done
for i in 5 7
do
H=$i
dnnft=$(expr $i + 2)
for N in 400 650
do
for hmm in  hmm84
	do
	for file in   FBK_D_A_Z_Init20 #MFC_E_D_A_Z_Init20
	do	
	#echo $hmm ${file} -CS 9 -H $H -N $N >> dnntraintri.txt
	#grep -A7 -P 'Epoch 12' MHO/dnntraintri/$hmm/${file}_${H}H_CS4_N${N}/dnn${dnnft}.finetune/LOG >> dnntraintrics9.txt
	echo $hmm $file -CS 9 -H $H -N 500 >> dnntesttrics9.txt
	echo $hmm $file -H $H -N $N 
	../tools/steps/step-decode $PWD/MHO/dnntraintri/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-tri-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS9_N${N}
	grep -A2 -P 'SENT' MHO/decode-tri-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS9_N${N}/test/LOG >> dnntesttrics9.txt

done
done
done
done

#DONE
for N in 500
do
for i in 3 5 7
do
H=$i
dnnft=$(expr $i + 2)
for hmm in  hmm84
	do
	for file in   FBK_D_A_Z_Init20 #MFC_E_D_A_Z_Init20
	do	
	#echo $hmm ${file} -CS 9 -H $H -N 500 >> dnntraintri.txt
	#grep -A7 -P 'Epoch 12' MHO/dnntraintri/$hmm/${file}_${H}H_CS9_N${N}/dnn${dnnft}.finetune/LOG >> dnntraintrics9b.txt
	echo $hmm $file -CS 9 -H $H -N 500 >> dnntesttrics9b.txt
	echo $hmm $file
	../tools/steps/step-decode $PWD/MHO/dnntraintri/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-tri-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS9_N${N}
	grep -A2 -P 'SENT' MHO/decode-tri-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS9_N${N}/test/LOG >> dnntesttrics9b.txt
done
done
done
done
done



