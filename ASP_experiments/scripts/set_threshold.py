import numpy as np
import sys

def main():
  keyword = "TO_REPLACE_WITH_VALUE"
  dataset = "yoshida"
  replace(keyword,dataset)

def compute_absolute_threshold(dataset):
  percent  = int(sys.argv[1])/100.0
  graphs   = [x for x in dataset if "graph(" in x]
  graphs_num = len(graphs) 
  threshold  = int(np.ceil(percent*graphs_num))
  return str(threshold)

def replace(keyword,dataset):
  with open("basic.asp", "r") as programfile, open(dataset,"r") as datafile:
    data        = datafile.read().splitlines()
    program     = programfile.read()
    threshold   = compute_absolute_threshold(data)
    new_program = program.replace(keyword,threshold)
    print(new_program)

    


if __name__ == "__main__":
    main()
