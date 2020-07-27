## read in each file from directory
## read each line of files
## pass line into POS
## convert output (list of tuples) into df
## append lines then group (to get final count) OR check if line exists and add

import os
import sys

dir = sys.argv[0]

cnt = 0

for file in os.listdir(dir):
    if file.endswith(".txt"):
        cnt+=1

print(cnt)
