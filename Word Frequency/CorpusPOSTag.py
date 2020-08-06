## read in each file from directory
## read each line of files
## pass line into POS
## convert output (list of tuples) into df
## append lines then group (to get final count) OR check if line exists and add
import os
import sys
import re
import nltk
#nltk.download('punkt')
import pandas as pd
import timeit

def is_valid_word(w):
    # our criteria to filter out non-words -- here we use a heuristic of must have a vowel and no numbers
    return 1 <= len(w) <= 12 and re.search(r"[aeiouy]", w) and not re.search(r"[0-9]", w)

def convertTuple(tup):
    str =  '/'.join(tup)
    return str

firstFile = int(float(sys.argv[1]))
lastFile = int(float(sys.argv[2]))

cnt = 0

start = timeit.default_timer()
for file in os.listdir("./data-news/")[firstFile:lastFile]:
    if file.endswith(".txt"):
        finalOutput = []
        with open("./data-news/{}".format(file), 'r') as f:
            for line in f:
                date = file.split('.')[0]

                data = re.findall(r'([a-z]+)', line, re.IGNORECASE)
                #check for valid words
                tokens = list(filter(is_valid_word, data))
                tokens = [x.lower() for x in tokens]
                #use NLTK pos tagger
                tagged = nltk.pos_tag(tokens)
                out = [convertTuple(t) for t in tagged]
                out = ' '.join(out)
                finalOutput.append(out)
    #             #Write to df
    #             df = pd.DataFrame(tagged, columns =['word', 'POS'])
    #             df['count'] = 1
    #             #group by word and POS
    #             out = df.groupby(['word','POS'])['count'].count().reset_index()
    #             out['date'] = date
    #             #save as output txt
    #             out.to_csv('pos-output/{}out.txt'.format(date), header=None, index=None)

        cnt+=1
        with open('./corpus-pos-output2/{}out.txt'.format(date), mode='wt', encoding='utf-8') as myfile:
            myfile.write('\n'.join(finalOutput))

stop = timeit.default_timer()
print('Total Time: ', stop - start, "|| end file:", lastFile)
