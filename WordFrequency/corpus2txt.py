import os, sys, re
from datetime import datetime
from collections import defaultdict

N = 2 # the N of the n-gram

DIR = "corpus/data-news"
start_date = datetime.strptime('2015-11-26', "%Y-%m-%d")

def is_valid_word(w):
    # our criteria to filter out non-words -- here we use a heuristic of must have a vowel and no numbers
    return 1 <= len(w) <= 12 and re.search(r"[aeiouy]", w) and not re.search(r"[0-9]", w)

print("day word freq z")
for pth in os.listdir(DIR):

	freq = defaultdict(int) # just for this file (which should be a single date), the frequencies of each word


	m = re.match('([0-9]{4}-[0-9]{2}-[0-9]{2}).txt', pth)  #match the date format (to ensure we only process corpus files)
	if m:
		dt = m.groups(None)[0]
		day = (datetime.strptime(dt, "%Y-%m-%d") - start_date).days

		with open(DIR+"/"+pth, 'r') as f:
			for l in f: # split each line
				date, time, site, url, txt = re.split(r'\t', l)
				assert date == dt, "Date in filename does not match column! Something went wrong"
				txt = re.sub(r'\\n', r'\n', txt) # fix the newline encoding!
				txt = txt.lower() # collapse case
				#print txt
				words = re.findall(r'([a-z]+)', txt)

				words = filter(is_valid_word, words)
				#print words

				# loop through words to count up frequencies on this day
				for i in xrange(len(words)-N+1):
					chunk = words[i:(i+N)]
					#print chunk
					freq[' '.join(chunk)] += 1

		# normalize within days
		z = sum(freq.values())

		for k in sorted(freq.keys()):
			print(day,  "\"%s\""%k, freq[k], z)
