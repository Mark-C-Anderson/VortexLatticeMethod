# Purpose: test the VLM code and make sure it's working

# To include this file:
# include("Box/FLOW Lab/Modules MCA/VortexLatticeMethod/src/VLM_test.jl")

using Pkg; Pkg.add("Revise"); using Revise;
Pkg.develop(PackageSpec(path = "/Users/markanderson/Box/FLOW Lab/Modules MCA/VortexLatticeMethod"))
import VortexLatticeMethod.VLM

using Pkg
Pkg.add("PyPlot")
using PyPlot

include("generatePanels.jl")
include("plotPanels.jl")
include("plotLiftDistribution.jl")
include("plotInducedDragDistribution.jl")

# Bertin's Wing Geometry
firstCoordinate  = [0.000, 0.000, 0.000];
secondCoordinate = [0.500, 0.500, 0.000];
thirdCoordinate  = [0.700, 0.500, 0.000];
fourthCoordinate = [0.200, 0.000, 0.000];

# Tail Geometry
offset = [2,0,0]
scale = 0.5
firstCoordinateTail  = [0.000, 0.000, 0.000].*scale + offset
secondCoordinateTail = [0.500, 0.500, 0.000].*scale + offset
thirdCoordinateTail  = [0.700, 0.500, 0.000].*scale + offset
fourthCoordinateTail = [0.200, 0.000, 0.000].*scale + offset

numPanelsSpan = 20
numPanelsChord = 10
wingGeometry = generatePanels(firstCoordinate, secondCoordinate, thirdCoordinate, fourthCoordinate, numPanelsSpan,numPanelsChord)
#tailGeometry = generatePanels(firstCoordinateTail, secondCoordinateTail, thirdCoordinateTail, fourthCoordinateTail, numPanelsSpan)
#geometry = cat(dims = 1, wingGeometry,tailGeometry)
#plotPanels(wingGeometry)

alpha = 4.2 # Degrees
angleOfAttack = alpha*pi/180

sideslipAngle = 0 # Degrees
sideslipAngle = sideslipAngle*pi/180

CL, CD, cl, cd, CLSpanLocations = VLM(wingGeometry,angleOfAttack,sideslipAngle);

println("CL = ",CL)
println("CD = ",CD)

# figure()
# scatter(CLSpanLocations,cl,marker = ".")

figure()
plotLiftDistribution(wingGeometry,cl)

# figure()
# plotInducedDragDistribution(wingGeometry,cd)