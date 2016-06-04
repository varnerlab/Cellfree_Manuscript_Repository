julia ModelOutput.jl

python -m SALib.analyze.sobol \
     -p ./param.txt \
     -Y model_output.txt \
     -c 0 \
     > SobolAnalysis.txt

julia SA.jl
