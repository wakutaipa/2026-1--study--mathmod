using DifferentialEquations
using Plots

p = [0.83, 0.84, 0.043, 0.024]

x_eq = p[2] / p[4] 
y_eq = p[1] / p[3]  

u0 = [x_eq, y_eq] 

tspan = (0.0, 50.0)

function lotkavolter(u, p, t)
    x, y = u
    a, b, c, d = p
    dx = -a*x + c*x*y
    dy = b*y - d*x*y
    return [dx, dy]
end

problem = ODEProblem(lotkavolter, u0, tspan, p)
solution = solve(problem, Tsit5(), abstol=1e-14, reltol=1e-14)

x_vals = [u[1] for u in solution.u]
y_vals = [u[2] for u in solution.u]

a = plot(solution, 
         title="Lotka-Volterra - Stationary Point",
         xlabel="Time", 
         ylabel="Population Level", 
         label=["Prey" "Predators"], 
         linewidth=2)

b = scatter([x_eq], [y_eq], 
        title="Phase Portrait - Stationary Point",
        xlabel="Prey Population", 
        ylabel="Predator Population",
        label="Equilibrium point",
        markersize=5,
        color=:red)

savefig(a, "LV_model_stationary.png")
savefig(b, "phase_portrait_stationary.png")
