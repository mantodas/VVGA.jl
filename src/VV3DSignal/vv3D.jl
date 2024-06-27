    using Grassmann
    basis"3"
    𝐞₁ = v₁
    𝐞₂ = v₂
    𝐞₃ = v₃
    𝐞₁₂ = v₁₂
    𝐞₂₃ = v₂₃
    𝐞₃₁ = -v₁₃
    𝐞₁₂₃ = v₁₂₃    
    export 𝐞₁, 𝐞₂, 𝐞₃, 𝐞₁₂, 𝐞₂₃, 𝐞₃₁, 𝐞₁₂₃ 

    function kVectorPart(M,k)
        M = M + 0.0 + 0.0𝐞₁ + 0.0𝐞₂ + 0.0𝐞₃ + 0.0𝐞₁₂ + 0.0𝐞₂₃ + 0.0𝐞₃₁ + 0.0𝐞₁₂₃ 
        if k==0
            return M.v[1]
        end
        if k==1
            return (M⋅𝐞₁)*𝐞₁ + (M⋅𝐞₂)*𝐞₂ + (M⋅𝐞₃)*𝐞₃
        end
        if k==2
            return (M⋅𝐞₁₂)*𝐞₁₂ + (M⋅𝐞₃₁)*𝐞₃₁ + (M⋅𝐞₂₃)*𝐞₂₃ 
        end
        if k==3
            return (M⋅𝐞₁₂₃)*𝐞₁₂₃
        end
    end

    function bivecExp(a₀, 𝐮₀, 𝐣₀, ω₀)
        if norm(𝐮₀)≠1; @warn("bivecExp:unit vector not unit length. Normalizing..."); 𝐮₀ = 𝐮₀/norm(𝐮₀)end
        if norm(𝐮₀∧𝐣₀)>0; error("bivecExp:initial vector not in the plane of rotation"); end
        return 𝐱(t) = a₀*𝐮₀*exp(𝐣₀*ω₀*t) + 0.0𝐞₁ + 0.0𝐞₂ + 0.0𝐞₃
    end

    function vector2tuple(signalValuesClifford)
        signalValues = []
        timeIndex = 1:length(signalValuesClifford)
        for n ∈ timeIndex
            push!(signalValues,[signalValuesClifford[n].v[1],signalValuesClifford[n].v[2],signalValuesClifford[n].v[3]])
        end
        return signalValues
    end
    
    export kVectorPart, bivecExp, vector2tuple

    #-----

    using Plots

    function VV3dPlot(signalValuesVector;rMax=1.0)
        signalValuesTuple = vector2tuple(signalValuesVector)
        plot(getindex.(signalValuesTuple,1),getindex.(signalValuesTuple,2),getindex.(signalValuesTuple,3),
            label=false)
        plot!(  framestyle = :grid,
            xlims=[-rMax,rMax],
            ylims=[-rMax,rMax],
            zlims=[-rMax,rMax],
            xlabel = "e₁",
            ylabel = "e₂",
            zlabel = "e₃")
        plot!([-rMax,rMax],[0,0],[0,0],color=:black,width=2,label=false)
        plot!([0,0],[-rMax,rMax],[0,0],color=:black,width=2,label=false)
        plot!([0,0],[0,0],[-rMax,rMax],color=:black,width=2,label=false)
    end

    function VV4dPlot(signalValuesVector;rMax=1.0)
        signalValuesTuple = vector2tuple(signalValuesVector)
        p1 = plot(getindex.(signalValuesTuple,1),getindex.(signalValuesTuple,2),
            label=false)
        plot!(  framestyle = :grid,
            xlims=[-rMax,rMax],
            ylims=[-rMax,rMax],
            xlabel = "e₁",
            ylabel = "e₂")
        plot!([-rMax,rMax],[0,0],color=:black,width=2,label=false)
        plot!([0,0],[-rMax,rMax],color=:black,width=2,label=false)
        
        p2 = plot(getindex.(signalValuesTuple,3),zeros(size(getindex.(signalValuesTuple,3))),
            label=false)
            plot!(  framestyle = :grid,
            xlims=[-rMax,rMax],
            ylims=[-rMax,rMax],
            xlabel = "e₃",
            ylabel = "e₄")
        plot!([-rMax,rMax],[0,0],color=:black,width=2,label=false)
        plot!([0,0],[-rMax,rMax],color=:black,width=2,label=false)
        plot(p1, p2,size= [600,300])
    end

    function VV3Danim(signalValues,fileName,Nfade,advance,rMax;Pwob=500,Awob=0)
        allPlots = []
        for i ∈ 1:advance:length(signalValues)-Nfade-advance
            
            mySeriesAlpha = zeros(size(signalValues))
            mySeriesAlpha[i:Nfade+i-1] = range(0,0.15,Nfade)
            signalValuesTuple = vector2tuple(signalValues)
            frame = plot(getindex.(signalValuesTuple,1),getindex.(signalValuesTuple,2),getindex.(signalValuesTuple,3),
                label=false,seriesalpha =mySeriesAlpha,color=:blue)
            plot!([signalValuesTuple[Nfade+i-1][1]],[signalValuesTuple[Nfade+i-1][2]],[signalValuesTuple[Nfade+i-1][3]],
            marker = ".",markersize=1, label=false,markercolor=:blue,color=:blue)
            plot!(  framestyle = :grid,
                xlims=[-rMax,rMax],
                ylims=[-rMax,rMax],
                zlims=[-rMax,rMax],
                xlabel = "e₁",
                ylabel = "e₂",
                zlabel = "e₃")
            plot!([-rMax,rMax],[0,0],[0,0],color=:black,width=1,label=false,seriesalpha=0.5)
            plot!([0,0],[-rMax,rMax],[0,0],color=:black,width=1,label=false,seriesalpha=0.5)
            plot!([0,0],[0,0],[-rMax,rMax],color=:black,width=1,label=false,seriesalpha=0.5)
            plot!(camera=(45+Awob*sin(2π*i/Pwob),30))
            push!(allPlots, frame )
        end
        anim = @animate for i ∈ 1:length(allPlots)
            plot(allPlots[i])
        end
        return gif(anim, fileName, fps = 30)
        end


        function VV4Danim(signalValues,fileName,Nfade,advance,rMax)
            allPlots = []
            for i ∈ 1:advance:length(signalValues)-Nfade-advance
                
                mySeriesAlpha = zeros(size(signalValues))
                mySeriesAlpha[i:Nfade+i-1] = range(0,0.15,Nfade)
                


                signalValuesTuple = vector2tuple(signalValues)
                p1 = plot(getindex.(signalValuesTuple,1),getindex.(signalValuesTuple,2),
                    label=false,seriesalpha =mySeriesAlpha,width=2)
                plot!([signalValuesTuple[Nfade+i-1][1]],[signalValuesTuple[Nfade+i-1][2]],
                    marker = ".",markersize=1, label=false,markercolor=:blue,color=:blue)
                plot!(  framestyle = :grid,
                    xlims=[-rMax,rMax],
                    ylims=[-rMax,rMax],
                    xlabel = "e₁",
                    ylabel = "e₂")
                plot!([-rMax,rMax],[0,0],color=:black,width=1,label=false,seriesalpha=0.5)
                plot!([0,0],[-rMax,rMax],color=:black,width=1,label=false,seriesalpha=0.5)
                
                p2 = plot(getindex.(signalValuesTuple,3),zeros(size(getindex.(signalValuesTuple,3))),
                    label=false,seriesalpha =mySeriesAlpha,width=2)
                    
                plot!([signalValuesTuple[Nfade+i-1][3]],[0],
                    marker = ".",markersize=1, label=false,markercolor=:blue,color=:blue)
                plot!(  framestyle = :grid,
                    xlims=[-rMax,rMax],
                    ylims=[-rMax,rMax],
                    xlabel = "e₃",
                    ylabel = "e₄")
                plot!([-rMax,rMax],[0,0],color=:black,width=1,label=false,seriesalpha=0.5)
                plot!([0,0],[-rMax,rMax],color=:black,width=1,label=false,seriesalpha=0.5)
                frame = plot(p1, p2,size= [600,300])
                push!(allPlots, frame )
            end
            anim = @animate for i ∈ 1:length(allPlots)
                plot(allPlots[i])
            end
            return gif(anim, fileName, fps = 30)
            end

    export VV3dPlot, VV4dPlot, VV3Danim, VV4Danim
