using PyPlot
using PyCall
@pyimport numpy as np

include("Local_sens_fxn.jl")

num_iter = 180 # Should be set equal to number of samples in sub-ensemble
for i in 1:num_iter
    Local_sens_fxn(i)
end

Rate = readdlm("Sens/1/Rate")
Sat = readdlm("Sens/1/Sat")
Cont = readdlm("Sens/1/Cont")

for i in 1:num_iter
    rate = readdlm("Sens/$i/Rate")
    sat = readdlm("Sens/$i/Sat")
    cont = readdlm("Sens/$i/Cont")
    Rate = [Rate rate]
    Sat = [Sat sat]
    Cont = [Cont cont]
end

writedlm("Sens/Rate",Rate)
writedlm("Sens/Sat",Sat)
writedlm("Sens/Cont",Cont)

Rate_m = Float64[]
Rate_s = Float64[]
for i in 1:size(Rate)[1]
    rate = Rate[i,:]
    push!(Rate_m,mean(rate))
    push!(Rate_s,std(rate))
end

Sat_m = Float64[]
Sat_s = Float64[]
for i in 1:size(Sat)[1]
    sat = Sat[i,:]
    push!(Sat_m,mean(sat))
    push!(Sat_s,std(sat))
end

Cont_m = Float64[]
Cont_s = Float64[]
for i in 1:size(Cont)[1]
    cont = Cont[i,:]
    push!(Cont_m,mean(cont))
    push!(Cont_s,std(cont))
end

writedlm("Sens/Rate_m",Rate_m)
writedlm("Sens/Rate_s",Rate_s)
writedlm("Sens/Sat_m",Sat_m)
writedlm("Sens/Sat_s",Sat_s)
writedlm("Sens/Cont_m",Cont_m)
writedlm("Sens/Cont_s",Cont_s)

PyCall.PyDict(matplotlib["rcParams"])["font.sans-serif"] = ["Helvetica"]

Rate_m = readdlm("Sens/Rate_m")
Rate_s = readdlm("Sens/Rate_s")/sqrt(180)
width = 1
a = [1:2:2*length(Rate_m);]
threshold = 0.05*ones(a)
PyPlot.matplotlib[:rc]("text",usetex=true)
fig,ax = plt[:subplots](figsize=(15,7))
b = ax[:bar](a,Rate_m,width,align="center",yerr=Rate_s,ecolor="black",color="black")
ax[:set_xticks]([])
plt[:margins](0.002)
plt[:ylim]([-0.3,0.8])
plt[:yticks]([-0.3:.1:0.8],fontsize=20)
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
a1 = a[5:5:end]
a2 = 5:5:length(a)
plt[:xticks](a1,a2)

Sat_m = readdlm("Sens/Sat_m")
Sat_s = readdlm("Sens/Sat_s")/sqrt(180)
width = 1
a = [1:2:2*length(Sat_m);]
threshold = 0.05*ones(a)
PyPlot.matplotlib[:rc]("text",usetex=true)
fig,ax = plt[:subplots](figsize=(15,7))
b = ax[:bar](a,Sat_m,width,align="center",yerr=Sat_s,ecolor="black",color="black")
ax[:set_xticks]([])
plt[:margins](0.002)
plt[:ylim]([-0.4,0.1])
plt[:yticks]([-0.4:.1:0.1],fontsize=20)
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
a1 = a[20:20:end]
a2 = 20:20:length(a)
plt[:xticks](a1,a2)

Cont_m = readdlm("Sens/Cont_m")
Cont_s = readdlm("Sens/Cont_s")/sqrt(180)
width = 1
a = [1:2:2*length(Cont_m);]
threshold = 0.05*ones(a)
PyPlot.matplotlib[:rc]("text",usetex=true)
fig,ax = plt[:subplots](figsize=(15,7))
b = ax[:bar](a,Cont_m,width,align="center",yerr=Cont_s,ecolor="black",color="black")
ax[:set_xticks]([])
plt[:margins](0.002)
plt[:ylim]([-.02,.02])
plt[:yticks]([-.02:.01:.02],fontsize=20)
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
a1 = a[1:1:end]
a2 = 1:1:length(a)
plt[:xticks](a1,a2)






