using Interpolations

function CalcError(experiment_data_dictionary,Tsim,X)
# Initialize array
Error = Float64[]
for (key,dataset) in experiment_data_dictionary
    # Get raw data and timepoints
    raw_array = dataset.raw_measurement_array
    data_tps = raw_array[:,1]
    data_vals = raw_array[:,2]
    # Interpolate simulation array to fit dataset
    index = dataset.model_index
    sim = X[:,index]
    itp = interpolate((Tsim,),sim,Gridded(Linear()))
    sim_itp = itp[data_tps]
    # Calculate error
    error = sum(abs(sim_itp-data_vals))/maximum(data_vals)
    # Weight certain datasets as more important
    weight = (key == "M_glc_D_c" || key == "CAT" || key == "M_pyr_c" || key == "M_lac_D_c" || key == "M_ac_c" || key == "M_succ_c" || key == "M_mal_L_c")?5:1
    error *= weight
    # Push to array
    push!(Error,error)
end

cost = sum(Error)

return cost
end
