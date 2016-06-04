function RunModel(num_sample)
include("SolveBalances.jl")

# Insert sobol values
IC_vector = vec(readdlm("../../model_input/$num_sample"))

# Solve balance equations
Tsim,X = SolveBalances(IC_vector)

return Tsim,X
end
