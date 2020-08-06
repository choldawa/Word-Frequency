import os
import sys
import re
import nltk
from nltk import word_tokenize, pos_tag, pos_tag_sents
#nltk.download('punkt')
import pandas as pd
import timeit

start = timeit.default_timer()

firstFile = int(float(sys.argv[1]))
lastFile = int(float(sys.argv[2]))

def is_valid_word(w):
    # our criteria to filter out non-words -- here we use a heuristic of must have a vowel and no numbers
    return 1 <= len(w) <= 12 and re.search(r"[aeiouy,.]", w) and not re.search(r"[0-9]", w)
def convertTuple(tup):
    # tup = (tup[0].lower(), tup[1])
    str =  '/'.join(tup)
    return str

for file in os.listdir("./data-news/")[firstFile:lastFile]:
    if file.endswith(".txt"):
        df = pd.read_csv("./data-news/{}".format(file), sep='\t', names = ['date', 'time', 'URLgeneral', 'URL', 'text'])
        date = df['date'][0]

        # df['text'] = df['text'].apply(lambda x: re.findall(r'([a-z]+)',str(x), re.IGNORECASE))
        # df['text'] = df['text'].apply(lambda x: list(filter(is_valid_word, x)))
        # df['text'] = df['text'].apply(lambda x: nltk.pos_tag(x))
        # df['text'] = df['text'].apply(lambda x: [convertTuple(t) for t in x])
        # df['text'] = df['text'].apply(lambda x:' '.join(x))
        #
        # df.to_csv('corpus-pos-output/{}out.txt'.format(date), header=None, index=None, sep = '\t')

        df['text'] = df['text'].apply(lambda x: re.findall(r"[a-z']+|[.,!?;]",str(x), re.IGNORECASE))
        df['text'] = df['text'].apply(lambda x: list(filter(is_valid_word, x)))
        df['text'] = df['text'].apply(lambda x:' '.join(x))

        texts = df['text'].tolist()
        tagged_texts = pos_tag_sents(map(word_tokenize, texts))
        df['text'] = tagged_texts

        # df['text'] = df['text'].apply(lambda x: nltk.pos_tag(x))
        df['text'] = df['text'].apply(lambda x: [convertTuple(t) for t in x])
        df['text'] = df['text'].apply(lambda x:' '.join(x))

        df.to_csv('corpus-pos-output/{}out.txt'.format(date), header=None, index=None, sep = '\t')
        # df.to_csv('./corpus-pos-output/{}out.txt'.format(date), header=None, index=None, sep = '\t')
stop = timeit.default_timer()
print('Total Time: ', stop - start, "||", lastFile)
