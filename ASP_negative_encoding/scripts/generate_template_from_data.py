import re
import random

def extract_graph_id(graph_str):
  graph_id = re.search(r'graph\((?P<id>\w+)\)',graph_str).group('id')
  return graph_id

def filter_edges_with_id(data, graph_id):
  edges = [atom for atom in data if ("edge("+graph_id+",") in atom]
  return edges

def remove_id(atom_str):
  prefix, suffix = atom_str.split('(')
  elements = suffix.split(",")[1:] # remove id
  return prefix+"("+",".join(elements)

def transform_into_template(atoms):
  return "\n".join(["t_" + remove_id(atom) for atom in atoms])
  

def read_dataset():
  datasetname = "yoshida"
  with open(datasetname,"r") as datafile:
      data   = datafile.read().splitlines()
      graphs = [atom for atom in data if "graph(" in atom]
      selected = extract_graph_id(random.choice(graphs))
      template = transform_into_template(filter_edges_with_id(data,selected))
      print(template)


def main():
    read_dataset()

if __name__ == "__main__":
    main()
