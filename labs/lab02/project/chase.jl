using DifferentialEquations, Plots

r0  = 15.5/ 4.5
r1 = 15.5/2.5

theta = (0, 2*pi)
theata1 = (-pi, pi)

fi = 3*pi/4;
t = (0, 50);

x(t) = tan(fi)t;*

f(r, p, t) = r/sqrt(11.25);

task = ODEProblem(f, r0, theta)
res = solve(task, saveat = 0.01)

angle = [fi for i in range(0, 25)]
xlim = [x(i) for i in range(0, 25)]

p = plot(res.t, res.u, proj =:polar, lims = (0, 25), 
         label = "Траектория движения катера", 
         grid = true)
plot!(p, angle, xlim, proj =:polar, lims = (0, 25), 
      label = "Траектория движения лодки")
      
savefig(p, "Both_trajectories.png")
println("Plots saved to current directory")


