from os import listdir
from os.path import isfile, join, isdir
import sys
from collections import defaultdict
import numpy as np


in_dataset  = sys.argv[1]
out_dataset = sys.argv[2]
graph_files = listdir(in_dataset)

for afile in graph_files:
    with open(join(in_dataset,afile),"r") as data:
        print("file being processed:", afile)
        lines = data.read().splitlines()
    
    with open(join(out_dataset,afile),"w") as data:
        mode = "init"
        for line in lines:
            if "}" in line:
                mode = "end"
            if mode == "edge":
                print("edge(",line.strip(";"),").",sep="",file=data)
            if mode == "label":
                print("label(",line.strip(";"),").",sep="",file=data)
            if "edge" in line:
                mode = "edge"
            if "label" in line:
                mode = "label"


        
