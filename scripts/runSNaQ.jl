#!/usr/bin/env julia

print("starting")

length(ARGS) > 0 ||
    error("need 1 or 2 arguments: # reticulations (h) and # runs (optional, 10 by default)")
h = parse(Int, ARGS[1])
nruns = 10
if length(ARGS) > 1
    nruns = parse(Int, ARGS[2])
end
outputfile = string("net", h, "_", nruns, "runs") # example: "net2_10runs"
seed = 1234 + h # change as desired! Best to have it different for different h
@info "will run SNaQ with h=$h, # of runs=$nruns, seed=$seed, output will go to: $outputfile"

using Distributed
addprocs(nruns; exeflags="--project=$(Base.active_project())")
println("Number of processes: ", nprocs())
# pctivate("/home/rebecca.clement/.julia/project1")
println("Number of workers: ", nworkers())

@everywhere using Pkg; Pkg.activate("/home/rebecca.clement/.julia/project1"); Pkg.instantiate()
println(Pkg.status())
#@everywhere using Pkg; using PhyloNetworks
# using Pkg
#Pkg.activate("/home/rebecca.clement/.julia/project1")
#Pkg.instantiate()
using PhyloNetworks
net0 = readTopology("aphis_astral.tre");
using DataFrames, CSV
df_sp = DataFrame(CSV.File("aphis_tableCF.csv", pool=false); copycols=false);
d_sp = readTableCF!(df_sp);
net = snaq!(net0, d_sp, hmax=h, filename=outputfile, seed=seed, runs=nruns)
