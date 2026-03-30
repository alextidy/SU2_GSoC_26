# Assignment 3: Python Wrapper
## Setup
.py and .cfg files were sourced from the provided link. The mesh was created using gmsh, similarly to in Assignment 2, with clustering at the plate leading edge. The mesh consists of a plate, a leadup section, an inlet, outlet, and farfield top wall.

The config file was missing BC definitions. To fix this, the boundary conditions were used as follows:
Inlet:
- M = 0.2
- p = 118309 [Pa]
- Turbulence intensity = 0.4%
- Eddy viscosity ratio = 1
Outlet:
- p = 101325 [Pa]
Top wall:
- farfield
Leadup:
- symmetry
Plate:
- Isothermal wall, with base temperature = 293 [K]

In the Python wrapper, a time-variant temperature boundary condition was prescribed for the plate:
'''
T = 293 + 57sin(20pi*t)
'''
The solver was run for 100 timesteps of 0.003s.

## Results
To validate the wrapper, the period of simulated temperature changes was compared against the analytical period. It is expected that 3 full periods of oscillation will be visible in the simulation. The transient reponse (see .mp4 file in repo) matches this perfectly, confirming the successful implementation of the Python wrapper.