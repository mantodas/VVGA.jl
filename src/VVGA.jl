module VVGA

using Grassmann, Reduce, LinearAlgebra, Plots
export 𝐞₁, 𝐞₂, 𝐞₃, 𝐞₁₂, 𝐞₂₃, 𝐞₃₁, 𝐞₁₂₃ 
include("VV3DSignal/vv3D.jl")
export kVectorPart, bivecExp, vector2tuple, VV3dPlot, VV4dPlot, VV3Danim, VV4Danim
end
