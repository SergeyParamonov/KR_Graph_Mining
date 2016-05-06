import sys
import re

model_filename = sys.argv[1]
program_filename = sys.argv[2]

def parse_answer(line):
  ids = re.findall(r'map\(\d+,(\d+)\)',line)
  return ids
  
def generate_nogood():
  pass


unsat = False
with open(model_filename,"r") as models:
    data = models.read()
    if "UNSATISFIABLE" in data:
        unsat = True
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

if not unsat:
    rules = []
    for iso_model in answer_map.values():
        rule  = " :- "
        rule += ",".join(["invar({})".format(node) for node in iso_model])
        rule += "."
        rules.append(rule)
    with open(program_filename,"r") as program_file:
        program = program_file.read()
        begin_key = "% NOGOODS_BEGIN"
        begin = program.index(begin_key) + len(begin_key)
        end   = program.index("% NOGOODS_END")
        new_program = program[:begin]  +"\n" + program[begin:end] +"\n"+ "\n".join(rules) +"\n" + program[end:]
    with open(program_filename,"w") as program_file:
        print(new_program,file=program_file)

    




