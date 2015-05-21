"""
86 character implementation of Dollar Words solver, that is - given a dictionary of words (one on each line) [program assumes 'w' as filename]
will print to a file all the words whose sum of character-positions within the English alphabet add up to 100 (a=1, b=2, c=3)
"""
for w in open("w"):sum(ord(x.lower())-96 for x in w[:-1])-100 or open(*'da').write(w)
