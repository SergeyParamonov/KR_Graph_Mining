from os import listdir
from os.path import isfile, join, isdir
import sys
from collections import defaultdict
import numpy as np

def main():
    tmp_folder = sys.argv[1]
    folders    = [x for x in listdir(tmp_folder) if isdir(join(tmp_folder,x))]
    runtimes = defaultdict(float)
    for i, folder in enumerate(folders):
        with open(join(tmp_folder,folder,"runtime"),"r") as runtime:
            times = runtime.read().splitlines()
            for index, time in enumerate(times):
                runtimes[(i,index)] += float(time)
    with open("averaged_runtime_decomposed.csv","w") as output:
        print("pattern_index,runtime,model",file=output)
        for pattern in range(50):
            time = np.median([runtimes[(run,pattern)] for run in range(10)])
            print(pattern+1,time,"decomposed",sep=",",file=output)
    

if __name__ == "__main__":
    main()
