# Import number of runs; if this is first run, set equal to 1
if isfile("./Sobol/num_run")
    num_run = convert(Int64,readdlm("./Sobol/num_run")[1])+1
else
    num_run = 1
end
# Create directory for next run and save number of runs
mkdir("./Sobol/Run$num_run")
writedlm("./Sobol/num_run",num_run)
