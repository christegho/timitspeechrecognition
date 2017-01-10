
import os
import sys

inLIST = sys.argv[1]
outDICT = sys.argv[2]

file = open(inLIST)
inlines = file.readlines()
file.close()

outlines = []
for eachline in inlines:
	curphone = eachline.replace(os.linesep, '')
	curline = curphone + '\t\t' + curphone
	outlines.append(curline)

file = open(outDICT, 'w')
for eachline in outlines:
	file.write(eachline + os.linesep)
file.close()

