
import os
import sys

inSCP = sys.argv[1]
inLST = sys.argv[2]
outSCP = sys.argv[3]

speakerdict = {}
outlines = []

file = open(inLST)
lines = file.readlines()
file.close()

for eachline in lines:
	speakerdict[eachline.replace(os.linesep, '')] = []

file = open(inSCP)
lines = file.readlines()
file.close()

for eachline in lines:
	items = eachline.split('_')
	if speakerdict.has_key(items[1]):
		outlines.append(eachline)
		speakerdict[items[1]].append(eachline)

for eachspeaker in speakerdict.items():
	print eachspeaker[0] + ' ' + str(len(speakerdict[eachspeaker[0]]))

file = open(outSCP, 'w')
file.writelines(outlines)
file.close()		



