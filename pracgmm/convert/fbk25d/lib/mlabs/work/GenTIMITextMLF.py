
import os
import sys
import math
import os.path

inMLF = sys.argv[1]
inSCP = sys.argv[2]
inDUR = float(sys.argv[3])
outMLF = sys.argv[4]
outLST = sys.argv[5]

namedict = {}
timedict = {}
file = open(inSCP)
inlines = file.readlines()
file.close()

for eachline in inlines:
	eachline = eachline.replace(os.linesep, '')
	parts = eachline.split('=')
	value = parts[0].split('.')[0]
	key = parts[1].split(os.sep)[-1].split('.')[0]
	namedict[key] = value
	times = parts[1].split('[')[-1].split(']')[0].split(',')
	timedict[key] = [int(times[0]), int(times[1])]


file = open(inMLF)
inlines = file.readlines()
file.close()

phonedict = {}
phonelist = []
outlines = ['#!MLF!#']
index = 0
while index < len(inlines):
	if inlines[index].startswith('"'):
		oldlabname = inlines[index].split('"')[1]
		[filepath, fileext] = os.path.splitext(oldlabname)
		items = filepath.split(os.sep)
		key = items[-3].lower() + '_' + items[-2].lower() + '_' + items[-1].lower()
		value = namedict[key]
		newlabname = '"' + value + fileext + '"'
		outlines.append(newlabname)
		maxtime = int((timedict[key][1] + 1) * abs(inDUR))
		index += 1
		while not inlines[index].startswith('.'):
			inlines[index] = inlines[index].replace(os.linesep, '')
			items = inlines[index].split(' ')
			if not phonedict.has_key(items[2]):
				phonedict[items[2]] = 1
				phonelist.append(items[2])
			else:
				phonedict[items[2]] += 1	
			if inDUR > 0:
				starttime = int(int(float(items[0]) / inDUR + 0.5) * inDUR)
				endtime = int(int(float(items[1]) / inDUR + 0.5) * inDUR)
			else:
				starttime = int(items[0])
				endtime = int(items[1])
			if starttime > maxtime:
				print 'WARNING: ' + value
				starttime = maxtime
			if endtime > maxtime:
				endtime = maxtime
			inlines[index] = str(starttime) + ' ' + str(endtime) + ' ' + items[2]
			outlines.append(inlines[index])
			index += 1
		outlines.append('.')
	index += 1


file = open(outMLF, 'w')
for eachline in outlines:
	file.write(eachline + os.linesep)
file.close()

phonelist.sort()
file = open(outLST, 'w')
for eachphone in phonelist:
	file.write(eachphone + ' ' + str(phonedict[eachphone]) + os.linesep)
file.close()


