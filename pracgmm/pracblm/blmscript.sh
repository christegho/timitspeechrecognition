#!/bin/zsh


# Create a phone-level back-off bigram language model
# -t Set the threshold count for including a bigram in a backed-off bigram language model.
../tools/htkbin/HLStats -A -D -T 1 -b back_off_bigram -t 3 -u 1.0 -o phone-list.txt ../convert/mfc13d/lib/mlabs/train.mlf 

# Build a bigram network
../tools/htkbin/HBuild -A -D -T 1  -n back_off_bigram phone-list.txt bigram_network

#Decode triphone GMM 

for file in MFC_E_D_A_Z_Init20 FBK_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Flatstart20
	do
	for testOpt in CORETEST SUBTRAIN
	do
	for tb in 5000 
	do
	for i in 8 16
	do
	for grammarscale in  $(seq 0 1 13)
        do
	for insword in 0 -4 -8
	do
	hmm=hmm${i}4
	filename=decode-xwtri-bigram-$hmm
	echo $file $filename -TB $tb -GRAMMARSCALE ${grammarscale} -${testOpt} -INSWORD $insword
	../tools/steps/step-decode \
	-DECODEHTE /home/ct506/MLSALT2/pracgmm/pracblm/HTE.bigram \
	-${testOpt} -INSWORD $insword \
	-GRAMMARSCALE ${grammarscale} \
	/home/ct506/MLSALT2/pracgmm/exp/$file/xwtri/RO100/TB$tb $hmm $file/xwtri/RO100/TB$tb/GRAMMARSCALE${grammarscale}INS${insword}${testOpt}/$filename
	echo $file $filename -TB $tb -GRAMMARSCALE ${grammarscale} -${testOpt} -INSWORD $insword >>bigramtri${tb}.txt
	grep -A2 -P 'SENT' $file/xwtri/RO100/TB$tb/GRAMMARSCALE${grammarscale}INS${insword}${testOpt}/$filename/test/LOG >>bigramtri${tb}.txt
	
done
done
done
done
done
done

#MONO - GMM
#Done
for file in MFC_E_D_A_Z_Init20 FBK_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Flatstart20
	do
	for testOpt in CORETEST SUBTRAIN
	do
	for i in 8 16
	do
	for grammarscale in  $(seq 0 1 13)
        do
	for insword in 0 -4 -8
	do
	hmm=hmm${i}4
	filename=decode-mono-bigram-$hmm
	echo $file $filename -TB $tb -GRAMMARSCALE ${grammarscale} -${testOpt} -INSWORD $insword
	../tools/steps/step-decode \
	-DECODEHTE /home/ct506/MLSALT2/pracgmm/pracblm/HTE.bigram \
	-${testOpt} -INSWORD $insword \
	-GRAMMARSCALE ${grammarscale} \
	/home/ct506/MLSALT2/pracgmm/exp/$file/mono $hmm $file/mono/GRAMMARSCALE${grammarscale}INS${insword}${testOpt}/$filename
	echo $file $filename -TB $tb -GRAMMARSCALE ${grammarscale} -${testOpt} -INSWORD $insword >>bigrammono.txt
	grep -A2 -P 'SENT' $file/mono/GRAMMARSCALE${grammarscale}INS${insword}${testOpt}/$filename/test/LOG >>bigrammono.txt
	
done
done
done
done

#Decode triphone DNNs
#TODO
for i in 5 7
do
H=$i
dnnft=$(expr $i + 2)
for N in 400 650
do
for hmm in  hmm84
	do
	for grammarscale in  $(seq 0 1 13)
        do
	for insword in  -4 -8
	do
	for file in   FBK_D_A_Z_Init20 #MFC_E_D_A_Z_Init20
	do	
	echo $hmm ${file} -CS 4 -H $H -N $N -CORETEST -INSWORD ${insword} -GRAMMARSCALE ${grammarscale}>> dnntesttriphonebigram2.txt
	echo $hmm ${file} -CS 4 -H $H -N $N -CORETEST -INSWORD ${insword} -GRAMMARSCALE ${grammarscale}
	../tools/steps/step-decode \
	-DECODEHTE /home/ct506/MLSALT2/pracgmm/pracblm/HTE.bigram \
	-CORETEST -INSWORD $insword \
	-GRAMMARSCALE ${grammarscale} \
	$PWD/MHO/dnntraintri/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-tri-bigram-GS${grammarscale}-INS${insword}-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}
	grep -A2 -P 'SENT' MHO/decode-tri-bigram-GS${grammarscale}-INS${insword}-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}/test/LOG >> dnntesttriphonebigram2.txt

done
done
done
done
done
done

for i in 5 7
do
H=$i
dnnft=$(expr $i + 2)
for N in 400 650
do
for hmm in  hmm84
	do
	for grammarscale in  $(seq 0 1 13)
        do
	for insword in -4 -8
	do
	for file in   FBK_D_A_Z_Init20 #MFC_E_D_A_Z_Init20
	do	
	echo $hmm ${file} -CS 4 -H $H -N $N -SUBTRAIN -INSWORD ${insword} -GRAMMARSCALE ${grammarscale}>> dnntraintriphonebigram2.txt
	echo $hmm ${file} -CS 4 -H $H -N $N -SUBTRAIN -INSWORD ${insword} -GRAMMARSCALE ${grammarscale}
	../tools/steps/step-decode \
	-DECODEHTE /home/ct506/MLSALT2/pracgmm/pracblm/HTE.bigram \
	-CORETEST -INSWORD $insword \
	-GRAMMARSCALE ${grammarscale} \
	$PWD/MHO/dnntraintri/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-tri-bigram-GS${grammarscale}-INS${insword}-TRAIN-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}
	grep -A2 -P 'SENT' MHO/decode-tri-bigram-GS${grammarscale}-INS${insword}-TRAIN-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}/test/LOG >> dnntraintriphonebigram2.txt

done
done
done
done
done
done


#Decoding with SUBTRAIN
for i in 5 7
do
H=$i
dnnft=$(expr $i + 2)
for N in 400 650
do
for hmm in  hmm84
	do
	for grammarscale in  $(seq 0 1 13)
        do
	for insword in 0 -4 -8
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 
	do	
	echo $hmm ${file} -CS 4 -H $H -N $N -SUBTRAIN -INSWORD ${insword} -GRAMMARSCALE ${grammarscale}>> dnntraintriphonebigram.txt
	echo $hmm ${file} -CS 4 -H $H -N $N -SUBTRAIN -INSWORD ${insword} -GRAMMARSCALE ${grammarscale}
	../tools/steps/step-decode \
	-DECODEHTE /home/ct506/MLSALT2/pracgmm/pracblm/HTE.bigram \
	-SUBTRAIN -INSWORD $insword \
	-GRAMMARSCALE ${grammarscale} \
	$PWD/MHO/dnntraintri/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-tri-bigram-train-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}
	grep -A2 -P 'SENT' MHO/decode-tri-bigram-train-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}/test/LOG >> dnntraintriphonebigram.txt

done
done
done
done
done
done
done
