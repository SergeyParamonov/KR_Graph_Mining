set -x #echo on
# init the experiments execution
tmp=temporal_files
python3 scripts/set_threshold.py  5            > $tmp/executable_program.asp
python3 scripts/generate_template_from_data.py > $tmp/template
echo "0"                                       > $tmp/number_of_patterns
                                               > $tmp/runtime # clean the runtime log
# loop here to mine here k patterns
for ((i=0; i < 5; i++))
do
  clingo $tmp/executable_program.asp yoshida $tmp/template > $tmp/clingo_output
  cat $tmp/clingo_output
  python3 scripts/check_solution.py $tmp/clingo_output $tmp/executable_program.asp $tmp/flags $tmp/number_of_patterns $tmp/runtime
  if [[ "$(cat $tmp/flags)" -eq "UNSAT" ]]
    then
      continue
  fi
  cat $tmp/number_of_patterns
  python3 scripts/parse_clingo_invar.py $tmp/clingo_output > $tmp/current_solution
  cat $tmp/current_solution
  clingo iso_encoding.asp $tmp/current_solution $tmp/template 0 > $tmp/iso_models
  cat $tmp/iso_models
  python3 scripts/parse_iso_models.py $tmp/iso_models $tmp/executable_program.asp
done
