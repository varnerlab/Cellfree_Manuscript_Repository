# Do Sobol on initial conditions of enzymes, amino acids, glucose, and oxygen

# Import optimal initial conditions
init_cond = vec(abs(float(open(readdlm,"initial_condition.dat"))))

#	54	 id:M_glc_D_c	 symbol:M_glc_D_c
#	93	 id:M_o2_c	 symbol:M_o2_c
#	80	 id:M_ala_L_c	 symbol:M_ala_L_c
#	43	 id:M_arg_L_c	 symbol:M_arg_L_c
#	76	 id:M_asn_L_c	 symbol:M_asn_L_c
#	73	 id:M_asp_L_c	 symbol:M_asp_L_c
#	77	 id:M_cys_L_c	 symbol:M_cys_L_c
#	91	 id:M_gln_L_c	 symbol:M_gln_L_c
#	90	 id:M_glu_L_c	 symbol:M_glu_L_c
#	74	 id:M_gly_L_c	 symbol:M_gly_L_c
#	79	 id:M_his_L_c	 symbol:M_his_L_c
#	75	 id:M_ile_L_c	 symbol:M_ile_L_c
#	89	 id:M_leu_L_c	 symbol:M_leu_L_c
#	78	 id:M_lys_L_c	 symbol:M_lys_L_c
#	88	 id:M_met_L_c	 symbol:M_met_L_c
#	81	 id:M_phe_L_c	 symbol:M_phe_L_c
#	82	 id:M_pro_L_c	 symbol:M_pro_L_c
#	83	 id:M_ser_L_c	 symbol:M_ser_L_c
#	84	 id:M_thr_L_c	 symbol:M_thr_L_c
#	85	 id:M_trp_L_c	 symbol:M_trp_L_c
#	86	 id:M_tyr_L_c	 symbol:M_tyr_L_c
#	87	 id:M_val_L_c	 symbol:M_val_L_c

#	104	 id:E_R_PTS	 symbol:E_R_PTS
#	105	 id:E_R_glk_atp	 symbol:E_R_glk_atp
#           ...                 ...
#	265	 id:E_R_ump_ppi	 symbol:E_R_ump_ppi
#	266	 id:E_R_ump_pi	 symbol:E_R_ump_pi

# Array of initial conditions
#IC = init_cond[[54;93;80;43;76;73;77;91;90;74;79;75;89;78;88;81:87;104:266]]
IC = [init_cond[[54;93;80;43;76;73;77;91;90;74;79;75;89;78;88;81:87]];.5*ones(163)]

# Array with string elements "P1", "P2", etc.
P = AbstractString[]
i_range = 1:length(IC)
for i in i_range
    push!(P,"P$i")
end

# Array of parameter bounds
bounds = [P 0*IC 2*IC]

# Save array of parameter bounds
writedlm("param.txt",bounds)
