using PyPlot
using PyCall
@pyimport numpy as np

PyCall.PyDict(matplotlib["rcParams"])["font.sans-serif"] = ["Helvetica"]

Sobol = readdlm("SA.txt")
Sobol_metab = Sobol[1:22,:]

Sens = Sobol[:,4] # total order sensitivities
CI = Sobol[:,5] # total order sensitivity confidence intervals

Sens_metab = Sobol_metab[:,4] # total order sensitivities
CI_metab = Sobol_metab[:,5] # total order sensitivity confidence intervals

width = 1

PyPlot.matplotlib[:rc]("text",usetex=true)

# Plot all indices
alpha = length(Sens)
x = [1:2:2*alpha;]
threshold = 0.05*ones(x)
fig1, ax1 = plt[:subplots](figsize=(15,7))
b = ax1[:bar](x,Sens,width,align="center",yerr=CI,ecolor="black",color="black")
ax1[:set_xticks]([])
plt[:margins](0.002)
plt[:ylim]([0,1])
plt[:yticks]([0:.2:1],fontsize=20);
plt[:tick_params](axis="x",which="both",bottom="off",top="off")

# Plot metabolite indices only
alpha = length(Sens_metab)
x = [1:2:2*alpha;]
threshold = 0.05*ones(x)
fig2, ax2 = plt[:subplots](figsize=(15,7))
b = ax2[:bar](x,Sens_metab,width,align="center",yerr=CI_metab,ecolor="black",color="black")
ax2[:set_xticks]([])
plt[:margins](0.002)
plt[:ylim]([0,.2])
plt[:yticks]([0:.05:.2],fontsize=20);
plt[:tick_params](axis="x",which="both",bottom="off",top="off")
