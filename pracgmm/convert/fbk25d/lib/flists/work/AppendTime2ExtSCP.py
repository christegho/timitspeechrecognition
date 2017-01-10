import os
import sys

inSCP = sys.argv[1]
outSCP = sys.argv[2]

file = open(inSCP)
lines = file.readlines()
file.close()

outlines = []
for eachline in lines:
	curline = eachline.replace(os.linesep, '')
	path = curline.split('=')[-1]
	os.system('HList -h -e 1 ' + path + ' > temp.out')
	file = open('temp.out')
	tlines = file.readlines()
	file.close()
	
	curnum = -1
	for eachtline in tlines:
		if eachtline.count('Num Samples:'):
			item = eachtline.split('Num Samples:')[-1].split('File Format:')[0]
			parts = item.split(' ')
			for eachpart in parts:
				if eachpart != '':
					curnum = int(eachpart)
	curline += "[%d,%d]" % (0, curnum - 1) + os.linesep
	outlines.append(curline)			

file = open(outSCP, 'w')
file.writelines(outlines)
file.close()

