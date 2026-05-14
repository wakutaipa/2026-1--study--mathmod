using DifferentialEquations, Plots

f1(n, p, t) = (p[1]+p[2]*n)*(p[3]-n)
f2(n, p, t) = (p[1]*cos(t)+p[2]*cos(t)*n)*(p[3]-n)

N = 1600
n = 13
p1 = [0.12, 0.000039, N]
p2 = [0.000012, 0.29, N]
p3 = [0.12, 0.29, N]
tspan = (0.0, 30.0)
tspan1 = (0.0, 0.03)
tspan2 = (0.0, 0.05) 

q1 = ODEProblem(f1, n, tspan, p1)
q2 = ODEProblem(f1, n, tspan1, p2)
q3 = ODEProblem(f2, n, tspan2, p3)

sol = solve(q1, Tsit5(), saveat=0.01)
sol2 = solve(q2, Tsit5(), saveat=0.01)
sol3 = solve(q3, Tsit5(), saveat=0.01)

a = plot(sol, xlabel = "time", ylabel = "N(t)", label = "n")
savefig(a, "q1.png")

growth_rates = [f1(sol2.u[i], p2, sol2.t[i]) for i in 1:length(sol2.t)]
max_idx = argmax(growth_rates)
max_time = sol2.t[max_idx]
println(max_idx, " at time: ", max_time)
x = sol2.t[max_idx]
y = sol2.u[max_idx]

plot(sol2, xlabel = "time", ylabel = "N(t)", label = "n")
scatter!((x,y), leg =:bottomright, label = "maximum value")
savefig("q2.png")

c = plot(sol3, xlabel = "time", ylabel = "N(t)", label = "n")
savefig(c, "q3.png")

