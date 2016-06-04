# ReadSobol samples
model_input = readdlm("model_input.txt")
# Create directory, if necessary
if ~isdir("../../model_input")
    mkdir("../../model_input")
end
# Save each vector separately
i_range = 1:size(model_input)[1]
for i in i_range
    writedlm("../../model_input/$i",model_input[i,:])
end
