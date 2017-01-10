filenames = ['/bigrammono.txt']
expList = [];

for filename in filenames:
	indir = '/remote/mlsalt-2016/ct506/MLSALT2/pracgmm/pracblm/results'+ filename
	text = open(indir).read();
	exps = text.split('===================================================================\n')
	for exp in exps:
		if (len(exp)!=0):
			exp = exp.split()
			file=exp[0].split('_')
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
			expList.append(exp[1].split('-')[3])
			if (exp[3] == 'option'):
				expList.append('')
				expList.append('')
			elif(exp[2] == 'SENT:'):
				expList.append(exp[2])
				expList.append('')
			else:
				expList.append('TBVAL')
				expList.append(5000)
				expList.append('ROVAL')
				expList.append(100)
				expList.append('GRAMMARSCALE')
				expList.append(exp[4])
				expList.append('INSWORD')
				expList.append(exp[7])
				expList.append(exp[5])
			if(exp[3] == 'SENT:'):
				for result in exp[4:]:
					if (result!='WORD:'):
						expList.append(result.split('=')[1].replace(',','').replace('-','').replace('[','').replace(']',''))
			else:
				for result in exp[9:]:
					if (result!='WORD:'):
						expList.append(result.split('=')[1].replace(',','').replace('-','').replace('[','').replace(']',''))
			expList.append('\n')

import csv

with open('monophone-bigram-GMM.csv', 'wb') as myfile:
    wr = csv.writer(myfile, delimiter=',' ,quoting=csv.QUOTE_MINIMAL)
    wr.writerow(expList)