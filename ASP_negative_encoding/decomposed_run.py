import re
from os      import system, listdir
from os.path import join
from random  import randint
import numpy as np

def main():
  run_folder  = init_program_and_template()
  graph_files = get_graph_files() # loop should start here
  candidate   = get_candidate(run_folder)
  candidate_file = generate_candidate_file(run_folder,candidate)
  threshold_absolute = compute_treshold(graph_files, 5)
  satisfied = 0
  SAT = False
  solutions = []
  for graph_file in graph_files.values():
     result = check_matching(candidate_file, graph_file, run_folder)
     if result:
         satisfied += 1
     if satisfied > threshold_absolute:
         SAT = True
         break
  if SAT:
    solutions.append(candidate)
  
  set_iso_nogoods(candidate_file,run_folder)
  
  print("SAT:",SAT)

def generate_candidate_file(run_folder,candidate):
   candidate_content = " ".join(["invar({}).".format(x) for x in candidate])
   candidate_file = "{}/candidate_pattern".format(run_folder)
   system("echo \"{candidate}\" > {candidate_file}".format(candidate=candidate_content,candidate_file=candidate_file))
   return candidate_file

def compute_treshold(graph_files, percent):
    overall = len(graph_files)
    threshold = int(np.ceil(((percent * overall) / 100.0)))
    return threshold


def check_matching(candidate_file, graph_file, run_folder):
  outputfilename = "{}/matching_result".format(run_folder) 
  system("./clingo {candidate_file} {graph_file} > {outputfilename}".format(candidate_file=candidate_file,graph_file=graph_file,outputfilename=outputfilename))
  with open(outputfilename, "r") as result:
      if "UNSATISFIABLE" in result:
          return False
      else:
          return True

def set_iso_nogoods(candidate_file, run_folder):
  system(" sed 's/invar/solution/g' {candidate_file} > {tmp}/solution".format(tmp=run_folder,candidate_file=candidate_file))
  system("./clingo iso_encoding.asp {tmp}/solution {tmp}/template 0 > {tmp}/iso_models".format(tmp=run_folder,candidate_file=candidate_file))
  system("python3 scripts/parse_iso_models.py {tmp}/iso_models {tmp}/generate_candidate_pattern.asp".format(tmp=run_folder))
# system("cat {tmp}/iso_models".format(tmp=run_folder))
 
def get_graph_files():
  folder      = "asp_decomposed_yoshida"
  graph_files = listdir(folder)
  graphs      = {}
  for graph_file in graph_files:
    graphs[int(graph_file)] = join(folder,graph_file)
  return graphs

def remove_iso_increase_pattern_len(run_folder):


def get_candidate(run_folder):
   system("""
          tmp={run_folder}; 
          ./clingo $tmp/generate_candidate_pattern.asp $tmp/template > $tmp/candidate
          """.format(run_folder=run_folder)
         ) 
   with open("{}/candidate".format(run_folder), "r") as candidate_file:
     data = candidate_file.read()
   if "UNSATISFIABLE" in data:
     remove_iso_increase_pattern_len(run_folder)
     return get_candidate(run_folder)
   else:
     candidate = re.findall(r'invar\((\w+)\)',data)      
   return candidate



def init_program_and_template():
  run_folder = "temporal_files/{}".format(randint(1,50000))
  system("""tmp={run_folder}; 
              mkdir -p $tmp; 
              cp generate_candidate_pattern.asp $tmp/generate_candidate_pattern.asp;
              python3 scripts/set_threshold.py 5 > $tmp/executable_program.asp;
              python3 scripts/generate_template_from_data.py > $tmp/template;
           """.format(run_folder=run_folder)
        )
  return run_folder


if __name__ == "__main__":
    main()
