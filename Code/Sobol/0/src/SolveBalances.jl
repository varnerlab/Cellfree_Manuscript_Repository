include("MassBalances.jl")
using Sundials;

# ----------------------------------------------------------------------------------- #
# Copyright (c) 2015 Varnerlab
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
function SolveBalances(IC_vector)
# ----------------------------------------------------------------------------------- #
# SolveBalances.jl was generated using the Kwatee code generation system.
# SolveBalances: Solves model equations from TSTART to TSTOP given parameters in data_dictionary.
# Username: nicholas
# Type: CFPS-JULIA
# Version: 1.0
# Generation timestamp: 12-15-2015 14:24:33
# 
# Input arguments: 
# TSTART  - Time start 
# TSTOP  - Time stop 
# Ts - Time step 
# data_dictionary  - Data dictionary instance (holds model parameters) 
# 
# Return arguments: 
# TSIM - Simulation time vector 
# X - Simulation state array (NTIME x NSPECIES) 
# ----------------------------------------------------------------------------------- #
include("DataDictionary.jl")

# Load data dictionary
TSTART = 0.0
TSTOP = 3.0
Ts = 0.1
data_dictionary = DataDictionary(TSTART,TSTOP,Ts)

# Get required stuff from DataFile struct -
TSIM = [TSTART:Ts:TSTOP;]
initial_condition_vector = data_dictionary["INITIAL_CONDITION_ARRAY"]
#initial_condition_vector[[54;93;80;43;76;73;77;91;90;74;79;75;89;78;88;81:87;104:266]] = IC_vector
initial_condition_vector[[54;93]] = IC_vector
#-------------------------------------------------------------------
# Note: data_dictionary["INITIAL_CONDITION_ARRAY"] does not contain
#       correct information (IC_vector), but this does not matter
#       as INITIAL_CONDITION_ARRAY is not used by MassBalances,
#       Kinetics, or Control (it is done this way for speed)
#-------------------------------------------------------------------

# Call the ODE solver - 
fbalances(t,y,ydot) = MassBalances(t,y,ydot,data_dictionary)
X = Sundials.cvode(fbalances,initial_condition_vector,TSIM,abstol=1e-10,reltol=1e-8)

return (TSIM,X)
end

function SolveBalances(TSTART,TSTOP,Ts,data_dictionary)
# ----------------------------------------------------------------------------------- #
# SolveBalances.jl was generated using the Kwatee code generation system.
# SolveBalances: Solves model equations from TSTART to TSTOP given parameters in data_dictionary.
# Username: nicholas
# Type: CFPS-JULIA
# Version: 1.0
# Generation timestamp: 12-15-2015 14:24:33
# 
# Input arguments: 
# TSTART  - Time start 
# TSTOP  - Time stop 
# Ts - Time step 
# data_dictionary  - Data dictionary instance (holds model parameters) 
# 
# Return arguments: 
# TSIM - Simulation time vector 
# X - Simulation state array (NTIME x NSPECIES) 
# ----------------------------------------------------------------------------------- #

# Get required stuff from DataFile struct -
TSIM = [TSTART:Ts:TSTOP;]
initial_condition_vector = data_dictionary["INITIAL_CONDITION_ARRAY"]

# Call the ODE solver - 
fbalances(t,y,ydot) = MassBalances(t,y,ydot,data_dictionary)
X = Sundials.cvode(fbalances,initial_condition_vector,TSIM,abstol=1e-10,reltol=1e-8)

return (TSIM,X)
end
