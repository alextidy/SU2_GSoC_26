# Assignment 1: Compiling and Installing
Nothing of note. A build with Python wrapper = true and MPI enabled was used for the following tasks.


# Assignment 2: Steady, Axisymmetric Turbulent Jet

## Mesh
The mesh was created in gmsh by scripting a .geo file (see repo) and converting to .su2. Whilst an expanding, trapezoidal flow domain would be better to save comptue, an rectangular, axisymmetric channel was used for ease of scripting and adjusting the mesh. A wall above the axis of symmetry was included to develop an turbulent pipe flow velocity profile at the inlet.

A mesh convergence study was conducted to confirm mesh independance 


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
- Velocity = 2 [m/s] (calculated from inlet Re = 2000)
- Turbulence intensity = 20%
- Eddy viscosity ratio = 500

Coflow inlet:
- Velocity = 0.05 [m/s]
- Turbulence intensity = 5%
- Eddy viscosity ratio = 10

Using coflow velocity = 0 (as in the experiment) caused instant NaN's. A sizeable non-zero coflow velocity prevented this. 

The turbulence intensity and eddy viscosity ratio is also extremely high. Initial runs yielded a much slower decay of axial velocity than given in the experimental results. This is because the paper suggests a fully turbulent jet of water from a pipe at Re=2000 - below the empirical Re_transition = 2300 for turbulent pipe flow. It is thus implied that, intentionally or through pipe bends, roughness, vibrations etc., the flow is tripped, leading to a fully turbulent jet at a low Re. These turbulence parameters emulate this effect in SU2, producing results consistent with experimental data.


### Numerical Models
INC_RANS with SST was used as it is the typical solver of choice for this problem, sporting a good balance between shear layer / expansion accuracy and compute. NUM_METHOD_GRAD= WEIGHTED_LEAST_SQUARES was used to ensure accuracy on the non-uniform grid, which LEAST_SQUARES can struggle with.

For the turbulent method, 1st-order CONV_NUM_METHOD_TURB= SCALAR_UPWIND was used to ensure stability - the limiting factor of this problem.

CFL = 0.5 with CFL_ADAPT= YES and CFL_REDUCTION_TURB was used to prevent divergence from too high an initial CFL, and actively accelerate the simulation whilst preventing CFL overshoots from adaptation.

Linear solver options:
- LINEAR_SOLVER= FGMRES
- LINEAR_SOLVER_PREC= ILU
- LINEAR_SOLVER_ERROR= 1E-6
- LINEAR_SOLVER_ITER= 20
20 iterations with a low tolerance was chosen as a compromise between the stability offered by the linear solver for this highly stiff problem and computational speed.


### Stability
The following convergence parameters were used:
- CONV_FIELD= RMS_PRESSURE, RMS_VELOCITY-X, RMS_VELOCITY-Y, RMS_TKE
- CONV_RESIDUAL_MINVAL= -7.5
RMS_TKE was included to monitor the turbulence model, as the correct functional forms for U_axial, U_radial can be achieved with the other 3 residuals converged, even if a poor turbulence model drives incorrect fitting parameters.


### Results
Mesh convergence was confirmed using 3 different fidelity models.
![Results not found](https://raw.githubusercontent.com/Codecademy/docs/main/media/codey.jpg)


The axial and radial distributions followed the theoretical asymptotic behaviour and showed good agreement with experimental data from [1]. 
![Results not found](https://raw.githubusercontent.com/Codecademy/docs/main/media/codey.jpg)



### References
[1] https://www.researchgate.net/publication/254224677_Investigation_of_the_Mixing_Process_in_an_Axisymmetric_Turbulent_Jet_Using_PIV_and_LIF







