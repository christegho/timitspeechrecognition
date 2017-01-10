
import os
import sys

inLST = sys.argv[1]
outHED = sys.argv[2]

file = open(inLST)
lines = file.readlines()
file.close()

outlines = []
for eachline in lines:
	curphone = eachline.replace(os.linesep, '')
	command = "TI \"%s_t\" {(\"%s\").transP}" % (curphone, curphone)
	outlines.append(command)

file = open(outHED, 'w')
for eachline in outlines:
	file.write(eachline + os.linesep)
file.close()

