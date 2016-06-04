include("RunModel.jl")
include("CalcArea.jl")

# Import number of runs
num_run = convert(Int64,readdlm("./Sobol/num_run")[1])

# Import number of samples; if this is first sample, set equal to 1
if isfile("./Sobol/Run$num_run/num_sample")
    num_sample = convert(Int64,readdlm("./Sobol/Run$num_run/num_sample")[1])+1
else
    num_sample = 1
end

# Import partition size and number of iterations (per job)
partition_size = convert(Int64,readdlm("partition_size")[1])
iterations_per_job = convert(Int64,readdlm("iterations_per_job")[1])

# Import job number
pwd_str = pwd()
str = pwd_str[end-4]
job = parse("$str")

# Solve partition_size number of samples
for i = num_sample:num_sample+partition_size-1
    # Create directory for next sample and save number of samples
    mkdir("./Sobol/Run$num_run/Sample$num_sample")
    writedlm("./Sobol/Run$num_run/num_sample",num_sample)

    # Simulate
    Tsim,X = RunModel(iterations_per_job*job+num_sample)

    # Calculate area under CAT curve and save as objective function
    obj_fun = CalcArea(Tsim,X[:,92])
    writedlm("./Sobol/Run$num_run/Sample$num_sample/obj_fun.dat",obj_fun)

    # Save timecourse and species
    writedlm("./Sobol/Run$num_run/Sample$num_sample/Tsim.dat",Tsim)
    writedlm("./Sobol/Run$num_run/Sample$num_sample/X.dat",X)

    num_sample += 1
end
