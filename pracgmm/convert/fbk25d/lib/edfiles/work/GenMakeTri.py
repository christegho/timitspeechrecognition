import os
import sys

inLST = sys.argv[1]
outHED = sys.argv[2]

file = open(inLST)
lines = file.readlines()
file.close()

phonelist = []
for eachline in lines:
	curphone = eachline.replace(os.linesep, '')
	phonelist.append(curphone)

outlines = ['TC']
REcmd = 'RE sil'
for leftphone in phonelist:
	for rightphone in phonelist:
		curtrisil = leftphone + '-sil+' + rightphone
		outlines.append(REcmd + ' ' + curtrisil)

	
file = open(outHED, 'w')
for eachline in outlines:
	file.write(eachline + os.linesep)
file.close()

