# Read SobolAnalysis.txt (it should omit blank lines)
SobolAnalysis = readdlm("SobolAnalysis.txt")

# Find last row that contains sensitivities (not co-sensitivities)
last_row = find(SobolAnalysis[:,1].=="Parameter_1")[1]-1

# Remove co-sensitivities, as well as headings in first row
SA = SobolAnalysis[2:last_row,:]

# Write to disk
writedlm("SA.txt",SA)
