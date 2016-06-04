function CalcArea(Tsim,X)

if !(length(Tsim)==length(X))
    throw("Vectors must be of same length")
end

AUC = Float64[]

i_range = 2:length(Tsim)
for i in i_range
    push!(AUC,(Tsim[i]-Tsim[i-1])*(X[i]+X[i-1])/2) # Trapezoid rule
end

AUC = sum(AUC)

return AUC
end
