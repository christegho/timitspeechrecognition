# This script is used to generate an HCopy script according to
# the wave list
# /data/ldc/LDC93S1/TIMIT/TEST/DR1/FAKS0/SA1.WAV
#                 -> outDIR/DR1+FAKS0+SA1.outEXT
#		  -> outDIR/dr1_faks0_sa1.outExt

import os
import sys
import os.path

inSCP = sys.argv[1]
outDIR = sys.argv[2]
outEXT = sys.argv[3]
outSCP = sys.argv[4]

if not outEXT.startswith('.'):
	outEXT = '.' + outEXT
if not outDIR.endswith(os.sep):
	outDIR += os.sep

file = open(inSCP)
inlines = file.readlines()
file.close()

outlines = []
for eachline in inlines:
	srcwav = eachline.replace(os.linesep, '')
	items = os.path.splitext(srcwav)[0].split(os.sep)
	tgtname = items[-3].lower() + '_' + items[-2].lower() + '_' + items[-1].lower() + outEXT.lower()
	tgtpath = outDIR + tgtname
	outlines.append(srcwav + ' ' + tgtpath + os.linesep)

file = open(outSCP, 'w')
file.writelines(outlines)
file.close()

