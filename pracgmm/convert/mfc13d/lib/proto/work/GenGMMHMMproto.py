
import os
import sys

inDIM = int(sys.argv[1])
inFEA = sys.argv[2]
inNSTATE = int(sys.argv[3])
outPROTO = sys.argv[4]

def GetIdentStr(dim, val):
	retval = ""
	for idx in range(0, dim):
		retval += " %e" % val
	return retval


outlines = []

# headline
outlines.append("~o <VECSIZE> %d <%s>" % (inDIM, inFEA))

# HMM macro
outlines.append('~h "proto"')

# <BEGINHMM>
outlines.append('<BEGINHMM>')

# <NUMSTATES>
outlines.append("<NUMSTATES> %d" % inNSTATE)

# for each state
index = 2
while index < inNSTATE:
	# <STATE>
	outlines.append("<STATE> %d" % index)
	# <MEAN>
	outlines.append("<MEAN> %d" % inDIM)
	outlines.append(GetIdentStr(inDIM, 0.0))
	# <VARIANCE>
	outlines.append("<VARIANCE> %d" % inDIM)
	outlines.append(GetIdentStr(inDIM, 1.0))
	index += 1

# <TRANSP>
outlines.append("<TRANSP> %d" % inNSTATE)
for ridx in range(0, inNSTATE):
	transline = ""
	for cidx in range(0, inNSTATE):
		if ridx == 0:
			if cidx == 1:
				transline += " %e" % 1.0
			else:
				transline += " %e" % 0.0
		elif ridx == inNSTATE - 1:
			transline += " %e" % 0.0
		else:
			if cidx == ridx:
				transline += " %e" % 0.6
			elif cidx == ridx + 1:
				transline += " %e" % 0.4
			else:
				transline += " %e" % 0.0
	outlines.append(transline)

# <ENDHMM>
outlines.append('<ENDHMM>')

file = open(outPROTO, 'w')
for eachline in outlines:
	file.write(eachline + os.linesep)
file.close()


