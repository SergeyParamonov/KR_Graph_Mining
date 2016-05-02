tmp=temporal_files
python3 scripts/set_threshold.py  5                           > $tmp/executable_program.asp
python3 scripts/generate_template_from_data.py                > $tmp/template
clingo $tmp/executable_program.asp yoshida $tmp/template      > $tmp/clingo_output
python3 scripts/parse_clingo_invar.py $tmp/clingo_output      > $tmp/current_solution
clingo iso_encoding.asp $tmp/current_solution $tmp/template 0 > $tmp/iso_models
python3 scripts/parse_iso_models.py $tmp/iso_models
