using DifferentialEquations
using Plots

X0 = 30030
Y0 = 59010
t0 = 0
a = 0.46 
b = 0.58
c = 0.69
h = 0.23

tmax = 1
dt = 0.05
t = collect(t0:dt:tmax)
P(t) = abs(sin(2*t) +1)
Q(t) = abs(cos(t) + 1)

function syst!(dy, y, p, t)
	a, b, c, h = p
	dy[1] = -a*y[1] - b*y[2] + P(t)
	dy[2] = -c*y[1] - h*y[2] + Q(t)
end

v0 = [X0, Y0]
tspan = (t0, tmax)
p = [a, b, c , h]
prob = ODEProblem(syst!, v0, tspan, p)
sol = solve(prob, saveat = dt)

p = plot(sol.t, sol[1, :], linecolor = :blue, label = "Армия X", title = "Первая модель боевых действий", xlabel = "Время", ylabel="численность армии")
plot!(sol.t, sol[2, :], linecolor = :red, label = "Армия Y")

savefig(p, "Lanchester model 1.png")
