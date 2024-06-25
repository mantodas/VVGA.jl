using Documenter
using VVGA

makedocs(
    sitename = "VVGA",
    format = Documenter.HTML(),
    modules = [VVGA]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/mantodas/VVGA.jl"
)
