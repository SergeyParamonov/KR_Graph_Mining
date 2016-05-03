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
            for time in times:
                pattern, sat, seconds = time.split(",")
                runtimes[(i,int(pattern))] += float(seconds)
    with open("averaged_median_run.csv","w") as output:
        print("avg_runtime_i_th_pattern",file=output)
        for pattern in range(1,51):
            time = np.median([runtimes[(run,pattern)] for run in range(10)])
            print(time,file=output)
    

if __name__ == "__main__":
    main()
