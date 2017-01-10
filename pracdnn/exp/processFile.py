filenames = ['/dnntraintriphonebigram2.txt']
expList = [];

for filename in filenames:
	indir = '/remote/mlsalt-2016/ct506/MLSALT2/pracdnn/exp'+ filename
	text = open(indir).read();
	exps = text.split('===================================================================\n')
	for exp in exps:
		if (len(exp)!=0):
			exp = exp.split()
			file=exp[1].split('_')
			expList.append(file[0])
			if (file[1] == 'E'):
				if (file[2] == 'Z'):
					expList.append('')
					expList.append('')
					expList.append('Z')
					expList.append(file[3])
				elif (file[3] == 'A'):
					expList.append('A')
					expList.append('D')
					expList.append('Z')
					expList.append(file[5])
				else:
					expList.append('')
					expList.append('D')
					expList.append('Z')
					expList.append(file[4])
			else:
				if (file[1] == 'Z'):
					expList.append('')
					expList.append('')
					expList.append('Z')
					expList.append(file[2])
				elif (file[2] == 'A'):
					expList.append('A')
					expList.append('D')
					expList.append('Z')
					expList.append(file[4])
				else:
					expList.append('')
					expList.append('D')
					expList.append('Z')
					expList.append(file[3])
			expList.append(exp[0])
			if (exp[3] == 'option'):
				expList.append('')
				expList.append('')
			elif(exp[2] == 'SENT:'):
				expList.append(exp[2])
				expList.append('')
			else:
				expList.append('CS')
				expList.append(exp[3])
				expList.append('N')
				expList.append(exp[7])
				expList.append('H')
				expList.append(exp[5])
				expList.append('SUBTRAIN')
				expList.append('INSWORD')
				expList.append(exp[10])
				expList.append('GRAMMARSCALE')
				expList.append(exp[12])
			if(exp[3] == 'SENT:'):
				for result in exp[4:]:
					if (result!='WORD:'):
						expList.append(result.split('=')[1].replace(',','').replace('-','').replace('[','').replace(']',''))
			else:
				for result in exp[14:]:
					if (result!='WORD:'):
						expList.append(result.split('=')[1].replace(',','').replace('-','').replace('[','').replace(']',''))
			expList.append('\n')

import csv

with open('triphones-bigram-SUBTRAIN-DNN.csv', 'wb') as myfile:
    wr = csv.writer(myfile, delimiter=',' ,quoting=csv.QUOTE_MINIMAL)
    wr.writerow(expList)
