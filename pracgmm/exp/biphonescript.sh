
#Biphone generate with different TBVAL
../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwbil/RO100/TB4000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/MFC_E_D_A_Z_Init20/mono hmm14 MFC_E_D_A_Z_Init20/xwbil/RO100/TB4000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/FBK_D_A_Z_Flatstart20/mono hmm14 FBK_D_A_Z_Flatstart20/xwbil/RO100/TB4000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/FBK_D_A_Z_Init20/mono hmm14 FBK_D_A_Z_Init20/xwbil/RO100/TB4000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwbir/RO100/TB4000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/MFC_E_D_A_Z_Init20/mono hmm14 MFC_E_D_A_Z_Init20/xwbir/RO100/TB4000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/FBK_D_A_Z_Flatstart20/mono hmm14 FBK_D_A_Z_Flatstart20/xwbir/RO100/TB4000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/FBK_D_A_Z_Init20/mono hmm14 FBK_D_A_Z_Init20/xwbir/RO100/TB4000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwbil/RO100/TB2000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/MFC_E_D_A_Z_Init20/mono hmm14 MFC_E_D_A_Z_Init20/xwbil/RO100/TB2000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/FBK_D_A_Z_Flatstart20/mono hmm14 FBK_D_A_Z_Flatstart20/xwbil/RO100/TB2000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/FBK_D_A_Z_Init20/mono hmm14 FBK_D_A_Z_Init20/xwbil/RO100/TB2000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwbir/RO100/TB2000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/MFC_E_D_A_Z_Init20/mono hmm14 MFC_E_D_A_Z_Init20/xwbir/RO100/TB2000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/FBK_D_A_Z_Flatstart20/mono hmm14 FBK_D_A_Z_Flatstart20/xwbir/RO100/TB2000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/FBK_D_A_Z_Init20/mono hmm14 FBK_D_A_Z_Init20/xwbir/RO100/TB2000

#In Progress
#Decoding Biphones without options RIGHT 
cd MLSALT2/pracgmm/exp
for file in MFC_E_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
	do
	for tb in 4000 
	do
	for i in $(seq 2 2 20)
	do

	hmm=hmm${i}4
	filename=decode-xwbir-$hmm
	echo $file $filename $tb
	../tools/steps/step-decode -CORETEST $PWD/$file/xwbir/RO100/TB$tb $hmm $file/xwbir/RO100/TB$tb/CORETEST/$filename
	echo $file $filename $tb $100 CORETEST >>bir${tb}.txt
	grep -A2 -P 'SENT' $file/xwbir/RO100/TB$tb/CORETEST/$filename/test/LOG >>bir${tb}.txt
	
done
done
done

cd MLSALT2/pracgmm/exp
for file in MFC_E_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
	do
	for tb in 2000 
	do
	for i in $(seq 2 2 20)
	do

	hmm=hmm${i}4
	filename=decode-xwbir-$hmm
	echo $file $filename $tb
	../tools/steps/step-decode -CORETEST $PWD/$file/xwbir/RO100/TB$tb $hmm $file/xwbir/RO100/TB$tb/CORETEST/$filename
	echo $file $filename $tb $100 CORETEST >>bir${tb}.txt
	grep -A2 -P 'SENT' $file/xwbir/RO100/TB$tb/CORETEST/$filename/test/LOG >>bir${tb}.txt
	
done
done
done

#Done
#Decoding Biphones without options LEFT 
cd MLSALT2/pracgmm/exp
for file in MFC_E_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
	do
	for tb in 4000 
	do
	for i in $(seq 2 2 20)
	do

	hmm=hmm${i}4
	filename=decode-xwbil-$hmm
	echo $file $filename $tb
	../tools/steps/step-decode -CORETEST $PWD/$file/xwbil/RO100/TB$tb $hmm $file/xwbil/RO100/TB$tb/CORETEST/$filename
	echo $file $filename $tb $100 CORETEST >>bil${tb}.txt
	grep -A2 -P 'SENT' $file/xwbil/RO100/TB$tb/CORETEST/$filename/test/LOG >>bil${tb}.txt
	
done
done
done

cd MLSALT2/pracgmm/exp
for file in MFC_E_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
	do
	for tb in 2000 
	do
	for i in $(seq 2 2 20)
	do

	hmm=hmm${i}4
	filename=decode-xwbil-$hmm
	echo $file $filename $tb
	../tools/steps/step-decode -CORETEST $PWD/$file/xwbil/RO100/TB$tb $hmm $file/xwbil/RO100/TB$tb/CORETEST/$filename
	echo $file $filename $tb $100 CORETEST >>bil${tb}.txt
	grep -A2 -P 'SENT' $file/xwbil/RO100/TB$tb/CORETEST/$filename/test/LOG >>bil${tb}.txt
	
done
done
done

###################################################################
#CD BI DNN -Varying Structure
###################################################################
#Done
#Step Align
cd ~/MLSALT2/pracgmm/exp

for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/xwbir/RO100/TB4000 hmm84 \ $file/align-bir-hmm84
	../tools/steps/step-align $PWD/$file/xwbil/RO100/TB4000 hmm84 \ $file/align-bil-hmm84
done


for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/xwbir/RO100/TB4000 hmm164 \ $file/align-bir-hmm164
	../tools/steps/step-align $PWD/$file/xwbil/RO100/TB4000 hmm164 \ $file/align-bil-hmm164
done

#Dnn Train
#In progress

cd ~/MLSALT2/pracdnn/exp
for N in 650
do
for H in 5 7
do
for file in MFC_E_D_A_Z_Init20 
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-bir-hmm84/align/timit_train.mlf $pracgmmexp/xwbir/RO100/TB4000/hmm84/MMF \ $pracgmmexp/xwbir/RO100/TB4000/hmms.mlist MHO/dnntrainbir/hmm84/${file}_${H}H_CS4_N${N}

../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-bil-hmm84/align/timit_train.mlf $pracgmmexp/xwbil/RO100/TB4000/hmm84/MMF \ $pracgmmexp/xwbil/RO100/TB4000/hmms.mlist MHO/dnntrainbil/hmm84/${file}_${H}H_CS4_N${N}


../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-bir-hmm164/align/timit_train.mlf $pracgmmexp/xwbir/RO100/TB4000/hmm164/MMF \ $pracgmmexp/xwbir/RO100/TB4000/hmms.mlist MHO/dnntrainbir/hmm164/${file}_${H}H_CS4_N${N}

../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-bil-hmm164/align/timit_train.mlf $pracgmmexp/xwbil/RO100/TB4000/hmm164/MMF \ $pracgmmexp/xwbil/RO100/TB4000/hmms.mlist MHO/dnntrainbil/hmm164/${file}_${H}H_CS4_N${N}


done
done
done

cd ~/MLSALT2/pracdnn/exp
for N in 650
do
for H in 5 7
do
for file in  FBK_D_A_Z_Init20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-bir-hmm84/align/timit_train.mlf $pracgmmexp/xwbir/RO100/TB4000/hmm84/MMF \ $pracgmmexp/xwbir/RO100/TB4000/hmms.mlist MHO/dnntrainbir/hmm84/${file}_${H}H_CS4_N${N}

../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-bil-hmm84/align/timit_train.mlf $pracgmmexp/xwbil/RO100/TB4000/hmm84/MMF \ $pracgmmexp/xwbil/RO100/TB4000/hmms.mlist MHO/dnntrainbil/hmm84/${file}_${H}H_CS4_N${N}


../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-bir-hmm164/align/timit_train.mlf $pracgmmexp/xwbir/RO100/TB4000/hmm164/MMF \ $pracgmmexp/xwbir/RO100/TB4000/hmms.mlist MHO/dnntrainbir/hmm164/${file}_${H}H_CS4_N${N}

../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4N${N}  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-bil-hmm164/align/timit_train.mlf $pracgmmexp/xwbil/RO100/TB4000/hmm164/MMF \ $pracgmmexp/xwbil/RO100/TB4000/hmms.mlist MHO/dnntrainbil/hmm164/${file}_${H}H_CS4_N${N}


done
done
done

#Skipping
for N in 500
do
for H in  5 7
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
#IP 
for i in 5 7
do
H=$i
dnnft=$(expr $i + 2)
for N in 650
do
for hmm in  hmm164
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 
	do	
	#echo $hmm ${file} -CS 4 -H $H -N $N >> dnntrainbil.txt
	#grep -A7 -P 'Epoch 12' MHO/dnntrainbil/$hmm/${file}_${H}H_CS4_N${N}/dnn${dnnft}.finetune/LOG >> dnntrainbil.txt
	echo $hmm $file -CS 4 -H $H -N $N >> dnntestbil.txt
	echo $hmm $file -H $H -N $N 
	../tools/steps/step-decode $PWD/MHO/dnntrainbil/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-bil-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}
	grep -A2 -P 'SENT' MHO/decode-bil-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}/test/LOG >> dnntestbil.txt

done
done
done
done

#DONE
for i in 5 7
do
H=$i
dnnft=$(expr $i + 2)
for N in 400 650
do
for hmm in  hmm84 hmm164
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 
	do	
	echo $hmm ${file} -CS 4 -H $H -N $N >> dnntrainbir.txt
	grep -A7 -P 'Epoch 12' MHO/dnntrainbir/$hmm/${file}_${H}H_CS4_N${N}/dnn${dnnft}.finetune/LOG >> dnntrainbir.txt
	echo $hmm $file -CS 4 -H $H -N $N >> dnntestbir.txt
	echo $hmm $file -H $H -N $N 
	../tools/steps/step-decode $PWD/MHO/dnntrainbir/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-bir-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}
	grep -A2 -P 'SENT' MHO/decode-bir-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}/test/LOG >> dnntestbir.txt

done
done
done
done


#Skipping
for i in 3 5 7
do
H=$i
dnnft=$(expr $i + 2)
for hmm in  hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20
	do	
	echo $hmm ${file} -CS 4 -H $H -N 500 >> dnntraintri.txt
	grep -A7 -P 'Epoch 12' MHO/dnntraintri/$hmm/${file}_1H_CS${CS}/dnn${dnnft}.finetune/LOG >> dnntraintri.txt
	echo $hmm $file -CS 4 -H $H -N 500 >> dnntesttri.txt
	echo $hmm $file
	../tools/steps/step-decode $PWD/MHO/dnntraintri/$hmm/${file}_${H}H_CS4 dnn${dnnft}.finetune MHO/decode-tri-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4
	grep -A2 -P 'SENT' MHO/decode-tri-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4/test/LOG >> dnntesttri.txt
done
done
done
done

