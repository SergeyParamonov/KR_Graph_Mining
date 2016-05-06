PROBCLI=probcli

test:
	time probcli -animate 10 -animate-stats GraphMiner_loop.mch

z3tests_ok:
	probcli -evalt ':z3 g={1|->2} & f={TRUE|->FALSE} & i:(1..2)>->>BOOL & !(x,y).((x,y):g => (i(x),i(y)):f)'
z3tests_fail:
	probcli -evalt ':z3 g={1|->2} & f={11|->12} & i:(1..2)>->>(11..12) & !(x,y).((x,y):g => (i(x),i(y)):f)'