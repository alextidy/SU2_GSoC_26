# GSoC SU2 Assignments


## Assignment 1: Compiling and Installing
Nothing of note. A build with Python wrapper = true and MPI enabled was used for the following tasks.


## Assignment 2: Steady, Axisymmetric Turbulent Jet
### Mesh
A .geo file (see repo) was setup and converted to .su2 using gmsh. A 2D trapezoidal mesh was used to minimise number of elements.   


### Solver Setup
The stream was modelled as incompressible (M<<0.3).

SST was chosen as the turbulence model, due to []. 

Turbulent jet flow into a  Therefore, a non-zero axial velocity of 0.05 m/s was used. 


### Results and Observations

During simulation runs, a value of A ~50% larger than experimental was first observed, indicating the simulation did not reflect the same turbulent strength as the experiment.

For axial velocity, experimental data [1] gives:
$$ 
\frac{U}{U_0} = 
$$

![Results not found](https://raw.githubusercontent.com/Codecademy/docs/main/media/codey.jpg)

The axial distribution followed the theoretical asymptotic behaviour and matched experimental data from [].

The radial distribution was slightly less well-matched. This is because ...



## Assignment 3: Python Wrapper
.py and .cfg files were sourced from the provided link. The mesh was used from the Turbulent Flat Plate Test Case (suiting the turbu6lent nature of the problem suggested by the use of SOLVER= RANS).
Config file was missing BC definition. 


## Assignment 4: Spatially Varying Wall Temperature for a Steady-State Compressible Turbulent Flat Plate Testcase



