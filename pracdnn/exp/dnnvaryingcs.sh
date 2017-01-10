###################################################################
#CI - single layer varying context shift 
###################################################################
#Done
for file in FBK_Z_Init20 FBK_Z_Flatstart20 FBK_D_Z_Init20 FBK_D_Z_Flatstart20 MFC_E_Z_Init20 MFC_E_D_Z_Init20  MFC_E_D_Z_Flatstart20 MFC_E_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/mono hmm84 \ $file/align-mono-hmm84
done


for file in FBK_Z_Init20 FBK_Z_Flatstart20 FBK_D_Z_Init20 FBK_D_Z_Flatstart20 MFC_E_Z_Init20 MFC_E_D_Z_Init20  MFC_E_D_Z_Flatstart20 MFC_E_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/mono hmm164 \ $file/align-mono-hmm164
done

#In progress
for CS in 3 4 5 6
do
for file in MFC_E_D_A_Z_Init20   MFC_E_D_A_Z_Flatstart20 MFC_E_Z_Init20 MFC_E_D_Z_Init20  MFC_E_D_Z_Flatstart20 MFC_E_Z_Flatstart20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain1HCS${CS}  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_1H_CS${CS}

../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain1HCS${CS} ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm164/align/timit_train.mlf $pracgmmexp/mono/hmm164/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm164/${file}_1H_CS${CS}
done
done

#In progress
for CS in 3 4 5 6
do
for file in FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 FBK_Z_Init20 FBK_Z_Flatstart20 FBK_D_Z_Init20 FBK_D_Z_Flatstart20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain1HCS${CS}  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_1H_CS${CS}
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain1HCS${CS}  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-mono-hmm164/align/timit_train.mlf $pracgmmexp/mono/hmm164/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm164/${file}_1H_CS${CS}
done
done

#Done
for H in 9 11
do
for file in MFC_E_D_A_Z_Init20  
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_${H}H_CS4

done
done

#Done
for H in 9 11
do
for file in  FBK_D_A_Z_Init20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain${H}HCS4  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_${H}H_CS4

done
done

#Done
for N in 900
do
for file in MFC_E_D_A_Z_Init20  
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain7HCS4N900  ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_7H_CS4_N900

done
done

#Done
for N in 900
do
for file in  FBK_D_A_Z_Init20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -DNNTRAINHTE ~/MLSALT2/pracdnn/exp/HTEdnntrain7HCS4N900  ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/${file}_7H_CS4_N900

done
done


#DECODE
#IP

for CS in 3 4 5 6
do
for hmm in hmm164 hmm84
	do
	for file in FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 FBK_Z_Init20 FBK_Z_Flatstart20 FBK_D_Z_Init20 FBK_D_Z_Flatstart20  MFC_E_D_A_Z_Init20   MFC_E_D_A_Z_Flatstart20 MFC_E_Z_Init20 MFC_E_D_Z_Init20  MFC_E_D_Z_Flatstart20 MFC_E_Z_Flatstart20
	do	
	echo $hmm $file -CS $CS -H 1 -N 500 >> dnntestCS.txt
	echo $hmm $file
	../tools/steps/step-decode $PWD/MHO/dnntrain/$hmm/${file}_1H_CS${CS} dnn3.finetune MHO/decode-dnn3.finetune/$hmm/${file}_1H_CS${CS}
	grep -A2 -P 'SENT' MHO/decode-dnn3.finetune/$hmm/${file}_1H_CS${CS}/test/LOG >> dnntestCS.txt
done
done
done

#DONE
for H in 9
do
for hmm in hmm84
	do
	for file in FBK_D_A_Z_Init20 MFC_E_D_A_Z_Init20 
	do	
	echo $hmm $file -CS 4 -H $H -N 500 >> dnntestHH.txt
	echo $hmm $file
	#../tools/steps/step-decode $PWD/MHO/dnntrain/$hmm/${file}_${H}H_CS4 dnn11.finetune MHO/decode-dnn11.finetune/$hmm/${file}_${H}H_CS4 
	grep -A2 -P 'SENT' MHO/decode-dnn11.finetune/$hmm/${file}_${H}H_CS4/test/LOG >> dnntestHH.txt
done
done
done

#DONE
for H in 5
do
for hmm in hmm164
	do
	for file in FBK_D_A_Z_Init20 MFC_E_D_A_Z_Init20 
	do	
	echo $hmm $file -CS 4 -H $H -N 500 >> dnntestHH.txt
	echo $hmm $file
	#../tools/steps/step-decode $PWD/MHO/dnntrain/$hmm/${file}_${H}H_CS4 dnn11.finetune MHO/decode-dnn11.finetune/$hmm/${file}_${H}H_CS4 
	grep -A2 -P 'SENT' MHO/decode-dnn7.finetune/$hmm/${file}/test/LOG >> dnntestHH.txt
done
done
done

for H in 11 
do
for hmm in hmm84
	do
	for file in  MFC_E_D_A_Z_Init20 
	do	
	echo $hmm $file -CS 4 -H $H -N 500 >> dnntestHHSUBTRAIN.txt
	echo $hmm $file
	#../tools/steps/step-decode -SUBTRAIN $PWD/MHO/dnntrain/$hmm/${file}_${H}H_CS4 dnn13.finetune MHO/decode-subtrain-dnn13.finetune/$hmm/${file}_${H}H_CS4 
	grep -A2 -P 'SENT' MHO/decode-subtrain-dnn13.finetune/$hmm/${file}_${H}H_CS4/test/LOG >> dnntestHHSUBTRAIN.txt
done
done
done


for H in 9
do
for hmm in hmm84
	do
	for file in  MFC_E_D_A_Z_Init20 
	do	
	echo $hmm $file -CS 4 -H $H -N 500 >> dnntestHHSUBTRAIN.txt
	echo $hmm $file
	../tools/steps/step-decode -SUBTRAIN $PWD/MHO/dnntrain/$hmm/${file}_${H}H_CS4 dnn11.finetune MHO/decode-subtrain-dnn11.finetune/$hmm/${file}_${H}H_CS4 
	grep -A2 -P 'SENT' MHO/decode-subtrain-dnn11.finetune/$hmm/${file}_${H}H_CS4/test/LOG >> dnntestHHSUBTRAIN.txt
done
done
done

for H in 7
do
for hmm in hmm84
	do
	for file in  MFC_E_D_A_Z_Init20 
	do	
	echo $hmm $file -CS 4 -H $H -N 500 >> dnntestHHSUBTRAIN.txt
	echo $hmm $file
	../tools/steps/step-decode -SUBTRAIN $PWD/MHO/dnntrain/$hmm/${file}_${H}H_CS4 dnn9.finetune MHO/decode-subtrain-dnn9.finetune/$hmm/${file}_${H}H_CS4 
	grep -A2 -P 'SENT' MHO/decode-subtrain-dnn9.finetune/$hmm/${file}_${H}H_CS4/test/LOG >> dnntestHHSUBTRAIN.txt
done
done
done


#Done
for N in 900 650 
do
for hmm in hmm84
	do
	for file in  MFC_E_D_A_Z_Init20 #FBK_D_A_Z_Init20
	do	
	echo $hmm $file -CS 4 -H 7 -N ${N} >> dnntestTRAINNN.txt
	echo $hmm $file
	../tools/steps/step-decode -SUBTRAIN $PWD/MHO/dnntrain/$hmm/${file}_7H_CS4_N${N} dnn9.finetune MHO/decode-dnn9-train.finetune/$hmm/${file}_7H_CS4_N${N}
	grep -A2 -P 'SENT' MHO/decode-dnn9-train.finetune/$hmm/${file}_7H_CS4_N${N}/test/LOG >> dnntestTRAINNN.txt
done
done
done

for N in 500
do
for hmm in hmm84
	do
	for file in  MFC_E_D_A_Z_Init20 #FBK_D_A_Z_Init20
	do	
	echo $hmm $file -CS 4 -H 7 -N 500 >> dnntestTRAINNN.txt
	echo $hmm $file
	../tools/steps/step-decode -SUBTRAIN $PWD/MHO/dnntrain/$hmm/${file}_7H_CS4 dnn9.finetune MHO/decode-dnn9-train.finetune/$hmm/${file}_7H_CS4
	grep -A2 -P 'SENT' MHO/decode-dnn9-train.finetune/$hmm/${file}_7H_CS4/test/LOG >> dnntestTRAINNN.txt
done
done
done
#Done
for N in 500
do
for hmm in hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 
	do	
	echo $hmm ${file} -CS 4 -H 7 -N $N >> cvvalues.txt
	grep -A7 -P 'Epoch 12' MHO/dnntrain/$hmm/${file}_7H_CS4/dnn9.finetune/LOG >> cvvalues.txt
done
done
done

#############################
#GMM
#############################
#Done
for option in INSWORD
  do 
    for file in MFC_E_D_A_Z_Init20 
    do
      for i in $(seq 2 2 20)
	do
        hmm=hmm${i}4
        filename=decode-mono-$hmm
       
          for optvalue in -32 -16 -8 -4 -2 0 2 4 6
          do
            ../tools/steps/step-decode -CORETEST -$option $optvalue $PWD/$file/mono $hmm $file/${option}${optvalue}/$filename
	    echo $file $filename -$option $optvalue
            echo $file $filename -$option $optvalue >>monoINSWORD.txt
            grep -A2 -P 'SENT' $file/${option}${optvalue}/$filename/test/LOG >>monoINSWORD.txt
          done
   
	done 
     done 
done




#Triphone generate with different TBVAL
cd MLSALT2/pracgmm/exp
for tbval in 100 500 1000 2000 3000 4000 5000 10000
do
for roval in 100 200 300 
do 
../tools/steps/step-xwtri -NUMMIXES 20 -ROVAL ${roval} -TBVAL ${tbval} \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwtri/RO${roval}/TB${tbval}

done
done

#Decode #TODO
for file in  MFC_E_D_A_Z_Flatstart20 
	do
	for tbval in 100 500 1000 2000 3000 4000 5000 10000
	do
	for roval in 100 200 300 
	do 
	for i in $(seq 2 2 20)
	do
        hmm=hmm${i}4
	filename=decode-xwtri-$hmm
	echo $file $filename $tb  
	../tools/steps/step-decode -CORETEST  $PWD/$file/xwtri/RO${roval}/TB${tbval} $hmm $file/xwtri/RO${roval}/TB${tbval}/$filename
	echo $file $filename RO ${roval} TB ${tbval}  >>triROTB.txt
	grep -A2 -P 'SENT' $file/xwtri/RO${roval}/TB${tbval}/$filename/test/LOG >>triROTB.txt
	
done
done
done
done


#Done
for file in  MFC_E_D_A_Z_Flatstart20 
	do
	for tb in 100 500 1000 2000 3000 4000 5000 10000
	do
	for ro in 100 200 300 
	do 
echo $file $filename RO ${ro} TB ${tb} >>statetying.txt
 tail -n 21  /home/ct506/MLSALT2/pracgmm/exp/${file}/xwtri/RO${ro}/TB${tb}/hmm10/LOG | head -n 1 >>statetying.txt
done
done
done
