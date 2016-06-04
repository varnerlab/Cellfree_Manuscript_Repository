include("DataDictionary.jl")
include("SolveBalances.jl")
include("CalcError.jl")
using PyPlot

# Create Ensemble directory if it doesn't already exist
if ~isdir("Ensemble")
    mkdir("Ensemble")
end

# Create Best directory if it doesn't already exist
if ~isdir("Ensemble/Best")
    mkdir("Ensemble/Best")
end

# Setup the timescale
TSTART = 0.0
TSTOP = 3.0
Ts = 0.1

# Create dictionary of parameters
data_dictionary_best = DataDictionary(TSTART,TSTOP,Ts)
experiment_data_dictionary = data_dictionary_best["EXPERIMENT_DATA_DICTIONARY"]

#data_indices = Int64[]
#for (key,value) in experiment_data_dictionary
#    push!(data_indices,value.model_index)
#end
#sort!(data_indices)

#init_indices = collect(1:103)
#deleteat!(init_indices,data_indices)

# Initialize number of parameters to be varied
num_rate = 163
#num_init = 66
num_init = 0
num_sat = 455
num_cont = 34

# Create or read the relevant information
if ~isfile("Ensemble/Best/params")
    # Take rate constants to be varied from data_dictionary_best
    rate = data_dictionary_best["RATE_CONSTANT_ARRAY"][1:163]
    # Take initial conditions to be varied from data_dictionary_best
#    init = data_dictionary_best["INITIAL_CONDITION_ARRAY"][init_indices]
    # Take saturation constants to be varied from data_dictionary_best
    sat_vector = vec(data_dictionary_best["SATURATION_CONSTANT_ARRAY"])
    sat = sat_vector[find(sat_vector.>0)]
    # Take control parameters to be varied from data_dictionary_best
    cont = vec(data_dictionary_best["CONTROL_PARAMETER_ARRAY"]')
    # Concatenate into params vector
#    params = [rate;init;sat;cont]
    params_best = [rate;sat;cont]
    # Solve the balance equations and calculate cost
    Tsim_best,X_best = SolveBalances(TSTART,TSTOP,Ts,data_dictionary_best)
    cost_best = CalcError(experiment_data_dictionary,Tsim_best,X_best)
    # Save the relevant information
    writedlm("Ensemble/Best/Tsim",Tsim_best)
    writedlm("Ensemble/Best/X",X_best)
    writedlm("Ensemble/Best/cost",cost_best)
    writedlm("Ensemble/Best/params",params_best)
else
    # Read the relevant information
    Tsim_best = readdlm("Ensemble/Best/Tsim")
    X_best = readdlm("Ensemble/Best/X")
    cost_best = readdlm("Ensemble/Best/cost")[1]
    params_best = readdlm("Ensemble/Best/params")
    # Check that params is of correct length
    if ~(num_rate+num_init+num_sat+num_cont==length(params_best))
        throw("Wrong number of parameters")
    end
    # Add rate constants to data_dictionary_best
    rate = params_best[1:num_rate]
    data_dictionary_best["RATE_CONSTANT_ARRAY"][1:163] = rate
    # Add initial conditions to data_dictionary_best
#    init = params[num_rate+1:num_rate+num_init]
#    data_dictionary_best["INITIAL_CONDITION_ARRAY"][init_indices] = init
    # Add saturation constants to data_dictionary_best
    sat = params_best[num_rate+num_init+1:num_rate+num_init+num_sat]
    sat_vector = vec(data_dictionary_best["SATURATION_CONSTANT_ARRAY"])
    sat_vector[find(sat_vector.>0)] = sat
    data_dictionary_best["SATURATION_CONSTANT_ARRAY"] = reshape(sat_vector,size(data_dictionary_best["SATURATION_CONSTANT_ARRAY"]))
    # Add control parameters to data_dictionary_best
    cont = params_best[num_rate+num_init+num_sat+1:num_rate+num_init+num_sat+num_cont]
    data_dictionary_best["CONTROL_PARAMETER_ARRAY"] = reshape(cont,2,convert(Int64,length(cont)/2))'
end

variance = .03 # Equates to average perturbation of 2.4%, "maximum" perturbation of about 3.2%

num_iter = 10
i_range = 1:num_iter
for i in i_range
    # Create directory for next sample
    mkdir("Ensemble/$i")
    # Write iteration to disk
    writedlm("Ensemble/dir",i)
    # Copy data_dictionary
    data_dictionary = deepcopy(data_dictionary_best)
    # Perturb parameters
    params = params_best.*exp(variance*randn(length(params_best)))
    # Add rate constants to data_dictionary
    rate = params[1:num_rate]
    data_dictionary["RATE_CONSTANT_ARRAY"][1:163] = rate
    # Add initial conditions to data_dictionary
    #init = params[num_rate+1:num_rate+num_init]
    #data_dictionary["INITIAL_CONDITION_ARRAY"][init_indices] = init
    # Add saturation constants to data_dictionary
    sat = params[num_rate+num_init+1:num_rate+num_init+num_sat]
    sat_vector = vec(data_dictionary["SATURATION_CONSTANT_ARRAY"])
    sat_vector[find(sat_vector.>0)] = sat
    data_dictionary["SATURATION_CONSTANT_ARRAY"] = reshape(sat_vector,size(data_dictionary["SATURATION_CONSTANT_ARRAY"]))
    # Add control parameters to data_dictionary
    cont = params[num_rate+num_init+num_sat+1:num_rate+num_init+num_sat+num_cont]
    data_dictionary["CONTROL_PARAMETER_ARRAY"] = reshape(cont,2,convert(Int64,length(cont)/2))'
    # Solve the balance equations and calculate cost
    Tsim,X = SolveBalances(TSTART,TSTOP,Ts,data_dictionary)
    cost = CalcError(experiment_data_dictionary,Tsim,X)
    # Save the relevant information
    writedlm("Ensemble/$i/Tsim",Tsim)
    writedlm("Ensemble/$i/X",X)
    writedlm("Ensemble/$i/cost",cost)
    writedlm("Ensemble/$i/params",params)
    # If a new best is achieved, overwrite params_best and cost_best and save the relevant information to Best directory
    if cost < cost_best
        params_best = copy(params)
        cost_best = copy(cost)
        writedlm("Ensemble/Best/Tsim",Tsim)
        writedlm("Ensemble/Best/X",X)
        writedlm("Ensemble/Best/cost",cost)
        writedlm("Ensemble/Best/params",params)
        println("$i: cost = $cost, best = $cost_best, NEW BEST")
    else
        println("$i: cost = $cost, best = $cost_best")
    end
end






