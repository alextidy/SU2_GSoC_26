# Assignment 3: Python Wrapper
## Motivation
The Python wrapper enables modelling of customisable boundary conditions, which is an incredibly powerful tool for a variety of applications - for example, to prescribe a fully-developed pipeflow velocity profile without needing to add a simulated pipe region.

<br />

## Setup
The FlatPlate_Script.py and FlatPlate_Config.cfg files were sourced from the provided link and modified. The plate_mesh.su2 mesh was created using gmsh, similarly to in Assignment 2, with clustering at the plate leading edge. The mesh consists of a plate, a leadup section, an inlet, outlet, and farfield top wall.

### Boundary Conditions

The config file was missing BC definitions. They were implemented as follows:

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
- Isothermal wall, with base temperature = 293 [K] (overriden by Python script)

A low M was chosen to limit transient / complex behaviour of the fluid response, allowing for faster convergence to a steady state and thus easier validation of the custom boundary conditions.

In the Python wrapper, a time-variant temperature boundary condition was prescribed for the plate using the formula:

    T = 293 + 57sin(20pi*t)
The solver was run for 100 timesteps of 0.003s, with a flow_[step_number].vtk file output at every step to closely observe the expected sinusoidal varation of temperature with time.

### Running the Solver
The Python wrapper was run using the command:

    python FlatPlate_Script_SpatialT.py --parallel -f FlatPlate_Config.cfg


## Results
To validate the functionality of the wrapper, the period of simulated temperature changes was compared against the analytical period. From this it was expected that 3 full periods of temperature oscillations would be visible in the simulation. The transient reponse (see temp_time.mp4 file in repo) matches this perfectly, confirming the successful implementation of the Python wrapper.
