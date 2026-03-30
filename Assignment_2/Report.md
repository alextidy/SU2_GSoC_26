# Assignment 2: Steady, Axisymmetric Turbulent Jet
## Mesh
The mesh was created in gmsh by scripting a .geo file (see repo) and converting to .su2. Whilst an expanding, trapezoidal flow domain would be better to save comptue, an rectangular, axisymmetric channel was used for ease of scripting and adjusting the mesh. A wall above the axis of symmetry was included to develop an turbulent pipe flow velocity profile at the inlet.

Multiple runs were performed on an increasingly fine mesh to confirm independance of results on the mesh.


## Solver Setup

### Fluid Properties
The fluid was modelled using CONSTANT_DENSITY and CONSTANT_VISCOSITY (water at low speed is incompressible; no heat transfer). Values were assumed to be sea level atmospheric:
- Density = 998.2 [kg/m^3]
- Dynamic viscosity = 1.0E-3 [Pa s]

### Flow Conditions
Flow conditions were taken from experimental data [1]; otherwise assumed atmospheric at sea level:
- Temperature = 293 [K]
- Jet diameter = 1 [mm]

Inlet conditions are as follows:
Jet inlet:
- Velocity = 4.17 [m/s]
- Turbulence intensity = 4%
- Eddy viscosity ratio = 5

Coflow inlet:
- Velocity = 0.0 [m/s]
- Turbulence intensity = 0.4%
- Eddy viscosity ratio = 1

Originally, using a coflow velocity = 0 (as in the experiment) caused instant NaN's. However, changing the initial velocicty field and choosing a larger value CFL number seemed to fix this. The coflow inlet was kept to enable experimentation during simulations.

Additionally, the paper suggests Re=2000 at the inlet. However, this produced extremely poor results for the 1/x decay of velocity, and is empirically far below turbulent flow. Inlet velocity was therefore increased until a realistic result was achieved.


### Numerical Models
INC_RANS with SST was used as it is the typical solver of choice for this problem, sporting a good balance between shear layer / expansion accuracy and compute. NUM_METHOD_GRAD= WEIGHTED_LEAST_SQUARES was used to ensure accuracy on the non-uniform grid, which LEAST_SQUARES can struggle with.

For the turbulent method, 1st-order CONV_NUM_METHOD_TURB= SCALAR_UPWIND was used to ensure stability - the limiting factor of this problem.

CFL = 200 with CFL_REDUCTION_TURB= 0.5 was used to converge as quickly as possible to the solution without diverging.

Linear solver options:
- LINEAR_SOLVER= FGMRES
- LINEAR_SOLVER_PREC= ILU
- LINEAR_SOLVER_ERROR= 1E-5
- LINEAR_SOLVER_ITER= 5
5 iterations with a moderate tolerance was chosen as a compromise between the stability offered by the linear solver for this highly stiff problem and computational speed.


### Stability
The following convergence parameters were used:
- CONV_FIELD= RMS_PRESSURE, RMS_VELOCITY-X, RMS_VELOCITY-Y, RMS_TKE
- CONV_RESIDUAL_MINVAL= -7.5
RMS_TKE was included to monitor the turbulence model, as the correct functional forms for U_axial, U_radial can be achieved with the other 3 residuals converged, even if a poor turbulence model drives incorrect fitting parameters.


### Results
The axial and radial distributions followed the theoretical asymptotic behaviour and showed good agreement with experimental data from [1]. 
![Results not found](axial.png)
![Results not found](radial.png)

Residuals were seen to converge satisfactorily.
![Results not found](residuals.png)

### References
[1] https://www.researchgate.net/publication/254224677_Investigation_of_the_Mixing_Process_in_an_Axisymmetric_Turbulent_Jet_Using_PIV_and_LIF
