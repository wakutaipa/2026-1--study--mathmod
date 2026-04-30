using DifferentialEquations, Plots

N = 12900
I0 = 190
R0 = 59
p = [0.2, 0.4]
tspan = (0, 50)
S0 = N -I0 - R0
X0 = [S0, I0, R0]

function syst(x, p, t)
	(S, I, R) = x
	(b, c) = p
	dS = -b*S
	dI = b*S - c*I
	dR = c*I
	return [dS, dI, dR]
end

prob = ODEProblem(syst, X0, tspan, p)
sol = solve(prob, Tsit5(), saveat = 0.01)

pl2 = plot(sol, labels=["S(t)" "I(t)" "R(t)"], xlabel="Время", ylabel="Численность популяции")

savefig(pl2, "I(0)>I*.png")
