using DifferentialEquations
using Plots

tspan = (0, 42)

q1 = [0, 7.5]
q2 = [2, 5.5]
q3 = [2.4, 5]

du0 = [1.0]  
u0 = [1.2]  

function harm_osc(ddu, du, u, q, t)
    g, w = q
    ddu .= -g.*du .- w.*u
end

f(t) = 5.2*sin(2*t)

function harm_osc2(ddu, du, u, q, t)
    g, w = q
    ddu .= -g*du .- w*u .- f(t)
end

task1 = SecondOrderODEProblem(harm_osc, du0, u0, tspan, q1)
sol1 = solve(task1, DPRKN6(), saveat = 0.05)

task2 = SecondOrderODEProblem(harm_osc, du0, u0, tspan, q2)
sol2 = solve(task2, DPRKN6(), saveat = 0.05)

task3 = SecondOrderODEProblem(harm_osc2, du0, u0, tspan, q3)
sol3 = solve(task3, DPRKN6(), saveat = 0.05)

function plot_osc(sol, title)
	plot(sol, vars=(0, 1), label="y", xlabel="время t", ylabel="", title=title)
	plot!(sol, vars=(0,2), label="x", xlabel="время t", ylabel="", title=title)
end

pl1 = plot_osc(sol1, "без затухания и внешней силы")
cp1 = plot(sol1, vars=(2,1), label="y от x", xlabel="x", ylabel="y", title="фазовый потрет без затухания и внешней силы")
savefig(pl1, "1.png")
savefig(cp1, "2.png")

pl1 = plot_osc(sol2, "с затуханием, без внешней силы")
cp1 = plot(sol2, vars=(2,1), label="y от x", xlabel="x", ylabel="y", title="фазовый потрет с затуханием, без внешней силы")
savefig(pl1, "3.png")
savefig(cp1, "4.png")

pl1 = plot_osc(sol3, "с затуханием и внешней силой")
cp1 = plot(sol3, vars=(2,1), label="y от x", xlabel="x", ylabel="y", title="фазовый потрет с затуханием и внешней силой")
savefig(pl1, "5.png")
savefig(cp1, "6.png")
