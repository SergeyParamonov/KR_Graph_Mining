import sys
import re

model_filename = sys.argv[1]

def parse_answer(line):
  ids = re.findall(r'map\(\d+,(\d+)\)',line)
  return ids
  
def generate_nogood():
  pass


with open(model_filename,"r") as models:
    data = models.read()
    if "UNSATISFIABLE" in data:
        pass
    else:
        num_iso_models = re.search("Models\s+:\s(?P<num>\d+)",data).group("num")
        after   = data.index("Solving...")
        before  = data.index("SATISFIABLE")
        answers = data[after:before]
        answer_count = 0
        answer_map = {}
        for line in answers.splitlines():
          if "Solving" in line:
            continue
          if "Answer" in line:
            answer_count += 1
          else:
            answer_map[answer_count] = parse_answer(line)

print(answer_map)
