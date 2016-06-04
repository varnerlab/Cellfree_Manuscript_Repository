# Import run number and number of samples
num_run = convert(Int64,readdlm("./Sobol/num_run")[1])
num_sample = convert(Int64,readdlm("./Sobol/Run$num_run/num_sample")[1])

# Initialize objective function array
ObjFun = Float64[]

# For each sample, import objective function value and add to objective function array
sample_range = 1:num_sample
for sample in sample_range
    push!(ObjFun,readdlm("./Sobol/Run$num_run/Sample$sample/obj_fun.dat")[1])
end

# Save in run folder and in src
writedlm("./Sobol/Run$num_run/model_output.txt",ObjFun)
writedlm("model_output.txt",ObjFun)
