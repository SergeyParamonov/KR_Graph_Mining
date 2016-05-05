import re
import sys

output         = open(sys.argv[1],"r").read()
program_filename = sys.argv[2]
with open(program_filename,"r") as programfile:
  program = programfile.read()
flags_filename = sys.argv[3]
runtime_filename = sys.argv[5]

sat = True

pattern_filename = sys.argv[4]
with open(pattern_filename, "r") as pattern_file:
  number_of_patterns = int(pattern_file.read())

runtime = re.search("CPU Time\s+:\s+(?P<num>\d+.\d+)s",output).group("num")

if "UNSATISFIABLE" in output:
  sat = False
  current_len = re.search(r'good_model :- pattern_len\((?P<num>\d+)\).',program).group("num")
  old = "good_model :- pattern_len({}).".format(current_len)
  new = "good_model :- pattern_len({}).".format(int(current_len)+1)
  new_program = program.replace(old, new)
  begin_key = "% NOGOODS_BEGIN"
  begin = program.index(begin_key) + len(begin_key)
  end   = program.index("% NOGOODS_END")
  new_program = new_program[:begin] + "\n\n" + new_program[end:]
  with open(program_filename,"w") as programfile:
    print(new_program,file=programfile)
  with open(flags_filename,"w") as flag:
    print("UNSAT",file=flag)
else:
    with open(pattern_filename, "w") as pattern_file:
      print(number_of_patterns+1, file=pattern_file)
    with open(flags_filename,"w") as flag:
      print("SAT",file=flag)

with open(runtime_filename, "a") as runtimefile:
  time_for_pattern = number_of_patterns+1
  if sat:
    str_sat = "SAT"
  else:
    str_sat = "UNSAT"
  print("{pattern_num},{SAT},{time}".format(pattern_num=time_for_pattern,time=runtime,SAT=str_sat),file=runtimefile)


