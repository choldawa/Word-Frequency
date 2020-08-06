## read in each file from directory
## read each line of files
## pass line into POS
## convert output (list of tuples) into df
## append lines then group (to get final count) OR check if line exists and add
import os
import sys
import re

def is_valid_word(w):
    # our criteria to filter out non-words -- here we use a heuristic of must have a vowel and no numbers
    return 1 <= len(w) <= 12 and re.search(r"[aeiouy]", w) and not re.search(r"[0-9]", w)

#     sentence = "the scared cat ran across the road e2 cmd"
# tokens = nltk.word_tokenize(sentence)
# print("all:",tokens)
# tokens = list(filter(is_valid_word, tokens))
# print("valid:", tokens)
# tagged = nltk.pos_tag(tokens)
# tagged
# df = pd.DataFrame.from_records(data, columns =['Team', 'Age', 'Score'])


cnt = 0

for file in os.listdir("./data-news/"):
    if file.endswith(".txt"):
        cnt+=1

print(cnt)
