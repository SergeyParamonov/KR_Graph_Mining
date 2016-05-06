import sys
import re

filename = sys.argv[1]
with open(filename,"r") as clingo_output:
    data = clingo_output.read()
    ids =  re.findall(r'invar\((\w+)\)',data)
    for t_node in ids:
      print("solution({}).".format(t_node), end=" ")
    print("")
 
