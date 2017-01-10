indir = '/remote/mlsalt-2016/ct506/MLSALT2/pracgmm/convert/mfc13d/lib/mlists/mono+sil.mlist' 

text = open(indir).read()

phones = text.split()
biphones_left = []
biphones_right = []
sil_right = []
sil_left = []
for phone1 in phones:
	for phone2 in phones:
		biphones_left.append(phone2+'-'+phone1)
		biphones_right.append(phone1+'+'+phone2)
for phone1 in phones:
	sil_right.append('RE sil sil+'+phone1)
	sil_left.append('RE sil '+phone1+'-sil')

with open('make-xwbir.led', 'wb') as brfile:
	brfile.write("\n".join(sil_right))

with open('make-xwbil.led', 'wb') as blfile:
	blfile.write("\n".join(sil_left))

with open('xwbileft+sil.mlist', 'wb') as blfile:
	blfile.write("\n".join(biphones_left))

with open('xwbiright+sil.mlist', 'wb') as rlfile:
	rlfile.write("\n".join(biphones_right))

