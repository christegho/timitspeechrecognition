
import os
import sys
import os.path

inSCP = sys.argv[1]
outSCP = sys.argv[2]

def AppendStr(length, before, current, after):
	while len(current) < length:
		if before != '':
			current = before + current
		elif after != '':
			current = current + after
		else:
			return current
	return current

file = open(inSCP)
inlines = file.readlines()
file.close()

outlines = []
for eachline in inlines:
	eachline = eachline.replace(os.linesep, '')
	items = eachline.split('[')[-1].split(']')[0].split(',')
	starttime = int(items[0])
	endtime = int(items[1]) + 1
	filepath = eachline.split('[')[0]
	fileext = os.path.splitext(filepath)[-1]
	filename = os.path.splitext(filepath)[0].split(os.sep)[-1]
	# generate the logic name
	logname = filename + '_' + AppendStr(3, '0', str(starttime), '') + '_' + AppendStr(3, '0', str(endtime), '')
	# generate the extended line
	extpath = logname + fileext + '=' + eachline
	outlines.append(extpath + os.linesep)

file = open(outSCP, 'w')
file.writelines(outlines)
file.close()

