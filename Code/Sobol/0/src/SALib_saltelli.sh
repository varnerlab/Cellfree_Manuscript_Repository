n=300
echo $n > n

julia SetBounds.jl

python -m SALib.sample.saltelli \
     -n $n \
     -p ./param.txt \
     -o model_input.txt \

julia SplitModelInput.jl
