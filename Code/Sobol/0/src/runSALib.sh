n=$(<n)
partition_size=186
num_jobs=10
echo $partition_size > partition_size
echo $num_jobs > num_jobs

julia CreateSobolDir.jl
julia CreateRunDir.jl

param=($(wc param.txt))
num_params=${param[0]}

num_iterations=$((2*n*(num_params+1)))
iterations_per_job=$((num_iterations/num_jobs))
echo $iterations_per_job > iterations_per_job

num_partitions=$((iterations_per_job/partition_size))

for j in $(eval echo "{1..$num_partitions}")
do
    julia RunSobol.jl
done

julia WriteModelOutput.jl
