import os
import sys

dir = sys.argv[0]

cnt = 0

for file in os.listdir(dir):
    if file.endswith(".txt"):
        cnt+=1

print(cnt)
