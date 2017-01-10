
import os
import sys

inLST = sys.argv[1]
outNET = sys.argv[2]

file = open(inLST)
inlines = file.readlines()
file.close()

defstr = '$phone = '
for eachline in inlines:
	curphone = eachline.replace(os.linesep, '')
	defstr += curphone + ' | '
defstr += ';'
defstr = defstr.replace(' | ;', ';')

cmdstr = '( sil <$phone> sil )'

file = open(outNET, 'w')
file.write(defstr + os.linesep)
file.write(cmdstr + os.linesep)
file.close()

