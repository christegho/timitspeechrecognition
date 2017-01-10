
import os
import sys

boundary = {'sil': 0}
phoneme = []

inLST = sys.argv[1]
outLST = sys.argv[2]

file = open(inLST)
lines = file.readlines()
file.close()

for eachline in lines:
	curphone = eachline.replace(os.linesep, '')
	if phoneme.count(curphone) == 0:
		phoneme.append(curphone)
phoneme.sort()

left = []
left.extend(phoneme)

right = []
right.extend(phoneme)

center = []
for eachphone in phoneme:
	if not boundary.has_key(eachphone):
		center.append(eachphone)

triphones = []
# for each center phone
for eachcp in center:
	for eachlp in left:
		for eachrp in right:
			triphones.append(eachlp + '-' + eachcp + '+' + eachrp)

# add the boundaries
for eachbp in boundary.items():
	triphones.append(eachbp[0])

file = open(outLST, 'w')
for eachtp in triphones:
	file.write(eachtp + os.linesep)
file.close()

