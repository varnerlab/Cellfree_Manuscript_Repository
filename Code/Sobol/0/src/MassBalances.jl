include("Kinetics.jl");
include("Control.jl");

# ----------------------------------------------------------------------------------- #
# Copyright (c) 2016 Varnerlab
# School of Chemical Engineering Purdue University
# W. Lafayette IN 46907 USA

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights 
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
function MassBalances(t,x,dxdt_vector,data_dictionary)
# ---------------------------------------------------------------------- #
# MassBalances.jl was generated using the Kwatee code generation system.
# Username: nicholas
# Type: CFPS-JULIA
# Version: 1.0
# Generation timestamp: 05-11-2016 16:22:26
# 
# Arguments: 
# t  - current time 
# x  - state vector 
# dxdt_vector - right hand side vector 
# data_dictionary  - Data dictionary instance (holds model parameters) 
# ---------------------------------------------------------------------- #

# Correct nagative x's = throws errors in control even if small - 
const idx = find(x->(x<0),x);
x[idx] = 0.0;

# Call the kinetics function - 
(rate_vector) = Kinetics(t,x,data_dictionary);

# Call the control function - 
(rate_vector) = Control(t,x,rate_vector,data_dictionary);

R_PTS = abs(rate_vector[1])
R_glk_atp = abs(rate_vector[2])
R_glk_utp = abs(rate_vector[3])
R_glk_ctp = abs(rate_vector[4])
R_glk_gtp = abs(rate_vector[5])

# Set maximum allowable flux
max_allowable_flux = t*(-40/3)+50

# Apply maximum allowable flux to non-glucose-uptake reactions
i_range = 6:134
for i in i_range
    rate_vector[i] = min(rate_vector[i],max_allowable_flux)
end

## Check if dir exists; if it doesn't, this is the initial evaluation of the pre-existing best-fit set
#if isfile("Ensemble/dir")
#    # Read set number
#    dir = convert(Int64,readdlm("Ensemble/dir")[1])
#    # If no directory called Flux exists, create one
#    if ~isdir("Ensemble/$dir/Flux")
#        mkdir("Ensemble/$dir/Flux")
#        writedlm("Ensemble/$dir/Flux/num_tp",0)
#    end
#    # Save fluxes at certain timepoints
#    if t < 1e-11 || (t > 1.48 && t < 1.52) || t > 2.98
#        num_tp = convert(Int64,readdlm("Ensemble/$dir/Flux/num_tp")[1])
#        num_tp += 1
#        writedlm("Ensemble/$dir/Flux/$num_tp",[t;rate_vector])
#        writedlm("Ensemble/$dir/Flux/num_tp",num_tp)
#    end
#end

# Encode the balance equations as a matrix vector product - 
const S = data_dictionary["STOICHIOMETRIC_MATRIX"];
const tmp_vector = S*rate_vector;
const number_of_states = length(tmp_vector);
for state_index in [1:number_of_states;]
	dxdt_vector[state_index] = tmp_vector[state_index];
end

end
