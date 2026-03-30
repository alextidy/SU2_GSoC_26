# Assignment 3: Python Wrapper
## Setup
The FlatPlate_Script.py and FlatPlate_Config.cfg files were sourced from the provided link and modified. The plate_mesh.su2 mesh was created using gmsh, similarly to in Assignment 2, with clustering at the plate leading edge. The mesh consists of a plate, a leadup section, an inlet, outlet, and farfield top wall.

The config file was missing BC definitions. To fix this, they were used as follows:

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

A low M was chosen to limit transient / complex behaviour of the fluid response, allowing for faster convergence to a steady state and thus easier validation of the custom boundary conditions.

In the Python wrapper, a time-variant temperature boundary condition was prescribed for the plate using the formula:

    T = 293 + 57sin(20pi*t)
The solver was run for 100 timesteps of 0.003s to observe temperature oscillations.

## Results
To validate the functionality of the wrapper, the period of simulated temperature changes was compared against the analytical period. From this it was expected that 3 full periods of temperature oscillations would be visible in the simulation. The transient reponse (see temp_time.mp4 file in repo) matches this perfectly, confirming the successful implementation of the Python wrapper.
