using Documenter
using VVGA

makedocs(
    sitename = "VVGA",
    format = Documenter.HTML(),
    modules = [VVGA],
    pages=[
        "Home" => "index.md",
        "VVSignals" => "signals/signal.md",
        "Cite" => "cite.md",
    ],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/mantodas/VVGA.jl"
)
