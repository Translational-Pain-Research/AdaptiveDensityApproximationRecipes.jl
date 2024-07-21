# AdaptiveDensityApproximationRecipes.jl

[<img src="AdaptiveDensityApproximation-docs.svg" style="height: 2em;">](https://antibodypackages.github.io/AdaptiveDensityApproximation-documentation/)

A [Julia](https://julialang.org/) package with [`Plots.jl`](https://docs.juliaplots.org/stable/)-recipes for [`AdaptiveDensityApproximation.jl`](https://github.com/AntibodyPackages/AdaptiveDensityApproximation.jl).

<img src="example.svg" style="height: 15em;">

## Installation

The package can be installed with the following commands

```julia
using Pkg
Pkg.Registry.add()
Pkg.Registry.add(RegistrySpec(url = "https://github.com/AntibodyPackages/AntibodyPackagesRegistry"))
Pkg.add("AdaptiveDensityApproximationRecipes")
```
Since the package is not part of the `General` registry the commands install the additional registry `AntibodyPackagesRegistry` first.

After the installation, the package can be used like any other package:
```julia
using AdaptiveDensityApproximationRecipes
```

## Resources

* **Documentation** (AdaptiveDensityApproximation.jl): [https://antibodypackages.github.io/AdaptiveDensityApproximation-documentation/](https://antibodypackages.github.io/AdaptiveDensityApproximation-documentation/)

* **Documentation** (Plotting): [https://antibodypackages.github.io/AdaptiveDensityApproximation-documentation/plotting_basics/](https://antibodypackages.github.io/AdaptiveDensityApproximation-documentation/)

