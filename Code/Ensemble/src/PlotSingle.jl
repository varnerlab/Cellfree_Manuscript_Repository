using PyPlot
function PlotSingle(Tsim,X,data_dictionary)

experimental_data_dictionary = data_dictionary["EXPERIMENT_DATA_DICTIONARY"]

glc = experimental_data_dictionary["M_glc_D_c"].raw_measurement_array
pyr = experimental_data_dictionary["M_pyr_c"].raw_measurement_array
lac = experimental_data_dictionary["M_lac_D_c"].raw_measurement_array
ac = experimental_data_dictionary["M_ac_c"].raw_measurement_array
succ = experimental_data_dictionary["M_succ_c"].raw_measurement_array
mal = experimental_data_dictionary["M_mal_L_c"].raw_measurement_array
CAT = experimental_data_dictionary["CAT"].raw_measurement_array

atp = experimental_data_dictionary["M_atp_c"].raw_measurement_array
adp = experimental_data_dictionary["M_adp_c"].raw_measurement_array
amp = experimental_data_dictionary["M_amp_c"].raw_measurement_array
axp = atp+adp+amp
axp[:,1] = atp[:,1]
gtp = experimental_data_dictionary["M_gtp_c"].raw_measurement_array
gdp = experimental_data_dictionary["M_gdp_c"].raw_measurement_array
gmp = experimental_data_dictionary["M_gmp_c"].raw_measurement_array
gxp = gtp+gdp+gmp
gxp[:,1] = gtp[:,1]
ctp = experimental_data_dictionary["M_ctp_c"].raw_measurement_array
cdp = experimental_data_dictionary["M_cdp_c"].raw_measurement_array
cmp = experimental_data_dictionary["M_cmp_c"].raw_measurement_array
cxp = ctp+cdp+cmp
cxp[:,1] = ctp[:,1]
utp = experimental_data_dictionary["M_utp_c"].raw_measurement_array
udp = experimental_data_dictionary["M_udp_c"].raw_measurement_array
ump = experimental_data_dictionary["M_ump_c"].raw_measurement_array
uxp = utp+udp+ump
uxp[:,1] = utp[:,1]

xxp = axp+gxp+cxp+uxp
xxp[:,1] = axp[:,1]

ala = experimental_data_dictionary["M_ala_L_c"].raw_measurement_array
asp = experimental_data_dictionary["M_asp_L_c"].raw_measurement_array
cys = experimental_data_dictionary["M_cys_L_c"].raw_measurement_array
gln = experimental_data_dictionary["M_gln_L_c"].raw_measurement_array
gly = experimental_data_dictionary["M_gly_L_c"].raw_measurement_array
phe = experimental_data_dictionary["M_phe_L_c"].raw_measurement_array
ser = experimental_data_dictionary["M_ser_L_c"].raw_measurement_array
thr = experimental_data_dictionary["M_thr_L_c"].raw_measurement_array

asn	= experimental_data_dictionary["M_asn_L_c"].raw_measurement_array
his	= experimental_data_dictionary["M_his_L_c"].raw_measurement_array
ile	= experimental_data_dictionary["M_ile_L_c"].raw_measurement_array
leu	= experimental_data_dictionary["M_leu_L_c"].raw_measurement_array
lys	= experimental_data_dictionary["M_lys_L_c"].raw_measurement_array
met	= experimental_data_dictionary["M_met_L_c"].raw_measurement_array
pro	= experimental_data_dictionary["M_pro_L_c"].raw_measurement_array
trp = experimental_data_dictionary["M_trp_L_c"].raw_measurement_array
tyr	= experimental_data_dictionary["M_tyr_L_c"].raw_measurement_array
val	= experimental_data_dictionary["M_val_L_c"].raw_measurement_array

species = ["GLC" 54;"PYR" 56;"LAC" 58;"AC" 57;"SUCC" 72;"MAL" 59;"CAT" 92;"XXP" (60,61,62,63,64,65,66,67,68,69,70,71);"ATP" 60;"ADP" 61;"AMP" 62;"AXP" (60,61,62);"GTP" 63;"GDP" 64;"GMP" 65;"GXP" (63,64,65);"CTP" 69;"CDP" 70;"CMP" 71;"CXP" (69,70,71);"UTP" 66;"UDP" 67;"UMP" 68;"UXP" (66,67,68);"ALA" 80;"ARG" 43;"ASN" 76;"ASP" 73;"CYS" 77;"GLN" 91;"GLU" 90;"GLY" 74;"HIS" 79;"ILE" 75;"LEU" 89;"LYS" 78;"MET" 88;"PHE" 81;"PRO" 82;"SER" 83;"THR" 84;"TRP" 85;"TYR" 86;"VAL" 87]





figure("CarbonCI",figsize=(11,5))
figure("EnergyCI",figsize=(11,10))
figure("AminoCI",figsize=(14,10))

figure("CarbonCI")

subplot(2,4,1)
errorbar(glc[:,1],glc[:,2],glc[:,3],fmt="ro",color="k",linewidth=2,linewidth=2)
axis([0,3,0,40])
plt[:xticks]([0:1:3])
plt[:yticks]([0:10:40])
ylabel("Glucose (mM)")
xlabel("Time (h)")

subplot(2,4,3)
errorbar(pyr[:,1],pyr[:,2],pyr[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,15])
plt[:xticks]([0:1:3])
plt[:yticks]([0:5:15])
ylabel("Pyruvate (mM)")
xlabel("Time (h)")

subplot(2,4,4)
errorbar(lac[:,1],lac[:,2],lac[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,15])
plt[:xticks]([0:1:3])
plt[:yticks]([0:5:15])
ylabel("Lactate (mM)")
xlabel("Time (h)")

subplot(2,4,5)
errorbar(ac[:,1],ac[:,2],ac[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,50])
plt[:xticks]([0:1:3])
plt[:yticks]([0:10:50])
ylabel("Acetate (mM)")
xlabel("Time (h)")

subplot(2,4,6)
errorbar(succ[:,1],succ[:,2],succ[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("Succinate (mM)")
xlabel("Time (h)")

subplot(2,4,7)
errorbar(mal[:,1],mal[:,2],mal[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,8])
plt[:xticks]([0:1:3])
plt[:yticks]([0:2:8])
ylabel("Malate (mM)")
xlabel("Time (h)")

subplot(2,4,2)
errorbar(CAT[:,1],1000*CAT[:,2],1000*CAT[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,25])
plt[:xticks]([0:1:3])
plt[:yticks]([0:5:25])
ylabel("CAT (μM)")
xlabel("Time (h)")

subplot(2,4,8)
errorbar(xxp[:,1],xxp[:,2],xxp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,8])
plt[:xticks]([0:1:3])
plt[:yticks]([0:2:8])
ylabel("Energy Total (mM)")
xlabel("Time (h)")





figure("EnergyCI")

subplot(4,4,1)
errorbar(atp[:,1],atp[:,2],atp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,2])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.5:2])
ylabel("ATP (mM)")
xlabel("Time (h)")

subplot(4,4,5)
errorbar(adp[:,1],adp[:,2],adp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,.8])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.2:.8])
ylabel("ADP (mM)")
xlabel("Time (h)")

subplot(4,4,9)
errorbar(amp[:,1],amp[:,2],amp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,.5])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.1:.5])
ylabel("AMP (mM)")
xlabel("Time (h)")

subplot(4,4,13)
errorbar(axp[:,1],axp[:,2],axp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,2])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.5:2])
ylabel("Σ AXP (mM)")
xlabel("Time (h)")

subplot(4,4,2)
errorbar(gtp[:,1],gtp[:,2],gtp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,1.5])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.5:1.5])
ylabel("GTP (mM)")
xlabel("Time (h)")

subplot(4,4,6)
errorbar(gdp[:,1],gdp[:,2],gdp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,.8])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.2:.8])
ylabel("GDP (mM)")
xlabel("Time (h)")

subplot(4,4,10)
errorbar(gmp[:,1],gmp[:,2],gmp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,.4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.1:.4])
ylabel("GMP (mM)")
xlabel("Time (h)")

subplot(4,4,14)
errorbar(gxp[:,1],gxp[:,2],gxp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,2])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.5:2])
ylabel("Σ GXP (mM)")
xlabel("Time (h)")

subplot(4,4,3)
errorbar(ctp[:,1],ctp[:,2],ctp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,1])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.2:1])
ylabel("CTP (mM)")
xlabel("Time (h)")

subplot(4,4,7)
errorbar(cdp[:,1],cdp[:,2],cdp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,.8])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.2:.8])
ylabel("CDP (mM)")
xlabel("Time (h)")

subplot(4,4,11)
errorbar(cmp[:,1],cmp[:,2],cmp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,.8])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.2:.8])
ylabel("CMP (mM)")
xlabel("Time (h)")

subplot(4,4,15)
errorbar(cxp[:,1],cxp[:,2],cxp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,2])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.5:2])
ylabel("Σ CXP (mM)")
xlabel("Time (h)")

subplot(4,4,4)
errorbar(utp[:,1],utp[:,2],utp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,1])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.2:1])
ylabel("UTP (mM)")
xlabel("Time (h)")

subplot(4,4,8)
errorbar(udp[:,1],udp[:,2],udp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,.6])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.2:.6])
ylabel("UDP (mM)")
xlabel("Time (h)")

subplot(4,4,12)
errorbar(ump[:,1],ump[:,2],ump[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,.3])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.1:.3])
ylabel("UMP (mM)")
xlabel("Time (h)")

subplot(4,4,16)
errorbar(uxp[:,1],uxp[:,2],uxp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,1.5])
plt[:xticks]([0:1:3])
plt[:yticks]([0:.5:1.5])
ylabel("Σ UXP (mM)")
xlabel("Time (h)")





figure("AminoCI")

subplot(4,5,1)
errorbar(ala[:,1],ala[:,2],ala[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,8])
plt[:xticks]([0:1:3])
plt[:yticks]([0:2:8])
ylabel("ALA (mM)")
xlabel("Time (h)")

subplot(4,5,2)
axis([0,3,0,12])
plt[:xticks]([0:1:3])
plt[:yticks]([0:4:12])
ylabel("ARG (mM)")
xlabel("Time (h)")

subplot(4,5,3)
errorbar(asn[:,1],asn[:,2],asn[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("ASN (mM)")
xlabel("Time (h)")

subplot(4,5,4)
errorbar(asp[:,1],asp[:,2],asp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,3])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:3])
ylabel("ASP (mM)")
xlabel("Time (h)")

subplot(4,5,5)
errorbar(cys[:,1],cys[:,2],cys[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("CYS (mM)")
xlabel("Time (h)")

subplot(4,5,6)
errorbar(gln[:,1],gln[:,2],gln[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("GLN (mM)")
xlabel("Time (h)")

subplot(4,5,7)
axis([0,3,0,12])
plt[:xticks]([0:1:3])
plt[:yticks]([0:4:12])
ylabel("GLU (mM)")
xlabel("Time (h)")

subplot(4,5,8)
errorbar(gly[:,1],gly[:,2],gly[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("GLY (mM)")
xlabel("Time (h)")

subplot(4,5,9)
errorbar(his[:,1],his[:,2],his[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("HIS (mM)")
xlabel("Time (h)")

subplot(4,5,10)
errorbar(ile[:,1],ile[:,2],ile[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("ILE (mM)")
xlabel("Time (h)")

subplot(4,5,11)
errorbar(leu[:,1],leu[:,2],leu[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("LEU (mM)")
xlabel("Time (h)")

subplot(4,5,12)
errorbar(lys[:,1],lys[:,2],lys[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("LYS (mM)")
xlabel("Time (h)")

subplot(4,5,13)
errorbar(met[:,1],met[:,2],met[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("MET (mM)")
xlabel("Time (h)")

subplot(4,5,14)
errorbar(phe[:,1],phe[:,2],phe[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("PHE (mM)")
xlabel("Time (h)")

subplot(4,5,15)
errorbar(pro[:,1],pro[:,2],pro[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("PRO (mM)")
xlabel("Time (h)")

subplot(4,5,16)
errorbar(ser[:,1],ser[:,2],ser[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("SER (mM)")
xlabel("Time (h)")

subplot(4,5,17)
errorbar(thr[:,1],thr[:,2],thr[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("THR (mM)")
xlabel("Time (h)")

subplot(4,5,18)
errorbar(trp[:,1],trp[:,2],trp[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("TRP (mM)")
xlabel("Time (h)")

subplot(4,5,19)
errorbar(tyr[:,1],tyr[:,2],tyr[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,3])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:3])
ylabel("TYR (mM)")
xlabel("Time (h)")

subplot(4,5,20)
errorbar(val[:,1],val[:,2],val[:,3],fmt="ro",color="k",linewidth=2)
axis([0,3,0,4])
plt[:xticks]([0:1:3])
plt[:yticks]([0:1:4])
ylabel("VAL (mM)")
xlabel("Time (h)")





j_range = 1:size(species)[1]
for j in j_range
    str = species[j,1]
    index = species[j,2]
#    sim = readdlm("./Ensemble18000/data/$str")
#    
#    if str == "CAT"
#        sim *= 1000
#    end
#    
#    m = Float64[]
#    s = Float64[]
#    i_range = 1:size(sim)[1]
#    for i in i_range
#        push!(m,mean(sim[i,:]))
#        push!(s,std(sim[i,:]))
#    end
#    se = s/sqrt(length(s))
    
    amino_ = [1 5 9 13 2 6 10 14 3 7 11 15 4 8 12 16]
    core_ = [1 3 4 5 6 7 2 8]
    
    if j < 9
        figure("CarbonCI")
        subplot(2,4,core_[j])
    elseif j >= 9 && j < 25
        figure("EnergyCI")
        subplot(4,4,amino_[j-8])
    else
        figure("AminoCI")
        subplot(4,5,j-8-16)
    end
    
#    plot(Tsim,m,"k")
#    fill_between(vec(Tsim),m+1.96*s,max(0,m-1.96*s),facecolor="lightblue")
#    fill_between(vec(Tsim),m+1.96*se,max(0,m-1.96*se),facecolor="lightgray")
    
    if typeof(index) == Int
        tmp = X[:,index]
    elseif typeof(index) == Tuple{Int,Int,Int}
        tmp = X[:,index[1]]+X[:,index[2]]+X[:,index[3]]
    elseif typeof(index) == Tuple{Int,Int,Int,Int,Int,Int,Int,Int,Int,Int,Int,Int}
        tmp = X[:,index[1]]+X[:,index[2]]+X[:,index[3]]+X[:,index[4]]+X[:,index[5]]+X[:,index[6]]+X[:,index[7]]+X[:,index[8]]+X[:,index[9]]+X[:,index[10]]+X[:,index[11]]+X[:,index[12]]
    else
        throw("Wrong type")
    end
    
    if str == "CAT"
        tmp *= 1000
    end
    
    plot(Tsim,tmp,"green",linewidth=1.5)
    
    tight_layout()
end

end






