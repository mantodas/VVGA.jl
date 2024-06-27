using VVGA

#Define Vector-Valued Bivector Exponenial Signal
a₀ = 3.0
𝐮₀ = 𝐞₁         
𝐣₀ = 𝐞₁₂            
ω₀ = 1  
𝐱 = bivecExp(a₀, 𝐮₀, 𝐣₀, ω₀)

timeValues = 0:0.1:10
signalValues = 𝐱.(timeValues)

#3D Time Domain Plot
VV3dPlot(signalValues;rMax=a₀)

#4D Time Domain Plot
VV4dPlot(signalValues;rMax=a₀)
