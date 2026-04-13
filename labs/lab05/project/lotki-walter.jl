using DifferentialEquations
using Plots

u0 = [10, 20]
p = [0.83, 0.84, 0.043, 0.024]
tspan = (0.0, 50.0)

function lotkavolter(u, p, t)
	x,y = u
	a,b,c,d = p
	dx = -a*x + c*x*y
	dy = b*y -d*x*y
	return[dx, dy]
end

problem = ODEProblem(lotkavolter, u0, tspan, p)
solution = solve(problem, Tsit5())

a = plot(solution, title="Lotka-volter model", xlabel="time", ylabel="population level", label=["prey" "predators"], linewidth=2)

b = plot(solution, idxs=(1,2), title="phase portrait", label="y from x", xlabel="x, prey", ylabel="y, predators", linewidth=2)

savefig(a, "Lotka-volter_model.png")
savefig(b, "phase_portrait.png")
