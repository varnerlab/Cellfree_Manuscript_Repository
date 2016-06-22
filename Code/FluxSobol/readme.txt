Julia must be installed with GLPK package
Run the following in Julia to add GLPK
Pkg.add(“GLPK”)


Set up the the range for the sampling range of the parameter initial conditions in /sensitivity/Range.txt
Determine the sample size n and run /sensitivity/sample.sh to get desired sets of sample
Run /src/SampleBounds.jl in Julia to optimize for protein production (export) based on each set of initial condition
Shell file /sensitivity/analyze_final.sh gives the sensitivity index of protein export flux to each parameter, and its confidence interval as well.
