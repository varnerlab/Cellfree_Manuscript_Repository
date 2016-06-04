# Import number of jobs
num_jobs = convert(Int64,readdlm("num_jobs")[1])

# Initialize total output array
Output = Float64[]

# For each job, add job output to total output array
i_range = 0:num_jobs-1
for i in i_range
    output = readdlm("../../$i/src/model_output.txt")
    Output = [Output;output]
end

# Save in src
writedlm("model_output.txt",Output)
